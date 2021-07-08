import os
import cv2
from helpers.detector import getFeatures, read_features_from_file
from helpers.config import *
import json
import pickle
import numpy as np
import ast
# Precalculates and cache the keydatas along with the descriptors for EACH training currency


def getSampleData():
    cache = {}

    for currencyValue in os.listdir(BASE_DIR):
        data = []
        for currencySampleImageName in os.listdir(BASE_DIR + os.sep + currencyValue):
            currencyTrainImagePath = BASE_DIR + os.sep + \
                currencyValue + os.sep + currencySampleImageName
            currencyTrainImage = cv2.imread(
                currencyTrainImagePath, cv2.IMREAD_GRAYSCALE)
            data.append([currencyTrainImage, tuple(
                getFeatures(currencyTrainImage))])
        cache[currencyValue] = data

    return cache


if __name__ == '__main__':
    cache = {}
    # file = open("keydatas.txt", "rb")
    # contents = file.read()
    # dictionary = pickle.loads(contents)
    # print(type(dictionary))
    cache = getSampleData()
    try:
        filehandler = open('keydatas.pck', 'wb')
        pickle.dump(cache, filehandler)
    except Exception as error:
        print('error : ', error)
    # np.savetxt("test.txt", cache.items())
    # for currencyValue, images in cache.items():
    #     totalMatches = 0
    #     for imageData in images:
    #         print(imageData[1])
    
            # # im = cv2.imread("/home/bikz05/Desktop/dataset/checkered-3.jpg")
            # # gr = cv2.cvtColor(im, cv2.COLOR_BGR2GRAY)
            # d = cv2.ORB_create()
            # kp = d.detect(im)

            # index = []
            # for data in kp:
            #     temp = (data.pt, data.size, data.angle, data.response, data.octave,
            #             data.class_id)
            #     index.append(temp)
    # print(read_features_from_file('keydatas.npy'))
        # Dump the keydatas
        # cv_file = cv2.FileStorage('test.xml', cv2.FILE_STORAGE_WRITE)
        # cv_file.write('cache',data)
        # cv_file.release()
        # f = open("keydatas.xml", "wb")
        # f.write(pickle.dumps(cache))
        # f.close()
    # # print(cache.items())
    # with open('convert.txt', 'w') as convert_file:
    #  convert_file.write(pickle.dumps(cache))
