#!python
#cython: language_level=3

# ESC
CLOSE_KEY = 27

# B,G,R
KEYPOINT_DRAW_COLOR = (0, 0, 255)

BASE_DIR = "./dataset"

# How many GOOD matches we need to classify an object
MIN_MATCH_COUNT = 20
CURRENCY_DISPLAY_OFFSET_X = 10
CURRENCY_DISPLAY_OFFSET_Y = 10
CURRENCY_DISPLAY_COLOR = (0, 0, 0)
CURRENCY_CONT_COLOR = (0, 0, 255)
CURRENCY_CONT_THINKNESS = 3

# Enabling this will result in the display of extra information like: the sum of all the matches
# for each currency
DEBUG = False

TEN_NOTE_STEPS = 80 #back
TWEN_NOTE_STEPS = 80 #back
FIFTY_NOTE_STEPS = 80 #back
HUND_NOTE_STEPS = 400
TWOHUND_NOTE_STEPS = 800
FIVEHUND_NOTE_STEPS = 1200
TWOTHOUSAND_NOTE_STEPS = 1600

LINEAR_FLAP_STEPS = 10

## GPIO Allotment

### COIN
IR_1_Rupee = 4
IR_2_Rupees = 27
IR_5_Rupees = 10
IR_10_Rupees = 10
IR_20_Rupees = 22

  # not final
IR_INPUT_COIN = 11


UV_1_COIN = 26
COIN_SPRAY = 13
BLOWER_COIN_RELAY = 21


COIN_FEEDER_ADDRESS = 0x60  #Feeders
COIN_FEEDER_NUM = 1

### Note
UV_1_NOTE = 19
# UV_2_NOTE = 26
NOTE_SPRAY = 0
BLOWER_NOTE_RELAY = 24

IR_INPUT_NOTE = 20


CONVEYOR_MOTOR_ADDRESS = 0X62
CONVEYOR_MOTOR_1_NUM = 1  # top
CONVEYOR_MOTOR_2_NUM = 2  #bottom

NOTE_FEEDER_ADDRESS = 0x60   # Feeders
NOTE_FEEDER_NUM = 2

NOTE_DISPENSE_MOTOR_ADDRESS = 0x61
NOTE_DISPENSE_MOTOR_NUM = 1
NOTE_DISPENSE_DROP_MOTOR_ADDRESS = 0x61
NOTE_DISPENSE_DROP_MOTOR_NUM = 2  #M3

LIMIT_SWITCH_DISPENSE = 1
IR_CONVEYOR = 14  #not final
IR_DISPENSE_TRAY = 8
### MISC
LOCK_RELAY = 25
LEVEL_SENSOR = 7
TRAY_IR = 18
BUZZER = 15
COIN_VALVE = 16
NOTE_VALVE = 12
LIGHT = 23


## Offsets
HOME_POSITION_OFFSET = 135
