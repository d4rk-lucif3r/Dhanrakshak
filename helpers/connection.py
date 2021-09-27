#!python
# cython: language_level=3
import random
from multiprocessing import Process
from threading import Thread
import time
from PySide2.QtCore import QObject, Slot

from helpers.config import *
from helpers.managers.coin_manager import CoinManager
from helpers.managers.note_manager import NoteManager
from helpers.sensors.ir import Ir
from helpers.sensors.levelSensor import LevelSensor
from helpers.sensors.relay import Relay
import os

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
        self.note_manager_result = {}
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
            # if count == 0:
            self.coin_manager_process = Process(
                target=self.coin_manager.start, args=[self.coinUV, self.coinEthanol])
            self.coin_detect_thread = Thread(
                target=self.coin_manager.detect, daemon=True)
            self.coin_manager_process.start()
            self.coin_detect_thread.start()
        # count = 1
        print('[INFO] Started')

    @ Slot(QObject)
    def splashCheck(self, recieved_object):
        if self.det_obj.sampleCheck:
            recieved_object.setProperty('showSplash', True)

    @ Slot(QObject)
    def methodCheck(self, recieved_object):
        self.noteUV = recieved_object.property('noteisUV')
        self.noteEthanol = recieved_object.property('noteisEthanol')
        self.coinUV = recieved_object.property('coinisUV')
        self.coinEthanol = recieved_object.property('coinisEthanol')

    @ Slot(QObject)
    def fluidCheck(self, recieved_object):
        if self.level.levelCheck:
            recieved_object.setProperty('visible', True)

    @ Slot(QObject)
    def unlockTray(self, recieved_object):
        self.progress = self.note_manager_result['progress']
        if self.progress == 100:
            recieved_object.setProperty('unlock', True)
            if recieved_object.property('unlockClick'):
                self.lock_relay.on()
                print('relay on')
                recieved_object.setProperty('unlockClick', False)
                recieved_object.setProperty('unlock', False)
                self.progress = 0
        # if self.progress != 100:
            
                # if self.trayIR.detect():
                #     self.lock_relay.off()

    @ Slot(QObject, QObject)
    def stop(self, recieved_object, recieved_object2):
        recieved_object.setProperty('running', False)
        if self.noteUV or self.noteEthanol:
            # if self.note_manager_process.is_alive():
            # self.note_manager_process.terminate()
            self.note_manager.stop_detect_thread = True
            self.detect_thread.join()
            self.note_manager.stop_detect_thread = False
            self.note_manager.result_dict = {}
            self.note_manager.stop()
        if self.coinUV or self.coinEthanol:
            if self.coin_manager_process.is_alive():
                self.coin_manager_process.terminate()
                self.coin_detect_thread.terminate()
                self.coin_manager.result_dict = {}
        self.note_manager_result = {}
        self.progress = 0
        print("[INFO] Stopped")
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
        recieved_object2.setProperty("total", 0)
        # self.det_obj.stop()
        # self.stopThread = False
        # self.detectThread.join()

    @ Slot(QObject)
    def noteUpdate(self, recieved_object):
        self.note_manager_result = self.note_manager.result()
        recieved_object.setProperty('tenNote', self.note_manager_result['ten'])
        recieved_object.setProperty(
            'twentyNote', self.note_manager_result['twenty'])
        recieved_object.setProperty(
            'fiftyNote', self.note_manager_result['fifty'])
        recieved_object.setProperty(
            'oneHunNote', self.note_manager_result['hund'])
        recieved_object.setProperty(
            'twoHunNote', self.note_manager_result['twohund'])
        recieved_object.setProperty(
            'fiveHunNote', self.note_manager_result['fivehund'])
        recieved_object.setProperty(
            'twoThNote', self.note_manager_result['twothousand'])

    @ Slot(QObject)
    def coinUpdate(self, recieved_object):
        # pass
        self.coin_count = self.coin_manager.result()

        # recieved_object.setProperty(
        #     "twentyCoin", self.coin_count['twenty_coin'])
        # recieved_object.setProperty("tenCoin", self.coin_count['ten_coin'])
        # recieved_object.setProperty("fiveCoin", self.coin_count['five_coin'])
        # recieved_object.setProperty("twoCoin", self.coin_count['two_coin'])
        # recieved_object.setProperty("oneCoin", self.coin_count['one_coin'])
    @ Slot(QObject)
    def sum_update(self, recieved_object):
        # result = self.note_manager_result.values()
        note_sum = int(self.note_manager_result['ten'] *
                       10 + self.note_manager_result['twenty'] * 20 +
                       self.note_manager_result['fifty'] * 50 +
                       self.note_manager_result['hund'] *
                       100 + self.note_manager_result['twohund'] *
                       200 + self.note_manager_result['fivehund'] *
                       500 + self.note_manager_result['twothousand'] * 2000) if self.noteUV or self.noteEthanol else 0

        coin_sum = sum(self.coin_count.values()
                       ) if self.coinUV or self.coinEthanol else 0
        self.total = note_sum + coin_sum
        # self.total=100
        # self.total = sum(self.ten_list) + sum(self.twenty_list) + sum(self.fifty_list) + sum(self.hundred_list) + \
        #     sum(self.twohund_list) + sum(self.fivehund_list) + \
        #     sum(self.twothousand_list)
        recieved_object.setProperty("total", self.total)
        
    @ Slot(QObject)
    def progress_update(self, recieved_object):
        for i in range(0, self.note_manager_result['progress']+2, 2):
            # time.sleep(0.5)
            recieved_object.setProperty(
                "progress", i)
    @Slot()
    def shutdown(self):
        os.system('sudo shutdown now')
