import math
import os
import time

import cv2
import numpy as np
from imutils.video import FPS

from helpers.config import *
from helpers.stream import Stream

# from helpers.keypoints import *


class Detector:
    def __init__(self):
        self.cache = None
        self.featureExtractor = cv2.ORB_create()
        # self.featureExtractor = cv2.BRISK()
        self.featureExtractorSupport = cv2.xfeatures2d.BEBLID_create(0.75)
        self.videoCapture = None
        self.frame = None
        self.maxMatchingsData = None
        self.maxMatchings = 0
        self.detectedCurrency = None
        self.maxMatching = None
        self.kp = None
        self.des = None
        self.matchesSummary = {}
        index_params = dict(algorithm=6,
                            table_number=6,
                            key_size=12,
                            multi_probe_level=1)
        search_params = dict(checks=50)
        # self.matcher = cv2.FlannBasedMatcher(index_params, search_params)
        self.matcher = cv2.DescriptorMatcher_create(
            cv2.DescriptorMatcher_BRUTEFORCE_HAMMING)

    def start(self):

        start = time.time()
        print('Started Sampling')
        self.getSampleData()
        end = time.time()
        print('Done sampling :', end-start)
        self.videoCapture = Stream(src=0).start()
        self.fps = FPS().start()

    def getSampleData(self):
        self.cache = {}

        for currencyValue in os.listdir(BASE_DIR):
            data = []
            for currencySampleImageName in os.listdir(BASE_DIR + os.sep + currencyValue):
                currencyTrainImagePath = BASE_DIR + os.sep + \
                    currencyValue + os.sep + currencySampleImageName
                currencyTrainImage = cv2.imread(
                    currencyTrainImagePath, cv2.IMREAD_GRAYSCALE)
                self.getFeatures(currencyTrainImage)
                data.append([currencyTrainImage, (
                    self.kp, self.des)])
            self.cache[currencyValue] = data

    def getFeatures(self, image):
        start = time.time()
        self.image = image
        keypoints = self.featureExtractor.detect(self.image, None)
        self.kp, self.des = self.featureExtractorSupport.compute(
            self.image, keypoints)
        # self.kp, self.des = self.featureExtractor.detectAndCompute(self.image, None)
        # self.matcher.add(self.des)

        end = time.time()
        # print('[DEBUG] Get Features :', end-start)

    def filterFalsePositives(self, foundMatchings):

        try:
            self.foundMatchings = foundMatchings
            if not self.foundMatchings:
                return []

            self.good = []
            for m, n in self.foundMatchings:
                if m.distance < 0.7 * n.distance:
                    self.good.append(m)

        except ValueError as error:
            # print('[ERROR] Filter False Positive : ', error)
            pass
        return self.good

    def getMatchingPoints(self, queryImageDes, trainImageDes):
        self.queryImageDes = queryImageDes
        self.trainImageDes = trainImageDes
        if self.queryImageDes is None or len(self.queryImageDes) == 0:
            return []
        if self.trainImageDes is None or len(self.trainImageDes) == 0:
            return []
        try:
            result = self.filterFalsePositives(self.matcher.knnMatch(
                self.queryImageDes, self.trainImageDes, k=2))
            return result
        except cv2.error as error:
            # print('[ERROR] Get Matching Points: ', error)
            pass

    def buildHomographyInputData(self):
        if not (self.maxMatchingsData is None):
            queryImageData = self.maxMatchingsData[1]
            self.queryImageKeypoints = queryImageData[1][0]
            self.matches = self.maxMatchingsData[0]
            self.queryImageShape = queryImageData[0].shape

    def getPossibleCurrency(self):
        try:
            self.maxMatchingsCurrency = 0
            self.maxMatchings = 0
            self.detectedCurrency = 0
            self.maxMatching = 0

            self.getFeatures(self.frame)

            for currencyValue, images in self.cache.items():
                totalMatches = 0
                for imageData in images:
                    matches = self.getMatchingPoints(imageData[1][1], self.des)
                    countMatches = len(matches)

                    if countMatches > self.maxMatchings:
                        self.maxMatchings = countMatches
                        self.maxMatchingsCurrency = currencyValue
                        self.maxMatchingsData = (matches, imageData)

                    totalMatches += countMatches
                    self.matchesSummary[currencyValue] = totalMatches

            self.buildHomographyInputData()
            if not (self.maxMatchingsCurrency is None) and self.maxMatchings > MIN_MATCH_COUNT:
                self.detectedCurrency = self.maxMatchingsCurrency
                self.maxMatching = self.maxMatchings
            self.homographyData = (self.queryImageShape,
                                   self.queryImageKeypoints, self.kp, self.matches)
            self.matchingSummary = self.matchesSummary
        except Exception as error:
            pass

    def drawMatchingSummary(self):
        origin = [50, 50]
        for k, v in self.matchesSummary.items():
            displayText = "{}: {}".format(k, v)
            self.image = cv2.putText(self.image, displayText, tuple(
                origin), cv2.FONT_HERSHEY_SIMPLEX, 2, (0, 0, 0), 3)
            origin[1] += 50

        return self.image

    def highlightBill(self):
        try:
            src_pts = np.float32(
                [self.queryImageKeypoints[m.queryIdx].pt for m in self.matches]).reshape(-1, 1, 2)
            dst_pts = np.float32(
                [self.kp[m.trainIdx].pt for m in self.matches]).reshape(-1, 1, 2)
            matrix, mask = cv2.findHomography(
                src_pts, dst_pts, cv2.RANSAC, 5.0)

            if not (matrix is None) and matrix.size > 0:
                h, w = self.queryImageShape
                pts = np.float32(
                    [[0, 0], [0, h - 1], [w - 1, h - 1], [w - 1, 0]]).reshape(-1, 1, 2)
                dst = cv2.perspectiveTransform(pts, matrix)

                origin = dst[0][0]
                font_x = math.floor(origin[0] - CURRENCY_DISPLAY_OFFSET_X)
                font_y = math.floor(origin[1] - CURRENCY_DISPLAY_OFFSET_Y)
                font_position = (font_x, font_y)
                self.frame = cv2.putText(self.frame, self.detectedCurrency, font_position, cv2.FONT_HERSHEY_SIMPLEX, 2,
                                         CURRENCY_DISPLAY_COLOR, 2)

                return cv2.polylines(self.frame, [np.int32(dst)], True, CURRENCY_CONT_COLOR, CURRENCY_CONT_THINKNESS,
                                     cv2.LINE_AA)
            else:
                if DEBUG:
                    print("Couldn't create matrix")
        except Exception as e:
            if DEBUG:
                print("Exception in highlight function: {}".format(e))

    def processFrame(self):

        self.colorFrame = self.frame
        self.frame = cv2.cvtColor(self.frame, cv2.COLOR_BGR2GRAY)

        self.getPossibleCurrency()

    def detect(self):

        self.frame = self.videoCapture.read()

        self.processFrame()
        if DEBUG:
            cv2.imshow("frame", self.frame)
        key = cv2.waitKey(1)
        self.fps.update()

    def stop(self):
        self.fps.stop()
        print("[INFO] elasped time: {:.2f}".format(self.fps.elapsed()))
        print("[INFO] approx. FPS: {:.2f}".format(self.fps.fps()))
        self.videoCapture.stop()
        cv2.destroyAllWindows()
