#!python
#cython: language_level=3
"""Master Code for Controlling Relays"""
import RPi.GPIO as IO
import time

class Relay:
    def __init__(self, pin):
        """Takes pin number as input and Sets gpio to BCM and sets up gpio pin to out"""
        self.pin = pin
        IO.setmode(IO.BCM)
        IO.setup(self.pin, IO.OUT)
    
    def on(self):
        """Turns relay on"""
        IO.output(self.pin, IO.HIGH)
    def off(self):
        """Turns relay off"""
        IO.output(self.pin, IO.LOW)
    
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
    
