import RPi.GPIO as GPIO
import time

GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)
BUZZER = 15
buzzState = False
GPIO.setup(BUZZER, GPIO.OUT)
GPIO.output(BUZZER, buzzState)
while True:
    # buzzState = not buzzState
    
    time.sleep(.1)
    GPIO.output(BUZZER, buzzState)
    time.sleep(.1)
    GPIO.output(BUZZER, not buzzState)
    time.sleep(.1)
    GPIO.output(BUZZER, buzzState)
    time.sleep(.1)
    GPIO.output(BUZZER, not buzzState)
    time.sleep(1)
