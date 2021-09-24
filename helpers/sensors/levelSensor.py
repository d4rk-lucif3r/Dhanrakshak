#!python
#cython: language_level=3
import RPi.GPIO as IO
class LevelSensor():
    def __init__(self, pin):
        self.level = 0
        self.pin = pin
        IO.setup(self.pin, IO.IN)
    def levelCheck(self):
        self.level = IO.input(self.pin)
        if self.level == 1:
            return True
        elif self.level == 0:
            return False

