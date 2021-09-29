#!python
#cython: language_level=3
"""Master Code for Controlling Relays"""
import time

import RPi.GPIO as IO


class Relay:
    def __init__(self, pin, type=1):
        """Takes pin number as input and Sets gpio to BCM and sets up gpio pin to out"""
        self.pin = pin
        self.type = type
        IO.setup(self.pin, IO.OUT)

    def on(self):
        """Turns relay on"""
        if self.type == 1:
            IO.output(self.pin, IO.HIGH)
        elif self.type == 2:
            IO.output(self.pin, IO.LOW)

    def off(self):
        """Turns relay off"""
        if self.type == 1:
            IO.output(self.pin, IO.LOW)
        elif self.type == 2:
            IO.output(self.pin, IO.HIGH)

    def _ishigh(self):
        """Returns True if relay is on"""
        if IO.input(self.pin):
            return True
        else:
            return False

    def toggle(self):
        """Toggles relay"""
        if self._ishigh():
            self.off()
        else:
            self.on()

    def cleanup():
        """Cleans up GPIO"""
        IO.cleanup()
