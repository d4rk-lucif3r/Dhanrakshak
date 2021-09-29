#!python
#cython: language_level=3
import time

import numpy as np
from adafruit_motor import stepper
from adafruit_motorkit import MotorKit


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
            for i in np.arange(0, steps, 1.25):
                self.kit.stepper1.onestep(direction=direction, style=style)
        elif stepper_num == 2:
            for i in np.arange(0, steps, 1.25):
                self.kit.stepper2.onestep(direction=direction, style=style)

    def motor(self, motor_num, throttle):
        if motor_num == 1:
            self.kit.motor1.throttle = throttle
        elif motor_num == 2:
            self.kit.motor2.throttle = throttle
        elif motor_num == 3:
            self.kit.motor3.throttle = throttle
        elif motor_num == 4:
            self.kit.motor4.throttle = throttle

    def deactivate(self, step_num):
        stepper_num = step_num
        if stepper_num == 1:
            self.kit.stepper1.release()
        elif stepper_num == 2:
            self.kit.stepper2.release()
