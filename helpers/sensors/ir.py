#!python
#cython: language_level=3
import RPi.GPIO as IO
class Ir:
    """For IR Sensor """
    def __init__(self, pin, isCounter = False, isDetect = False) -> None:
        self.pin = pin
        self.isCounter = isCounter
        self.isDetect = isDetect
        self.__counter = 0
        IO.setup(self.pin, IO.IN)
        
    def detect(self):
        try:
            if(IO.input(self.pin) == True):  
                return False
            if(IO.input(self.pin) == False): 
                return True
        except:
            return False
    def counter(self)    :
        if(IO.input(self.pin) == False):  
            self.__counter += 1
            return self.__counter
        else :
            pass

