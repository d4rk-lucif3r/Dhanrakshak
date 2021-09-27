#!python
#cython: language_level=3
import time
from multiprocessing import Process

import RPi.GPIO as IO
from helpers.config import *
from helpers.sensors.ir import Ir
from helpers.sensors.relay import Relay
from helpers.sensors.stepper import Stepper


class CoinManager:
    def __init__(self):
        self.input_ir = Ir(IR_INPUT_COIN)
        self.one_coin = Ir(IR_1_Rupee)
        self.two_coin = Ir(IR_2_Rupees)
        self.five_coin = Ir(IR_5_Rupees)
        self.ten_coin = Ir(IR_10_Rupees)
        self.twenty_coin = Ir(IR_20_Rupees)

        self.uv1_relay = Relay(UV_1_COIN)
        self.spray_relay = Relay(COIN_SPRAY, type=2)
        self.coin_blower = Relay(BLOWER_COIN_RELAY, type=2)
        self.valve = Relay(COIN_VALVE, type =2)
        self.progress = 0

        self.checkpoint = 'initial'

        self.one_coin_count = 0
        self.two_coin_count = 0
        self.five_coin_count = 0
        self.ten_coin_count = 0
        self.twenty_coin_count = 0

        self.feeder_motor = Stepper(COIN_FEEDER_ADDRESS)
        self.count = 0
        
    def start(self, is_uv, is_ethanol):
        try:
            if self.count == 0:
                self.spray_process = Process(
                    target=self.spray_note)
                self.uv_process = Process(target=self.uv)
                self.feed_process = Process(target=self.feed_coin)
                self.is_uv = is_uv
                self.is_ethanol = is_ethanol
                self.feed_process.start()


                if self.is_ethanol:
                    self.spray_process.start()
                if self.is_uv:
                    self.uv_process.start()
                    self.progress = 20
            else:
                self.feed_process.join()
                self.spray_process.join()
                self.conveyor_stepper_1_process.join()
                self.conveyor_stepper_1_process.join()
                self.count = 1

                self.progress = 20
        except KeyboardInterrupt:
            self.stop()

    def uv(self):
        while True:
            if self.input_ir.detect():
                self.uv1_relay.on()
                self.blower.on()
            if self.conveyor_ir.detect():
                self.uv1_relay.off()
                self.blower.on()

    def spray_note(self):
        while True:
            if self.input_ir.detect():
                self.valve.on()
                time.sleep(.5)
                self.spray_relay.on()
                time.sleep(1)
                self.spray_relay.off()
                self.valve.off()
    def feed_coin(self):
        while True:
            if self.input_ir.detect():
                time.sleep(.2)
                self.feeder_motor.move(50, COIN_FEEDER_NUM)
                time.sleep(.5)
                self.feeder_motor.move(50, COIN_FEEDER_NUM)
                time.sleep(.5)
                self.feeder_motor.move(50, COIN_FEEDER_NUM)
                time.sleep(.5)
                self.feeder_motor.move(50, COIN_FEEDER_NUM)
                time.sleep(.5)
                self.feeder_motor.deactivate(COIN_FEEDER_NUM)
                self.checkpoint = 'sanitise'
                time.sleep(.2)
                self.progress = 40
                
    def spray_coin(self):
        while self.checkpoint == 'sanitise':
            self.spray_relay.on()
            time.sleep(.2)
            self.spray_relay.off()

    def detect(self):
        while True:
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
    def result(self):
        self.checkpoint = 'count'
        self.progress = 30
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

    def stop(self):
        self.feeder_stepper.deactivate(1)
        self.feeder_stepper.deactivate(2)
        self.conveyor_stepper_1.deactivate(1)
        self.conveyor_stepper_1.deactivate(2)
        self.conveyor_stepper_2.deactivate(1)
        self.conveyor_stepper_2.deactivate(2)
        self.dispense.deactivate(1)
        self.dispense.motor(3, 0)
        if self.feed_process.is_alive():
            self.feed_process.terminate()
        if self.spray_process.is_alive():
            self.spray_process.terminate()
        if self.uv_process.is_alive():
            self.uv_process.terminate()
            
        self.valve.off()
        self.spray_relay.off()
        self.uv1_relay.off()
        self.light.off()

        self.note_detector.stop()
        IO.cleanup()
