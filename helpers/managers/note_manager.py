
import time
from multiprocessing import Process
from threading import Thread
import RPi.GPIO as IO
from helpers.config import *
from helpers.detector import Detector
from helpers.sensors.ir import Ir
from helpers.sensors.limit_switch import LimitSwitch
from helpers.sensors.relay import Relay
from helpers.sensors.stepper import Stepper
import os


class NoteManager:
    def __init__(self):

        self.stop_detect_thread = False
        self.spray_stop_thread = False
        self.stop_thread = False

        self.note_detector = Detector()

        self.input_ir = Ir(IR_INPUT_NOTE)
        self.dispense_ir = Ir(IR_DISPENSE_TRAY)
        self.conveyor_ir = Ir(IR_CONVEYOR)

        self.limit_switch = LimitSwitch(LIMIT_SWITCH_DISPENSE)\

        self.lock_relay = Relay(LOCK_RELAY, type=2)
        self.uv1_relay = Relay(UV_1_NOTE)
        self.spray_relay = Relay(NOTE_SPRAY, type=2)
        self.valve = Relay(NOTE_VALVE, type=2)
        self.blower = Relay(BLOWER_NOTE_RELAY, type=2)
        self.light = Relay(LIGHT, type=2)

        self.progress = 0
        self.ten_note_count = 0
        self.twenty_note_count = 0
        self.fifty_note_count = 0
        self.hund_note_count = 0
        self.twohund_note_count = 0
        self.fivehund_note_count = 0
        self.twothousand_note_count = 0

        self.feeder_stepper = Stepper(NOTE_FEEDER_ADDRESS)
        self.conveyor_stepper_1 = Stepper(CONVEYOR_MOTOR_ADDRESS)
        self.conveyor_stepper_2 = Stepper(CONVEYOR_MOTOR_ADDRESS)
        self.dispense = Stepper(NOTE_DISPENSE_MOTOR_ADDRESS)

        # self.calibrate()
        self.feed_process = None
        self.conveyor_stepper_1_process = None
        self.conveyor_stepper_2_process = None
        self.spray_thread = None
        self.sync_process = None
        self.result_dict = {}

        self.count = 0

    def start(self, is_uv, is_ethanol):
        try:
            self.progress = 0
            self.result_dict = {}
            self.is_uv = is_uv
            self.is_ethanol = is_ethanol
            print('[UV-rec]', is_uv)
            print('[Ethanol-rec]', is_ethanol)
            self.progress = 20
            if self.count == 0:
                self.light.on()
                self.stop_thread = False
                self.spray_stop_thread = False
                self.feed_process = Process(target=self.feed_note, daemon=True)
                self.feed_process.start()
                self.conveyor_stepper_1_process = Process(
                    target=self.conveyor_run1, daemon=True)
                self.conveyor_stepper_1_process.start()
                self.conveyor_stepper_2_process = Process(
                    target=self.conveyor_run2, daemon=True)
                self.conveyor_stepper_2_process.start()
                self.sync_process = Process(
                    target=self.sync_dispenseTray, daemon=True)
                self.sync_process.start()
                if self.is_ethanol:
                    self.spray_thread = Thread(
                        target=self.spray_note)
                    self.spray_thread.start()

                self.count = 1
        except KeyboardInterrupt:
            self.stop()

    def calibrate(self):
        lim = self.limit_switch.checkTrigger()
        while lim:
            self.dispense.move(1, 1)
            lim = self.limit_switch.checkTrigger()
            if not lim:
                time.sleep(.2)
                self.dispense.move(HOME_POSITION_OFFSET,
                                   1, direction='Backward')
                self.dispense.deactivate(1)

    def feed_note(self):

        while True:

            if self.input_ir.detect():
                if not self.dispense_ir.detect():
                    self.lock_relay.off()
                    if self.is_uv:
                        self.uv1_relay.on()
                    if self.is_ethanol:
                        self.blower.on()
                    self.progress = 10
                    self.feeder_stepper.move(700, NOTE_FEEDER_NUM)
                    self.feeder_stepper.deactivate(NOTE_FEEDER_NUM)
            if self.stop_thread:
                break
            time.sleep(1)

    def conveyor_run1(self):
        while True:

            if self.input_ir.detect():

                time.sleep(.6)
                self.conveyor_stepper_1.move(
                    4600, CONVEYOR_MOTOR_1_NUM, direction='Backward')
                self.conveyor_stepper_1.deactivate(CONVEYOR_MOTOR_1_NUM)
            if self.conveyor_ir.detect():
                time.sleep(2)
                self.conveyor_stepper_1.deactivate(CONVEYOR_MOTOR_1_NUM)
                time.sleep(1)
            if self.stop_thread:
                break

    def conveyor_run2(self):
        while True:

            if self.input_ir.detect():
                time.sleep(.6)
                self.progress = 30
                self.conveyor_stepper_2.move(
                    4600, CONVEYOR_MOTOR_2_NUM, direction='Forward')
                self.conveyor_stepper_2.deactivate(CONVEYOR_MOTOR_2_NUM)
            if self.conveyor_ir.detect():
                time.sleep(3)
                self.progress = 50
                self.conveyor_stepper_2.deactivate(CONVEYOR_MOTOR_2_NUM)
            if self.stop_thread:
                break
            time.sleep(1)

    def sync_dispenseTray(self):

        sync = 0
        while True:
            if self.conveyor_ir.detect():
                self.dispense.motor(3, .7)
                sync = 0
            if sync == 0:
                if self.dispense_ir.detect():
                    time.sleep(3)
                    self.dispense.motor(3, 0)
                    sync = 1
            if self.stop_thread:
                break

    def spray_note(self):
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
            if self.spray_stop_thread:
                break
            time.sleep(2)

    def detect_note(self):
        run = 0
        while True:
            try:
                if self.conveyor_ir.detect():
                    run = 1
                    self.progress = 50
                    time.sleep(7)
                if self.dispense_ir.detect() and run == 1:
                    run = 0
                    self.progress = 80
                    print('[IR]')
                    self.note_detector.detect()
                    self.currency = self.note_detector.max_currency
                    self.note_detector.clear()
                    print('[Currency] ', self.currency)

                    if self.currency == '10':
                        self.ten_note_count += 1
                        self.dispense.move(
                            TEN_NOTE_STEPS, NOTE_DISPENSE_MOTOR_NUM, direction='Forward')
                        time.sleep(1)
                        self.dispense.motor(3, .8)
                        time.sleep(6)
                        self.dispense.motor(3, 0)
                        self.dispense.move(
                            TEN_NOTE_STEPS, NOTE_DISPENSE_MOTOR_NUM, direction='Backward')
                        self.dispense.deactivate(NOTE_DISPENSE_MOTOR_NUM)

                    elif self.currency == '20':
                        self.twenty_note_count += 1
                        self.dispense.move(
                            TWEN_NOTE_STEPS, NOTE_DISPENSE_MOTOR_NUM, direction='Forward')
                        time.sleep(1)
                        self.dispense.motor(3, .8)
                        time.sleep(6)
                        self.dispense.motor(3, 0)
                        self.dispense.move(
                            TWEN_NOTE_STEPS, NOTE_DISPENSE_MOTOR_NUM, direction='Backward')
                        self.dispense.deactivate(NOTE_DISPENSE_MOTOR_NUM)

                    elif self.currency == '50':
                        self.fifty_note_count += 1
                        self.dispense.move(
                            FIFTY_NOTE_STEPS, NOTE_DISPENSE_MOTOR_NUM, direction='Forward')
                        time.sleep(1)
                        self.dispense.motor(3, .8)
                        time.sleep(6)
                        self.dispense.motor(3, 0)
                        self.dispense.move(
                            FIFTY_NOTE_STEPS, NOTE_DISPENSE_MOTOR_NUM, direction='Backward')
                        self.dispense.deactivate(NOTE_DISPENSE_MOTOR_NUM)

                    elif self.currency == '100':
                        print('[Moving 100]')
                        self.hund_note_count += 1
                        self.dispense.move(
                            HUND_NOTE_STEPS, NOTE_DISPENSE_MOTOR_NUM, direction='Backward')
                        time.sleep(1)
                        self.dispense.motor(3, .8)
                        time.sleep(6)
                        self.dispense.motor(3, 0)
                        self.dispense.move(
                            HUND_NOTE_STEPS, NOTE_DISPENSE_MOTOR_NUM, direction='Forward')
                        self.dispense.deactivate(NOTE_DISPENSE_MOTOR_NUM)

                    elif self.currency == '200':
                        self.twohund_note_count += 1
                        self.dispense.move(
                            TWOHUND_NOTE_STEPS, NOTE_DISPENSE_MOTOR_NUM, direction='Backward')
                        time.sleep(1)
                        self.dispense.motor(3, .8)
                        time.sleep(6)
                        self.dispense.motor(3, 0)
                        self.dispense.move(
                            TWOHUND_NOTE_STEPS, NOTE_DISPENSE_MOTOR_NUM, direction='Forward')
                        self.dispense.deactivate(NOTE_DISPENSE_MOTOR_NUM)

                    elif self.currency == '500':
                        self.fivehund_note_count += 1
                        self.dispense.move(
                            FIVEHUND_NOTE_STEPS, NOTE_DISPENSE_MOTOR_NUM, direction='Backward')
                        time.sleep(1)
                        self.dispense.motor(3, .8)
                        time.sleep(6)
                        self.dispense.motor(3, 0)
                        self.dispense.move(
                            FIVEHUND_NOTE_STEPS, NOTE_DISPENSE_MOTOR_NUM, direction='Forward')
                        self.dispense.deactivate(NOTE_DISPENSE_MOTOR_NUM)

                    elif self.currency == '2000':
                        self.twothousand_note_count += 1
                        self.dispense.move(
                            TWOTHOUSAND_NOTE_STEPS, NOTE_DISPENSE_MOTOR_NUM, direction='Backward')
                        time.sleep(1)
                        self.dispense.motor(3, .8)
                        time.sleep(6)
                        self.dispense.motor(3, 0)
                        self.dispense.move(
                            TWOTHOUSAND_NOTE_STEPS, NOTE_DISPENSE_MOTOR_NUM, direction='Forward')
                        self.dispense.deactivate(NOTE_DISPENSE_MOTOR_NUM)

                    elif self.currency == '0':
                        self.dispense.deactivate(NOTE_DISPENSE_MOTOR_NUM)
                        self.dispense.move(
                            TEN_NOTE_STEPS, NOTE_DISPENSE_MOTOR_NUM, direction='Backward')
                        time.sleep(1)
                        self.dispense.motor(3, .8)
                        time.sleep(6)
                        self.dispense.motor(3, 0)
                        self.dispense.move(
                            TEN_NOTE_STEPS, NOTE_DISPENSE_MOTOR_NUM, direction='Forward')
                        self.dispense.deactivate(NOTE_DISPENSE_MOTOR_NUM)

                    self.progress = 100

                    if self.is_ethanol:
                        self.blower.off()
                    if self.is_uv:
                        self.uv1_relay.off()

                if self.stop_detect_thread:
                    print('[Killed Detect Thread]')
                    break
            except KeyboardInterrupt:
                break

    def result(self):
        self.result_dict = {
            'ten': self.ten_note_count,
            'twenty': self.twenty_note_count,
            'fifty': self.fifty_note_count,
            'hund': self.hund_note_count,
            'twohund': self.twohund_note_count,
            'fivehund': self.fivehund_note_count,
            'twothousand': self.twothousand_note_count,
            'progress': self.progress
        }
        return self.result_dict

    def stop(self):
        if self.is_ethanol:
            self.spray_stop_thread = True
            if self.spray_thread.is_alive():
                self.spray_thread.join()

        self.valve.off()
        self.spray_relay.off()
        self.uv1_relay.off()
        self.light.off()
        self.result_dict = {}
        self.feeder_stepper.deactivate(1)
        self.feeder_stepper.deactivate(2)
        self.conveyor_stepper_1.deactivate(1)
        self.conveyor_stepper_1.deactivate(2)
        self.conveyor_stepper_2.deactivate(1)
        self.conveyor_stepper_2.deactivate(2)
        self.dispense.deactivate(1)
        self.dispense.motor(3, 0)
        self.conveyor_stepper_1_process.terminate()
        self.conveyor_stepper_2_process.terminate()
        self.feed_process.terminate()
        self.stop_thread = True
        self.feed_process.join()
        self.conveyor_stepper_1_process.join()
        self.conveyor_stepper_2_process.join()
        self.feed_process.close()
        self.conveyor_stepper_1_process.close()
        self.conveyor_stepper_2_process.close()
        self.count = 0
        self.ten_note_count = 0
        self.twenty_note_count = 0
        self.fifty_note_count = 0
        self.hund_note_count = 0
        self.twohund_note_count = 0
        self.fivehund_note_count = 0
        self.twothousand_note_count = 0
        self.progress = 0
        self.is_uv = False
        self.is_ethanol = False
        print('Cleaned')
