#!python
#cython: language_level=3
import random
import time
from multiprocessing import Process

from PySide2.QtCore import QObject, Slot

from helpers.config import *
from helpers.detector import Detector
from helpers.managers.coin_manager import CoinManager
from helpers.managers.note_manager import NoteManager
from helpers.sensors.levelSensor import LevelSensor
from helpers.sensors.limitswitch import LimitSwitch
from helpers.sensors.stepper import Stepper


class Connection(QObject):

    def __init__(self, parent=None):
        QObject.__init__(self, parent)
        self.det_obj = Detector()
        # self.stepper = Stepper(NOTE_DISPENSE_MOTOR_ADDRESS)
        self.limit_switch = LimitSwitch()
        self.level = LevelSensor(LEVEL_SENSOR)
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
        self.stopThread = True
        self.detectThread = Process(target=self.startdetect)

        # self.note_manager = NoteManager()
        self.note_count = {}
        # self.coin_manager = CoinManager()
        # self.note_manager_process = Process(target=self.note_manager.start)
        # self.coin_manager_process = Process(target=self.coin_manager.start)
        # self.detectThread = Thread(target=self.startdetect)
        # self.detectThread.start()
        # self.calibrate()

    def startdetect(self):
        self.calibrate()
        self.det_obj.start()
        while self.stopThread:
            self.det_obj.detect()
            print("[INFO] Detected Currency :{}".format(
                self.det_obj.detectedCurrency))
            print("[INFO] Matching Points :{}".format(
                self.det_obj.maxMatching))
            self.currency = self.det_obj.detectedCurrency
            self.accPoints = self.det_obj.maxMatching

    def calibrate(self):
        '''Calibrates the Dispensing Mechanism'''
        state = self.limit_switch.checkTrigger()
        if state:
            self.stepper.move(1, NOTE_DISPENSE_MOTOR_NUM, direction='Backward')
            state = self.limit_switch.checkTrigger()
            if not state:
                state = self.limit_switch.checkTrigger()
                self.stepper.move(1, HOME_POSITION_OFFSET-20)
                time.sleep(0.5)
                self.stepper.deactivate(NOTE_DISPENSE_MOTOR_NUM)

    @Slot()
    def start(self):
        # self.stopThread = False
        # self.det_obj.start()
        # if self.noteUV or self.noteEthanol:
        #     self.note_manager_process.start()
        # if self.coinUV or self.coinEthanol:
        #     self.coin_manager_process.start()
        print('[INFO] Started')

    @Slot(QObject)
    def splashCheck(self, recieved_object):
        if self.det_obj.sampleCheck:
            recieved_object.setProperty('showSplash', True)

    @Slot(QObject)
    def methodCheck(self, recieved_object):
        self.noteUV = recieved_object.property('noteisUV')
        self.noteEthanol = recieved_object.property('noteisEthanol')
        self.coinUV = recieved_object.property('coinisUV')
        self.coinEthanol = recieved_object.property('coinisEthanol')

    @Slot(QObject)
    def fluidCheck(self, recieved_object):
        if self.level.levelCheck:
            recieved_object.setProperty('visible', True)

    @Slot(QObject)
    def stop(self, recieved_object):
        recieved_object.setProperty('running', False)
        print("[INFO] Stopped")
        # self.det_obj.stop()
        # self.stopThread = False
        # self.detectThread.join()

    @Slot(QObject)
    def noteUpdate(self, recieved_object):

        self.note_count = self.note_manager.result()
        recieved_object.setProperty('tenNote', self.note_count['ten'])
        recieved_object.setProperty('twentyNote', self.note_count['twenty'])
        recieved_object.setProperty('fiftyNote', self.note_count['fifty'])
        recieved_object.setProperty('oneHunNote', self.note_count['hundred'])
        recieved_object.setProperty(
            'twoHunNote', self.note_count['twoHundred'])
        recieved_object.setProperty(
            'fiveHunNote', self.note_count['fiveHundred'])
        recieved_object.setProperty(
            'twoThNote', self.note_count['twoThousand'])

        # if self.currency == '10' and self.accPoints >= MIN_MATCH_COUNT:
        #     self.ten_list.append(10)
        #     recieved_object.setProperty("tenNote", len(self.ten_list))
        # if self.currency == '20' and self.accPoints >= MIN_MATCH_COUNT:
        #     self.twenty_list.append(20)
        #     recieved_object.setProperty("twentyNote", len(self.twenty_list))
        # if self.currency == '50' and self.accPoints >= MIN_MATCH_COUNT:
        #     self.fifty_list.append(50)
        #     recieved_object.setProperty("fiftyNote", len(self.fifty_list))
        # if self.currency == '100' and self.accPoints >= MIN_MATCH_COUNT:
        #     self.hundred_list.append(100)
        #     recieved_object.setProperty("oneHunNote", len(self.hundred_list))
        # if self.currency == '200' and self.accPoints >= MIN_MATCH_COUNT:
        #     self.twohund_list.append(200)
        #     recieved_object.setProperty("twoHunNote", len(self.twohund_list))
        # if self.currency == '500' and self.accPoints >= MIN_MATCH_COUNT:
        #     self.fivehund_list.append(500)
        #     recieved_object.setProperty("fiveHunNote", len(self.fivehund_list))
        # if self.currency == '2000' and self.accPoints >= MIN_MATCH_COUNT:
        #     self.twothousand_list.append(2000)
        #     recieved_object.setProperty(
        #         "twoThNote", len(self.twothousand_list))

    @Slot(QObject)
    def coinUpdate(self, recieved_object):
        self.coin_count = self.coin_manager.result()

        recieved_object.setProperty(
            "twentyCoin", self.coin_count['twenty_coin'])
        recieved_object.setProperty("tenCoin", self.coin_count['ten_coin'])
        recieved_object.setProperty("fiveCoin", self.coin_count['five_coin'])
        recieved_object.setProperty("twoCoin", self.coin_count['two_coin'])
        recieved_object.setProperty("oneCoin", self.coin_count['one_coin'])

        # recieved_object.setProperty("twentyCoin", random.randint(0, 120))
        # recieved_object.setProperty("tenCoin", random.randint(0, 120))
        # recieved_object.setProperty("fiveCoin", random.randint(0, 120))
        # recieved_object.setProperty("twoCoin", random.randint(0, 120))
        # recieved_object.setProperty("oneCoin", random.randint(0, 120))

    @Slot(QObject)
    def progress(self, recieved_object):
        recieved_object.setProperty("progress", random.randint(0, 100))

        note_sum = sum(self.note_count.values()
                       ) if self.noteUV or self.noteEthanol else 0
        coin_sum = sum(self.coin_count.values()
                       ) if self.coinUV or self.coinEthanol else 0
        self.total = note_sum + coin_sum

        # self.total = sum(self.ten_list) + sum(self.twenty_list) + sum(self.fifty_list) + sum(self.hundred_list) + \
        #     sum(self.twohund_list) + sum(self.fivehund_list) + \
        #     sum(self.twothousand_list)
        recieved_object.setProperty("total", self.total)
