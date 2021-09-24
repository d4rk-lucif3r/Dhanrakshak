#!python
#cython: language_level=3
import time
from multiprocessing import Process

import RPi.GPIO as GPIO
from helpers.config import *
from helpers.sensors.ir import Ir
from helpers.sensors.relay import Relay
from helpers.sensors.stepper import Stepper


class CoinManager:
    def __init__(self):
        self.inputIR = Ir(IR_INPUT_COIN)
        self.one_coin = Ir(IR_1_Rupee)
        self.two_coin = Ir(IR_2_Rupees)
        self.five_coin = Ir(IR_5_Rupees)
        self.ten_coin = Ir(IR_10_Rupees)
        self.twenty_coin = Ir(IR_20_Rupees)

        self.uv1_relay = Relay(UV_1_COIN)
        self.uv2_relay = Relay(UV_2_COIN)
        self.spray_relay = Relay(COIN_SPRAY)

        self.progress = 0

        self.checkpoint = 'initial'

        self.one_coin_count = 0
        self.two_coin_count = 0
        self.five_coin_count = 0
        self.ten_coin_count = 0
        self.twenty_coin_count = 0

        self.feeder_motor = Stepper(COIN_FEEDER_ADDRESS)

        self.sprayProcess = Process(target=self.spray_coin)
        self.coinProcess = Process(target=self.result)
        self.feedProcess = Process(target=self.feed_coin)

    def check_input(self):
        if self.inputIR.detect():
            self.feedProcess.start()
            self.progress = 10
            self.checkpoint = 'sanitise'
            self.uv1_relay.on()
            self.uv2_relay.on()
            self.sprayProcess.start()
            self.progress = 20
            self.coinProcess.start()
            return True
        self.sprayProcess.terminate()
        return False

    def feed_coin(self):
        self.feeder_motor.move(50, COIN_FEEDER_NUM)
        time.sleep(.2)

    def spray_coin(self):
        while self.checkpoint == 'sanitise':
            self.spray_relay.on()
            time.sleep(.2)
            self.spray_relay.off()

    def result(self):
        self.checkpoint = 'count'
        self.progress = 30
        if self.one_coin.detect():
            self.one_coin_count += 1
        if self.two_coin.detect():
            self.two_coin_count += 1
        if self.five_coin.detect():
            self.five_coin_count += 1
        if self.ten_coin.detect():
            self.ten_coin_count += 1
        if self.twenty_coin.detect():
            self.twenty_coin_count += 1
        result = {
            'one_coin': self.one_coin_count,
            'two_coin': self.two_coin_count,
            'five_coin': self.five_coin_count,
            'ten_coin': self.ten_coin_count,
            'twenty_coin': self.twenty_coin_count
        }
        self.progress = 100
        self.checkpoint = 'final'
        return result
