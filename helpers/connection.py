#!python
# cython: language_level=3
import os
from threading import Thread
from PySide2.QtCore import QObject, Slot

from helpers.config import *
from helpers.managers.coin_manager import CoinManager
from helpers.managers.note_manager import NoteManager
from helpers.sensors.ir import Ir
from helpers.sensors.level_sensor import LevelSensor
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

        self.note_manager = NoteManager()
        self.note_result = {}
        self.coin_manager = CoinManager()

    @ Slot()
    def start(self):
        count = 0
        self.progress = 0
        if self.noteUV or self.noteEthanol:
            print('[UV]', self.noteUV)
            print('[Ethanol]', self.noteEthanol)
            self.note_manager.start(self.noteUV, self.noteEthanol)
            self.detect_thread = Thread(
                target=self.note_manager.detect_note, daemon=False)
            self.detect_thread.start()
        if self.coinUV or self.coinEthanol:
            print('[UV- COIN]', self.coinUV)
            print('[Ethanol -COIN]', self.coinEthanol)
            self.coin_manager.start(self.coinEthanol, self.coinEthanol)
            self.coin_detect_thread = Thread(
                target=self.coin_manager.detect, daemon=False)
            self.coin_detect_thread.start()
        # count = 1
        print('[INFO] Started')

    @ Slot(QObject)
    def splashCheck(self, recieved_object):
        # if self.note_manager.run:
        #     recieved_object.setProperty('showSplash', True)
        pass

    @ Slot(QObject)
    def methodCheck(self, recieved_object):
        self.noteUV = recieved_object.property('noteisUV')
        self.noteEthanol = recieved_object.property('noteisEthanol')
        self.coinUV = recieved_object.property('coinisUV')
        self.coinEthanol = recieved_object.property('coinisEthanol')

    @ Slot(QObject)
    def fluidCheck(self, recieved_object):
        if not self.level.levelCheck():
            recieved_object.setProperty('showLevelCheck', True)

    @ Slot(QObject)
    def trayCheck(self, recieved_object):
        if not self.trayIR.detect():
            recieved_object.setProperty('showTrayCheck', True)
            print('[INFO] Tray Check')

    @ Slot(QObject)
    def unlockTray(self, recieved_object):
        self.progress = self.note_result['progress']
        if self.progress == 100:
            self.start_check = False
            recieved_object.setProperty('unlock', True)
            if recieved_object.property('unlockClick'):
                self.lock_relay.on()
                print('relay on')
                recieved_object.setProperty('unlockClick', False)
                recieved_object.setProperty('unlock', False)
                self.progress = 0

    @ Slot(QObject, QObject)
    def stop(self, recieved_object, recieved_object2):
        recieved_object.setProperty('running', False)
        if self.noteUV or self.noteEthanol:
            self.note_manager.stop_detect_thread = True
            self.detect_thread.join()
            self.note_manager.stop_detect_thread = False
            self.note_manager.result_dict = {}
            self.note_manager.stop()
            recieved_object2.setProperty('tenNote', 0)
        recieved_object2.setProperty(
            'twentyNote', 0)
        recieved_object2.setProperty(
            'fiftyNote', 0)
        recieved_object2.setProperty(
            'oneHunNote', 0)
        recieved_object2.setProperty(
            'twoHunNote', 0)
        recieved_object2.setProperty(
            'fiveHunNote', 0)
        recieved_object2.setProperty(
            'twoThNote', 0)
        if self.coinUV or self.coinEthanol:
            self.coin_manager.stop_detect_thread = True
            self.coin_detect_thread.join()
            self.coin_manager.stop_detect_thread = False
            self.coin_manager.result_dict = {}
            self.coin_manager.stop()
        recieved_object2.setProperty('tenCoin', 0)
        recieved_object2.setProperty(
            'twentyCoin', 0)
        recieved_object2.setProperty(
            'tenCoin', 0)
        recieved_object2.setProperty(
            'fiveCoin', 0)
        recieved_object2.setProperty(
            'twoCoin', 0)
        recieved_object2.setProperty(
            'oneCoin', 0)
        self.note_result = {}
        self.coin_result = {}
        self.progress = 0
        print("[INFO] Stopped")
        recieved_object2.setProperty('progress', 0)
        recieved_object2.setProperty("total", 0)

    @ Slot(QObject)
    def noteUpdate(self, recieved_object):
        self.note_result = self.note_manager.result()
        recieved_object.setProperty('tenNote', self.note_result['ten'])
        recieved_object.setProperty(
            'twentyNote', self.note_result['twenty'])
        recieved_object.setProperty(
            'fiftyNote', self.note_result['fifty'])
        recieved_object.setProperty(
            'oneHunNote', self.note_result['hund'])
        recieved_object.setProperty(
            'twoHunNote', self.note_result['twohund'])
        recieved_object.setProperty(
            'fiveHunNote', self.note_result['fivehund'])
        recieved_object.setProperty(
            'twoThNote', self.note_result['twothousand'])

    @ Slot(QObject)
    def coinUpdate(self, recieved_object):
        self.coin_result = self.coin_manager.result()

        recieved_object.setProperty(
            "twentyCoin", self.coin_result['twenty_coin'])
        recieved_object.setProperty("tenCoin", self.coin_result['ten_coin'])
        recieved_object.setProperty("fiveCoin", self.coin_result['five_coin'])
        recieved_object.setProperty("twoCoin", self.coin_result['two_coin'])
        recieved_object.setProperty("oneCoin", self.coin_result['one_coin'])

    @ Slot(QObject)
    def sum_update(self, recieved_object):
        note_sum = int(self.note_result['ten'] *
                       10 + self.note_result['twenty'] * 20 +
                       self.note_result['fifty'] * 50 +
                       self.note_result['hund'] *
                       100 + self.note_result['twohund'] *
                       200 + self.note_result['fivehund'] *
                       500 + self.note_result['twothousand'] * 2000) if self.noteUV or self.noteEthanol else 0

        coin_sum = int(self.coin_result['one_coin']*1 +
                       self.coin_result['two_coin']*2 + self.coin_result['five_coin']*5 +
                       self.coin_result['ten_coin']*10 +
                       self.coin_result['twenty_coin']*20) if self.coinUV or self.coinEthanol else 0
        self.total = note_sum + coin_sum
        recieved_object.setProperty("total", self.total)

    @ Slot(QObject)
    def progress_update(self, recieved_object):
        if self.noteUV or self.noteEthanol:
            for i in range(0, self.note_result['progress']+2, 2):
                recieved_object.setProperty(
                    "progress", i)
        elif self.coinUV or self.coinEthanol:
            for i in range(0, self.coin_result['progress']+2, 2):
                recieved_object.setProperty(
                    "progress", i)

    @Slot()
    def shutdown(self):
        os.system('sudo shutdown now')
