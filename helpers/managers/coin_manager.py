#!python
#cython: language_level=3
import time
from multiprocessing import Process
from threading import Thread
import RPi.GPIO as IO
from helpers.config import *
from helpers.sensors.ir import Ir
from helpers.sensors.relay import Relay
from helpers.sensors.stepper import Stepper
from adafruit_motor import stepper

class CoinManager:
    def __init__(self):
        self.input_ir = Ir(IR_INPUT_COIN)
        self.one_coin = Ir(IR_1_Rupee)
        self.two_coin = Ir(IR_2_Rupees)
        self.five_coin = Ir(IR_5_Rupees)
        self.ten_coin = Ir(IR_10_Rupees)
        self.twenty_coin = Ir(IR_20_Rupees)

        self.uv1_relay = Relay(UV_1_COIN, type = 2)
        self.spray_relay = Relay(COIN_SPRAY, type=2)
        self.coin_blower = Relay(BLOWER_COIN_RELAY, type=2)
        self.valve = Relay(COIN_VALVE, type =2)
        self.progress = 0


        self.one_coin_count = 0
        self.two_coin_count = 0
        self.five_coin_count = 0
        self.ten_coin_count = 0
        self.twenty_coin_count = 0

        self.feeder_stepper = Stepper(COIN_FEEDER_ADDRESS)
        self.count = 0
        self.stop_thread = False
        self.is_ethanol = ''
        self.is_uv = ''
        self.result_dict = {}
        self.stop_detect_thread = False
        self.feed_process = None
        self.spray_thread = None
    def start(self, is_uv, is_ethanol):
        try:
            if self.count == 0:
                self.stop_thread = False
                self.spray_stop_thread = False
                self.feed_process = Process(target=self.feed_coin, daemon = True)
                self.feed_process.start()
                self.is_uv = is_uv
                self.is_ethanol = is_ethanol
                if self.is_ethanol:
                    self.spray_thread = Thread(
                    target=self.spray_coin)
                    self.spray_thread.start()
                    self.coin_blower.on()
                self.count = 1
                self.progress = 20
        except KeyboardInterrupt:
            self.stop()


    def feed_coin(self):
        while True:
            if self.input_ir.detect():
                if self.is_uv:
                    self.uv1_relay.on()
                # time.sleep(.2)
                self.feeder_stepper.move(2000, COIN_FEEDER_NUM, style=stepper.MICROSTEP)
                self.feeder_stepper.deactivate(COIN_FEEDER_NUM)
                time.sleep(.2)
            if self.stop_thread:
                break
            time.sleep(1)


    def spray_coin(self):
        while True:
            if self.input_ir.detect():
                self.valve.on()
                time.sleep(1)
                self.spray_relay.on()
                time.sleep(1)
                self.spray_relay.off()
                self.valve.off()
                time.sleep(.3)
                self.valve.on()
                time.sleep(1)
                self.spray_relay.on()
                time.sleep(1)
                self.spray_relay.off()
                self.valve.off()

            if self.stop_thread:
                break
            time.sleep(1)

    def detect(self):
        while True:
            if self.one_coin.detect():
                self.one_coin_count += 1
                time.sleep(.2)
            elif self.two_coin.detect():
                self.two_coin_count += 1
                time.sleep(.2)
            elif self.five_coin.detect():
                self.five_coin_count += 1
                time.sleep(.2)
            elif self.ten_coin.detect():
                self.ten_coin_count += 1
                time.sleep(.2)
            elif self.twenty_coin.detect():
                self.twenty_coin_count += 1
                time.sleep(.2)
            elif self.is_uv:
                self.uv1_relay.off()
            if self.is_ethanol:
                self.coin_blower.off()
            if self.stop_detect_thread:
                break
    def result(self):
        self.checkpoint = 'count'
        self.progress = 30
        self.result_dict = {
            'one_coin': self.one_coin_count,
            'two_coin': self.two_coin_count,
            'five_coin': self.five_coin_count,
            'ten_coin': self.ten_coin_count,
            'twenty_coin': self.twenty_coin_count,
            'progress' : self.progress
        }
        self.progress = 100
        return self.result_dict

    def stop(self):
        self.feeder_stepper.deactivate(COIN_FEEDER_NUM)
        self.feed_process.terminate()
        self.stop_thread = True
        self.feed_process.join()
        self.feed_process.close()
        if self.is_ethanol:
            if self.spray_thread.is_alive():
                self.spray_thread.join()
        self.valve.off()
        self.spray_relay.off()
        self.uv1_relay.off()
        self.count = 0
        self.one_coin_count = 0
        self.two_coin_count = 0
        self.five_coin_count = 0
        self.ten_coin_count = 0
        self.twenty_coin_count = 0
