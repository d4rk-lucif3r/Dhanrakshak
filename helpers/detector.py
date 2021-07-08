from itertools import count
from imutils.video import FPS
from threading import Thread, Lock
import cv2
import math
import numpy as np
import queue


from helpers.config import *
from imutils.video import FPS
import imutils
import os


featureExtractor = cv2.ORB_create()
featureExtractor2 = cv2.xfeatures2d.BEBLID_create(0.80)
# featureExtractor = cv2.xfeatures2d.SIFT_create()
count = 0
# Create matcher
videoCapture = None
FLANN_INDEX_KDITREE = 0
flannParam = dict(algorithm=0, tree=5)
search_params = dict(checks=50)
# matcherBruteForce = cv2.FlannBasedMatcher(flannParam, search_params)
# matcherBruteForce = cv2.BFMatcher()
matcherBruteForce = cv2.DescriptorMatcher_create(cv2.DescriptorMatcher_BRUTEFORCE_HAMMING)
homography = None


def getFeatures(image, vector_size = 32):
    # find keypoints
    keypoints = featureExtractor.detect(image, None)

    # find descriptors for each keypoints
    kp, des = featureExtractor2.compute(image, keypoints)
    print(type(des))
    des = des.flatten()
    needed_size = (vector_size * 128)
    if des.size < needed_size :
        des = np.concatenate([des, np.zeros(needed_size - des.size)])
    
    # kp, des = pack_keypoint(kp, des)
    # np.save('keypoints', np.hstack((kp, des)))
    # featureExtractor.detectAndCompute(image, None)
    
    return kp, des


def drawKeypointOnIamge(image, keyPoints):
    cv2.drawKeypoints(image, keyPoints, image,
                      color=KEYPOINT_DRAW_COLOR, flags=0)


def filterFalsePositives(foundMatchings):
    if not foundMatchings:
        return []

    good = []
    try:
        for m, n in foundMatchings:
            if m.distance < 0.7 * n.distance:
                good.append(m)

    except ValueError:
        pass
    return good


def drawMatches(img1, kp1, img2, kp2, matches):
    return cv2.drawMatches(img1, kp1, img2, kp2, matches, None, flags=cv2.DrawMatchesFlags_NOT_DRAW_SINGLE_POINTS)


def getMatchingPoints(queryImageDes, trainImageDes):
    # No descriptors, no matchings
    if queryImageDes is None or len(queryImageDes) == 0:
        return []

    if trainImageDes is None or len(trainImageDes) == 0:
        return []

    # We're using knnMatch because this method will return the best 2 matches for the queryDescriptor
    # whereas the brute force method(the simple one) wouldn't consider an match if he couldn't find it
    return filterFalsePositives(matcherBruteForce.knnMatch(queryImageDes, trainImageDes, k=2))


def buildHomographyInputData(inputImageKp, maxMatchingsData):
    if not (maxMatchingsData is None):
        queryImageData = maxMatchingsData[1]
        queryImageKeypoints = queryImageData[1][0]
        matches = maxMatchingsData[0]
        queryImageShape = queryImageData[0].shape
        return (queryImageShape, queryImageKeypoints, inputImageKp, matches)


def getPossibleCurrency(sampleData, inputImageGray,que = None,colorFrame = None ):
    # In this dictionary we'll save, for each currency available, how many matches were found
    # Based on this we can compute a 'confidence' metric for the current image
    matchesSummary = {}

    maxMatchings = 0
    maxMatchingsData = None
    maxMatchingsCurrency = None

    # Precompute these values!
    kp, des = getFeatures(inputImageGray)

    for currencyValue, images in sampleData.items():
        totalMatches = 0
        for imageData in images:
            matches = getMatchingPoints(imageData[1][1], des)
            countMatches = len(matches)

            if countMatches > maxMatchings:
                maxMatchings = countMatches
                maxMatchingsCurrency = currencyValue
                maxMatchingsData = (matches, imageData)

            totalMatches += countMatches
            matchesSummary[currencyValue] = totalMatches
    global count
    global homography
    # if count == 0:
    #     homography = buildHomographyInputData(kp, maxMatchingsData)
    #     count =1
    homography = buildHomographyInputData(kp, maxMatchingsData)
    ret = ( homography, 
        matchesSummary, maxMatchings, maxMatchingsCurrency)
    # homographyData = buildHomographyInputData(kp, maxMatchingsData)
    # if not (maxMatchingsCurrency is None) and maxMatchings > MIN_MATCH_COUNT:
    #     print("Detected currency is {} with {} matches".format(
    #         maxMatchingsCurrency, maxMatchings))

    # if DEBUG:
    #     if not (homographyData is None):
    #         colorFrame = highlightBill(
    #             colorFrame, maxMatchingsCurrency, *homographyData)
    #     colorFrame = drawMatchingSummary(colorFrame, matchesSummary)
    # else:
    #     print("No currency detected")   
    return ret


def drawMatchingSummary(image, matchesSummary):
    origin = [50, 50]
    for k, v in matchesSummary.items():
        displayText = "{}: {}".format(k, v)
        image = cv2.putText(image, displayText, tuple(
            origin), cv2.FONT_HERSHEY_SIMPLEX, 2, (0, 0, 0), 3)
        origin[1] += 50

    return image


def highlightBill(frame, detectedCurrency, queryImageShape, kp1, kp2, matches):
    try:
        src_pts = np.float32(
            [kp1[m.queryIdx].pt for m in matches]).reshape(-1, 1, 2)
        dst_pts = np.float32(
            [kp2[m.trainIdx].pt for m in matches]).reshape(-1, 1, 2)
        matrix, mask = cv2.findHomography(src_pts, dst_pts, cv2.RANSAC, 5.0)

        if not (matrix is None) and matrix.size > 0:
            h, w = queryImageShape
            pts = np.float32(
                [[0, 0], [0, h - 1], [w - 1, h - 1], [w - 1, 0]]).reshape(-1, 1, 2)
            dst = cv2.perspectiveTransform(pts, matrix)

            # Put a label with the detected currency
            origin = dst[0][0]
            font_x = math.floor(origin[0] - CURRENCY_DISPLAY_OFFSET_X)
            font_y = math.floor(origin[1] - CURRENCY_DISPLAY_OFFSET_Y)
            font_position = (font_x, font_y)
            frame = cv2.putText(frame, detectedCurrency, font_position, cv2.FONT_HERSHEY_SIMPLEX, 2,
                                CURRENCY_DISPLAY_COLOR, 2)

            # draw the rectangle
            # NOTE: dst is actually the list of points needed to be able to draw
            return cv2.polylines(frame, [np.int32(dst)], True, CURRENCY_CONT_COLOR, CURRENCY_CONT_THINKNESS,
                                 cv2.LINE_AA)
        else:
            if DEBUG:
                print("Couldn't create matrix")
            return frame
    except Exception as e:
        if DEBUG:
            print("Exception in highlight function: {}".format(e))
        return frame


def processFrame(frame, cache):
    
    colorFrame = frame
    frame = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    # detectThread = Thread(target=getPossibleCurrency , args=(cache, frame))
    homographyData, matchingSummary, maxMatching, detectedCurrency = getPossibleCurrency(
        cache, frame)
    # homographyData, matchingSummary, maxMatching, detectedCurrency = detectThread.start()
    

    if not (detectedCurrency is None) and maxMatching > MIN_MATCH_COUNT:
        print("Detected currency is {} with {} matches".format(
            detectedCurrency, maxMatching))

        if not (homographyData is None):
            colorFrame = highlightBill(
                colorFrame, detectedCurrency, *homographyData)
        if DEBUG:
            colorFrame = drawMatchingSummary(colorFrame, matchingSummary)

    else:
        print("No currency detected")
    return colorFrame




class WebcamVideoStream:
    
    def __init__(self, src=0):
        # initialize the video camera stream and read the first frame
        # from the stream
        self.stream = cv2.VideoCapture(src)
        (self.grabbed, self.frame) = self.stream.read()
        # initialize the variable used to indicate if the thread should
        # be stopped
        self.stopped = False

    def start(self):
        # start the thread to read frames from the video stream
        Thread(target=self.update, args=()).start()
        return self

    def update(self):
        # keep looping infinitely until the thread is stopped
        while True:
            # if the thread indicator variable is set, stop the thread
            if self.stopped:
                return
            # otherwise, read the next frame from the stream
            (self.grabbed, self.frame) = self.stream.read()

    def read(self):
        # return the frame most recently read
        return self.frame

    def stop(self):
        # indicate that the thread should be stopped
        self.stopped = True

def realTime(cache):
    
    # videoCapture = cv2.VideoCapture(0)
    videoCapture = WebcamVideoStream(src=0).start()
    frame = None
    colorFrame = None
    fps = FPS().start()
    que = queue.Queue()
    count = 0
    lock = Lock()
    # detectThread = Thread(target=getPossibleCurrency, args=(cache, frame, que, colorFrame))
    # detectThread.start()
    try:
        while 1:
            frame = videoCapture.read()
            # frame = imutils.resize(frame, width=450)
            colorFrame = frame
            
            frame = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
            # homographyData, matchingSummary, maxMatching, detectedCurrency = getPossibleCurrency(
            #     cache, frame)

            processFrame(colorFrame, cache)
            
            # homographyData, matchingSummary, maxMatching, detectedCurrency = getPossibleCurrency(
            #     cache, frame, que, colorFrame)
            # # if count == 0:
            #     # detectThread = Thread(target=getPossibleCurrency, args=(cache, frame, que, colorFrame))
            #     # detectThread.start()
            # #     count = 1
            
            # # homographyData, matchingSummary, maxMatching, detectedCurrency = que.get()
            # if not (detectedCurrency is None) and maxMatching > MIN_MATCH_COUNT:
            #     print("Detected currency is {} with {} matches".format(
            #         detectedCurrency, maxMatching))


                
            #     if not (homographyData is None):
            #             colorFrame = highlightBill(
            #                 colorFrame, detectedCurrency, *homographyData)
            #     if DEBUG:
            #         colorFrame = drawMatchingSummary(colorFrame, matchingSummary)
            # else:
            #     print("No currency detected")

            cv2.imshow("frame", colorFrame)
            key = cv2.waitKey(1)
            fps.update()
            

            # if the user pressed the key designated for closing: CLOSE_KEY
            if key == CLOSE_KEY:

                break
    except KeyboardInterrupt:
        fps.stop()
        print("[INFO] elasped time: {:.2f}".format(fps.elapsed()))
        print("[INFO] approx. FPS: {:.2f}".format(fps.fps()))
        videoCapture.stop()
        
        cv2.destroyAllWindows()
        
def main():
    # import utils
    # import time

    # start = time.time()
    # print('Started Sampling')
    # cache = utils.getSampleData()
    # end = time.time()
    # print('Done sampling :', end-start )
    realTime(None)
    # fps = FPS().start()
    # videoCapture = WebcamVideoStream(src=0).start()
    # try:
    #     while 1:
    #         frame = videoCapture.read()
    #         frame = imutils.resize(frame, width=450)
    #         # frame = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    #         processFrame(frame, cache)
    #         cv2.imshow("frame", frame)
    #         key = cv2.waitKey(1)
    #         fps.update()
    # except KeyboardInterrupt:
    #     fps.stop()
    #     print("[INFO] elasped time: {:.2f}".format(fps.elapsed()))
    #     print("[INFO] approx. FPS: {:.2f}".format(fps.fps()))
    #     videoCapture.stop()
        
    #     cv2.destroyAllWindows()

if __name__ == "__main__":

    main()

