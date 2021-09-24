#!python
#cython: language_level=3
import time
from threading import Thread

import RPi.GPIO as IO
from helpers.config import *
from helpers.detector import Detector
from helpers.sensors.ir import Ir
from helpers.sensors.limitswitch import LimitSwitch
from helpers.sensors.relay import Relay
from helpers.sensors.stepper import Stepper


class NoteManager:
    def __init__(self):
        self.note_detector = Detector()

        self.input_ir = Ir(IR_INPUT_NOTE)
        self.dispense_ir = Ir(IR_DISPENSE_TRAY)
        self.conveyor_ir = Ir(IR_CONVEYOR)

        self.limit_switch = LimitSwitch(LIMIT_SWITCH_DISPENSE)

        self.uv1_relay = Relay(UV_1_NOTE)
        self.spray_relay = Relay(NOTE_SPRAY, type=2)
        self.valve = Relay(NOTE_VALVE, type=2)

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
        self.conveyor_stepper_1 = Stepper(CONVEYOR_MOTOR_ADDRESS)
        self.dispense = Stepper(NOTE_DISPENSE_MOTOR_ADDRESS)

        self.calibrate()

        self.uv_thread = Thread(target=self.uv)
        self.feed_thread = Thread(target=self.feed_note)
        self.conveyor_stepper_1_thread = Thread(
            target=self.conveyor_run, args=[CONVEYOR_MOTOR_1_NUM])
        self.conveyor_stepper_1_thread = Thread(
            target=self.conveyor_run, args=[CONVEYOR_MOTOR_2_NUM])
        # self.sync_thread = Thread(
        #     target=self.syncDispenseTray
        # )
        self.sprayProcess = Thread(
            target=self.spray_note)
        self.checkpoint = 'start'
        self.feed_thread.start()
        self.conveyor_stepper_1_thread.start()
        self.conveyor_stepper_1_thread.start()
        # self.sync_thread.start()
        # self.uv_thread.start()
        self.sprayProcess.start()
        self.detect_thread = Thread(
            target=self.detect_note)

        self.detect_thread.start()
        self.accPoints = 35
        self.currency = '20'

    def start(self):
        try:
            if self.input_ir.detect():
                # self.feed_thread.join()
                # self.conveyor_stepper_1_thread.join()
                # self.conveyor_stepper_1_thread.join()
                self.progress = 10
                # self.detect_thread.join()
                # self.sprayProcess.join()
                self.progress = 20
        except KeyboardInterrupt:
            self.stop()

    def calibrate(self):
        lim = self.limit_switch.checkTrigger()
        while lim:
            self.dispense.move(1, 1)
            lim = self.limit_switch.checkTrigger()
            if not lim:
                time.sleep(.2)
                self.dispense.move(130, 1, direction='Backward')
                self.dispense.deactivate(1)

    def feed_note(self):
        while True:
            if self.input_ir.detect():
                self.feeder_stepper.move(700, NOTE_FEEDER_NUM)
                self.feeder_stepper.deactivate(NOTE_FEEDER_NUM)
                self.checkpoint = 'sanitise'
                time.sleep(.2)

    def conveyor_run(self, num):
        while True:
            if self.input_ir.detect():
                time.sleep(.3)
                if num == CONVEYOR_MOTOR_1_NUM:
                    conveyor_motor = self.conveyor_stepper_1
                    conveyor_motor.move(2800, num, direction='Backward')
                    conveyor_motor.deactivate(num)
                elif num == CONVEYOR_MOTOR_2_NUM:
                    conveyor_motor = self.conveyor_stepper_1
                    conveyor_motor.move(2800, num, direction='Forward')
                    conveyor_motor.deactivate(num)

    # def syncDispenseTray(self):
    #     while self.checkpoint!='detect':
    #         if self.conveyor_ir.detect():
    #             print('conveyor')
    #             if not self.dispense_ir.detect():
    #                 print('dispensor ir')
    #                 self.dispense.motor(3,.3)
    #         if self.dispense_ir.detect():
    #                 time.sleep(.3)
    #                 self.dispense.motor(3,0)

    def uv(self):
        while True:
            if self.input_ir.detect():
                self.uv1_relay.on()
            # if self.conveyor_ir.detect():
                time.sleep(45)
                self.uv1_relay.off()

    def spray_note(self):
        while True:
            if self.input_ir.detect():
                self.valve.on()
                time.sleep(.5)
                self.spray_relay.on()
                time.sleep(1)
                self.spray_relay.off()
                self.valve.off()

    def detect_note(self):
        while True:
            if self.dispense_ir.detect():
                print('[IR]')
                self.note_detector.detect()
                self.currency = self.note_detector.max_currency
                self.note_detector.clear()
                print('[Currency] ', self.currency)
                if self.currency != '0':
                    self.checkpoint = 'detect'
                    if self.currency == '10':
                        self.ten_note_count += 1
                        self.dispense.move(
                            TEN_NOTE_STEPS, NOTE_DISPENSE_MOTOR_NUM, direction='Forward')
                        time.sleep(1)
                        self.dispense.motor(3, .8)
                        time.sleep(4)
                        self.dispense.motor(3, 0)
                        self.dispense.move(
                            TEN_NOTE_STEPS, NOTE_DISPENSE_MOTOR_NUM, direction='Backward')
                        self.dispense.deactivate(NOTE_DISPENSE_MOTOR_NUM)
                        self.currency = '0'
                    elif self.currency == '20':
                        self.twenty_note_count += 1
                        self.dispense.move(
                            TWEN_NOTE_STEPS, NOTE_DISPENSE_MOTOR_NUM, direction='Forward')
                        time.sleep(1)
                        self.dispense.motor(3, .8)
                        time.sleep(4)
                        self.dispense.motor(3, 0)
                        self.dispense.move(
                            TWEN_NOTE_STEPS, NOTE_DISPENSE_MOTOR_NUM, direction='Backward')
                        self.dispense.deactivate(NOTE_DISPENSE_MOTOR_NUM)
                        self.currency = '0'
                    elif self.currency == '50':
                        self.fifty_note_count += 1
                        self.dispense.move(
                            FIFTY_NOTE_STEPS, NOTE_DISPENSE_MOTOR_NUM, direction='Forward')
                        time.sleep(1)
                        self.dispense.motor(3, .8)
                        time.sleep(4)
                        self.dispense.motor(3, 0)
                        self.dispense.move(
                            FIFTY_NOTE_STEPS, NOTE_DISPENSE_MOTOR_NUM, direction='Backward')
                        self.dispense.deactivate(NOTE_DISPENSE_MOTOR_NUM)
                        self.currency = '0'
                    elif self.currency == '100':
                        print('[Moving 100]')
                        self.hund_note_count += 1
                        self.dispense.move(
                            HUND_NOTE_STEPS, NOTE_DISPENSE_MOTOR_NUM, direction='Backward')
                        time.sleep(1)
                        self.dispense.motor(3, .8)
                        time.sleep(4)
                        self.dispense.motor(3, 0)
                        self.dispense.move(
                            HUND_NOTE_STEPS, NOTE_DISPENSE_MOTOR_NUM, direction='Forward')
                        self.dispense.deactivate(NOTE_DISPENSE_MOTOR_NUM)
                        self.currency = '0'
                    elif self.currency == '200':
                        self.twohund_note_count += 1
                        self.dispense.move(
                            TWOHUND_NOTE_STEPS, NOTE_DISPENSE_MOTOR_NUM, direction='Backward')
                        time.sleep(1)
                        self.dispense.motor(3, .8)
                        time.sleep(4)
                        self.dispense.motor(3, 0)
                        self.dispense.move(
                            TWOHUND_NOTE_STEPS, NOTE_DISPENSE_MOTOR_NUM, direction='Forward')
                        self.dispense.deactivate(NOTE_DISPENSE_MOTOR_NUM)
                        self.currency = '0'
                    elif self.currency == '500':
                        self.fivehund_note_count += 1
                        self.dispense.move(
                            FIVEHUND_NOTE_STEPS, NOTE_DISPENSE_MOTOR_NUM, direction='Backward')
                        time.sleep(1)
                        self.dispense.motor(3, .8)
                        time.sleep(4)
                        self.dispense.motor(3, 0)
                        self.dispense.move(
                            FIVEHUND_NOTE_STEPS, NOTE_DISPENSE_MOTOR_NUM, direction='Forward')
                        self.dispense.deactivate(NOTE_DISPENSE_MOTOR_NUM)
                        self.currency = '0'
                    elif self.currency == '2000':
                        self.twothousand_note_count += 1
                        self.dispense.move(
                            TWOTHOUSAND_NOTE_STEPS, NOTE_DISPENSE_MOTOR_NUM, direction='Backward')
                        time.sleep(1)
                        self.dispense.motor(3, .8)
                        time.sleep(4)
                        self.dispense.motor(3, 0)
                        self.dispense.move(
                            TWOTHOUSAND_NOTE_STEPS, NOTE_DISPENSE_MOTOR_NUM, direction='Forward')
                        self.dispense.deactivate(NOTE_DISPENSE_MOTOR_NUM)
                        self.currency = '0'
                    self.progress = 100

    def result(self):
        resultDict = {
            'ten': self.ten_note_count,
            'twenty': self.twenty_note_count,
            'fifty': self.fifty_note_count,
            'hund': self.hund_note_count,
            'twohund': self.twohund_note_count,
            'fivehund': self.fivehund_note_count,
            'twothousand': self.twothousand_note_count,
            'progress': self.progress
        }
        return resultDict

    def stop(self):
        self.feeder_stepper.deactivate(1)
        self.feeder_stepper.deactivate(2)
        self.conveyor_stepper_1.deactivate(1)
        self.conveyor_stepper_1.deactivate(2)
        self.conveyor_stepper_1.deactivate(1)
        self.conveyor_stepper_1.deactivate(2)
        self.dispense.deactivate(1)
        self.dispense.motor(3, 0)

        self.conveyor_stepper_1_thread.terminate()
        self.conveyor_stepper_1_thread.terminate()
        self.feed_thread.terminate()
        self.detect_thread.terminate()

        self.valve.off()
        self.spray_relay.off()
        self.uv_thread.terminate()
        self.uv1_relay.off()

        self.note_detector.stop()
        IO.cleanup()
