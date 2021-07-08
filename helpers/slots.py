from PySide2.QtCore import QObject, Slot
from helpers.detector2 import Detector
from threading import Thread
from helpers.config import *
import random


class ValUpdate(QObject):

    def __init__(self, parent=None):
        QObject.__init__(self, parent)
        self.det_obj = Detector()
        self.currency = 0
        self.accPoints = 0
        self.ten_list = []
        self.ten_list = []
        self.twenty_list = []
        self.fifty_list = []
        self.hundred_list = []
        self.twohund_list = []
        self.fivehund_list = []
        self.twothousand_list = []
        
        
        self.detectThread = Thread(target=self.startdetect)
        self.detectThread.start()
        

    def startdetect(self):
        
        self.det_obj.start()
        while True:
            self.det_obj.detect()
            print("[INFO] Detected Currency :{}".format(
                self.det_obj.detectedCurrency))
            print("[INFO] Matching Points :{}".format(
                self.det_obj.maxMatching))
            self.currency = self.det_obj.detectedCurrency
            self.accPoints = self.det_obj.maxMatching

    def stop(self):
        self.det_obj.stop()

    @Slot(QObject)
    def noteUpdate(self, recieved_object):

        if self.currency == '10' and self.accPoints >= MIN_MATCH_COUNT:
            self.ten_list.append(10)
            recieved_object.setProperty("tenNote", len(self.ten_list))
        if self.currency == '20' and self.accPoints >= MIN_MATCH_COUNT:
            self.twenty_list.append(20)
            recieved_object.setProperty("twentyNote", len(self.twenty_list))
        if self.currency == '50' and self.accPoints >= MIN_MATCH_COUNT:
            self.fifty_list.append(50)
            recieved_object.setProperty("fiftyNote", len(self.fifty_list))
        if self.currency == '100' and self.accPoints >= MIN_MATCH_COUNT:
            self.hundred_list.append(100)
            recieved_object.setProperty("oneHunNote", len(self.hundred_list))
        if self.currency == '200' and self.accPoints >= MIN_MATCH_COUNT:
            self.twohund_list.append(200)
            recieved_object.setProperty("twoHunNote", len(self.twohund_list))
        if self.currency == '500' and self.accPoints >= MIN_MATCH_COUNT:
            self.fivehund_list.append(500)
            recieved_object.setProperty("fiveHunNote", len(self.fivehund_list))
        if self.currency == '2000' and self.accPoints >= MIN_MATCH_COUNT:
            self.twothousand_list.append(2000)
            recieved_object.setProperty(
                "twoThNote", len(self.twothousand_list))
    @Slot(QObject)
    def coinUpdate(self, recieved_object):
        recieved_object.setProperty("twentyCoin", random.randint(0, 120))
        recieved_object.setProperty("tenCoin", random.randint(0, 120))
        recieved_object.setProperty("fiveCoin", random.randint(0, 120))
        recieved_object.setProperty("twoCoin", random.randint(0, 120))
        recieved_object.setProperty("oneCoin", random.randint(0, 120))

    @Slot(QObject)
    def progress(self, recieved_object):
        recieved_object.setProperty("progress", random.randint(0, 100))
        self.total = sum(self.ten_list) + sum(self.twenty_list) + sum(self.fifty_list) + sum(self.hundred_list) + \
            sum(self.twohund_list) + sum(self.fivehund_list) + \
            sum(self.twothousand_list)
        recieved_object.setProperty("total", self.total)
