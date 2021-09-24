#!python
#cython: language_level=3
import random
from multiprocessing import Process

from PySide2.QtCore import QObject, Slot

from helpers.config import *
from helpers.sensors.ir import Ir
from helpers.sensors.levelSensor import LevelSensor
from helpers.sensors.relay import Relay


class Connection(QObject):

    def __init__(self, parent=None):
        QObject.__init__(self, parent)
        self.level = LevelSensor(LEVEL_SENSOR)
        self.lock_relay = Relay(LOCK_RELAY, type=2)
        self.trayIR = Ir(18)
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
        self.note_manager_result = {}
        # self.coin_manager = CoinManager()
        # self.note_manager_process = Process(target=self.note_manager.start)
        # self.coin_manager_process = Process(target=self.coin_manager.start)

    @Slot()
    def start(self):
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
    def unlockTray(self, recieved_object):
        if self.note_manager_result['progress'] == 100:
            recieved_object.setProperty('unlock', True)
            if recieved_object.property('unlockClick'):
                self.lock_relay.on()
                recieved_object.setProperty('unlockClick', False)
                if self.trayIR.detect():
                    self.lock_relay.off()

    @Slot(QObject)
    def stop(self, recieved_object):
        recieved_object.setProperty('running', False)
        print("[INFO] Stopped")
        # self.det_obj.stop()
        # self.stopThread = False
        # self.detectThread.join()

    @Slot(QObject)
    def noteUpdate(self, recieved_object):
        pass
        # self.note_manager_result = self.note_manager.result()
        # recieved_object.setProperty('tenNote', self.note_manager_result['ten'])
        # recieved_object.setProperty('twentyNote', self.note_manager_result['twenty'])
        # recieved_object.setProperty('fiftyNote', self.note_manager_result['fifty'])
        # recieved_object.setProperty('oneHunNote', self.note_manager_result['hundred'])
        # recieved_object.setProperty(
        #     'twoHunNote', self.note_manager_result['twoHundred'])
        # recieved_object.setProperty(
        #     'fiveHunNote', self.note_manager_result['fiveHundred'])
        # recieved_object.setProperty(
        #     'twoThNote', self.note_manager_result['twoThousand'])

    @Slot(QObject)
    def coinUpdate(self, recieved_object):
        pass
        # self.coin_count = self.coin_manager.result()

        # recieved_object.setProperty(
        #     "twentyCoin", self.coin_count['twenty_coin'])
        # recieved_object.setProperty("tenCoin", self.coin_count['ten_coin'])
        # recieved_object.setProperty("fiveCoin", self.coin_count['five_coin'])
        # recieved_object.setProperty("twoCoin", self.coin_count['two_coin'])
        # recieved_object.setProperty("oneCoin", self.coin_count['one_coin'])
    @Slot(QObject)
    def progress(self, recieved_object):
        recieved_object.setProperty("progress", random.randint(0, 100))

        # note_sum = sum(self.note_manager_result.values()
        #                ) if self.noteUV or self.noteEthanol else 0
        # coin_sum = sum(self.coin_count.values()
        #                ) if self.coinUV or self.coinEthanol else 0
        # self.total = note_sum + coin_sum
        self.total = 100
        # self.total = sum(self.ten_list) + sum(self.twenty_list) + sum(self.fifty_list) + sum(self.hundred_list) + \
        #     sum(self.twohund_list) + sum(self.fivehund_list) + \
        #     sum(self.twothousand_list)
        recieved_object.setProperty("total", self.total)
