#!python
#cython: language_level=3
import RPi.GPIO as IO
from helpers.config import *
IO.setmode(IO.BCM)


class LimitSwitch:
    def __init__(self, pin):
        self.pin = pin
        IO.setup(self.pin, IO.IN, pull_up_down=IO.PUD_UP)

    def checkTrigger(self):
        if IO.input(self.pin) == 0:
            return True
        else:
            return False
