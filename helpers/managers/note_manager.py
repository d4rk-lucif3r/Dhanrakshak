import time
from multiprocessing import Process

import RPi.GPIO as GPIO
from helpers.config import *
from helpers.detector import Detector
from helpers.sensors.ir import Ir
from helpers.sensors.relay import Relay
from helpers.sensors.stepper import Stepper


class NoteManager:
    def __init__(self):
        self.note_detector = Detector()

        self.inputIR = Ir(IR_INPUT_NOTE)
        self.limitSwitchLeft = Relay(LIMIT_SWITCH_LEFT)
        self.limitSwitchRight = Relay(LIMIT_SWITCH_RIGHT)
        self.dispenseServo = SERVO_DISPENSE_PIN

        self.uv1_relay = Relay(UV_1_NOTE)
        self.uv2_relay = Relay(UV_2_NOTE)
        self.spray_relay = Relay(NOTE_SPRAY)

        self.progress = 0
        self.checkpoint = 'initial'

        self.ten_note_count = 0
        self.twenty_note_count = 0
        self.fifty_note_count = 0
        self.hund_note_count = 0
        self.twohund_note_count = 0
        self.fivehund_note_count = 0
        self.twothousand_note_count = 0

        self.feeder_motor = Stepper(NOTE_FEEDER_ADDRESS)
        self.conveyor_motor_1 = Stepper(CONVEYOR_MOTOR_ADDRESS)
        self.conveyor_motor_2 = Stepper(CONVEYOR_MOTOR_ADDRESS)
        # self.dispense = Stepper(NOTE_DISPENSE_ADDRESS)
        # self.dispense_flap = Stepper(NOTE_DISPENSE_FLAP_ADDRESS)

        self.feed_process = Process(target=self.feed_note)
        self.conveyor_motor_1_process = Process(
            target=self.conveyor_run, args=(CONVEYOR_MOTOR_1_NUM))
        self.conveyor_motor_2_process = Process(
            target=self.conveyor_run, args=(CONVEYOR_MOTOR_2_NUM))
        self.sprayProcess = Process(target=self.spray_note)
        # self.detectProcess = Process(target=self.detect_note)
        
        self.count = 0

    def check_input(self):
        if self.inputIR.detect():
            self.feedProcess.start()
            self.conveyor_motor_1_process.start()
            self.conveyor_motor_2_process.start()
            self.progress = 10
            self.checkpoint = 'sanitise'
            # self.uv1_relay.on()
            # self.uv2_relay.on()
            # self.sprayProcess.start()
            # self.detectProcess.start()
            self.conveyor_motor_1_process.close()
            self.conveyor_motor_2_process.close()
            self.progress = 20
            return True
        else:
            return False

    def feed_note(self):
        if self.inputIR.detect():
            self.feeder_motor.move(400, NOTE_FEEDER_NUM)
            time.sleep(.2)

    def conveyor_run(self, num):
        if num == CONVEYOR_MOTOR_1_NUM:
            conveyor_motor = self.conveyor_motor_1
        elif num == CONVEYOR_MOTOR_2_NUM:
            conveyor_motor = self.conveyor_motor_2

        conveyor_motor.move(400, num)

    def spray_note(self):
        while self.checkpoint == 'sanitise':
            self.spray_relay.on()
            time.sleep(.2)
            self.spray_relay.off()

    def detect_note(self):
        self.progress = 60
        self.note_detector.start()
        while self.checkpoint == 'sanitise':
            if self.note_detector.detect():
                self.checkpoint = 'detect'
                print("[INFO] Detected Currency :{}".format(
                    self.det_obj.detectedCurrency))
                print("[INFO] Matching Points :{}".format(
                    self.det_obj.maxMatching))
                self.currency = self.det_obj.detectedCurrency
                self.accPoints = self.det_obj.maxMatching
                if self.accPoints > 30:
                    if self.currency == '10':
                        self.ten_note_count += 1
                        self.dispense.move(TEN_NOTE_STEPS, NOTE_DISPENSE_NUM)
                    if self.currency == '20':
                        self.twenty_note_count += 1
                        self.dispense.move(TWEN_NOTE_STEPS, NOTE_DISPENSE_NUM)
                    if self.currency == '50':
                        self.fifty_note_count += 1
                        self.dispense.move(FIFTY_NOTE_STEPS, NOTE_DISPENSE_NUM)
                    if self.currency == '100':
                        self.hund_note_count += 1
                        self.dispense.move(HUND_NOTE_STEPS, NOTE_DISPENSE_NUM)
                    if self.currency == '200':
                        self.twohund_note_count += 1
                        self.dispense.move(
                            TWOHUND_NOTE_STEPS, NOTE_DISPENSE_NUM)
                    if self.currency == '500':
                        self.fivehund_note_count += 1
                        self.dispense.move(
                            FIVEHUND_NOTE_STEPS, NOTE_DISPENSE_NUM)
                    if self.currency == '2000':
                        self.twothousand_note_count += 1
                        self.dispense.move(
                            TWOTHOUSAND_NOTE_STEPS, NOTE_DISPENSE_NUM)

                    self.kit1.move(LINEAR_FLAP_STEPS, NOTE_DISPENSE_FLAP_NUM)

    def result(self):
        resultDict = {
            'ten': self.ten_note_count,
            'twenty': self.twenty_note_count,
            'fifty': self.fifty_note_count,
            'hund': self.hund_note_count,
            'twohund': self.twohund_note_count,
            'fivehund': self.fivehund_note_count,
            'twothousand': self.twothousand_note_count
        }
        return resultDict


if __name__ == "__main__":
    obj = NoteManager()
