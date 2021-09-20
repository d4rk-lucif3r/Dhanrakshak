#!python
#cython: language_level=3
from adafruit_motorkit import MotorKit
from adafruit_motor import stepper
import time


class Stepper:
    def __init__(self, address):
        self.kit = MotorKit(address=address)

    def move(self, steps, stepper_num, direction='Forward', style=stepper.DOUBLE):
        if direction == "Forward":
            direction = stepper.FORWARD
        elif direction == "Backward":
            direction = stepper.BACKWARD

        stepper_num = stepper_num
        if stepper_num == 1:
            for i in range(0, steps):
                self.kit.stepper1.onestep(direction=direction, style=style)
        elif stepper_num == 2:
            for i in range(0, steps):
                self.kit.stepper2.onestep(direction=direction, style=style)

    def deactivate(self, step_num):
        stepper_num = step_num
        if stepper_num == 1:
            self.kit.stepper1.release()
        elif stepper_num == 2:
            self.kit.stepper2.release()
