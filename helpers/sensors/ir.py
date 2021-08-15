import RPi.GPIO as IO
class Ir:
    """For IR Sensor """
    def __init__(self, pin, isCounter = False, isDetect = False) -> None:
        self.pin = pin
        self.isCounter = isCounter
        self.isDetect = isDetect
        self.__counter = 0
        IO.setwarnings(False)
        IO.setmode(IO.BCM)
        IO.setup(self.pin, IO.IN)
        
    def detect(self):

        if(IO.input(self.pin) == True):  # object is far away
            return False
        if(IO.input(self.pin) == False):  # object is near
            return True
    def counter(self)    :
        if(IO.input(self.pin) == False):  # object is near
            self.__counter += 1
            return self.__counter
        else :
            pass
