# Dhanrakshak

---

## About 

A machine which identifies, sanitize and segregates currency denomination.

---

## Working

User enters a note or coin in their respected slots , then selects the Sanitization method through UI and click on start. 
Machine detects the denomination through IR sensor placed at the end of the currency slot which triggers the feeder system and the denomination gets sanitised through 
selected method either UV, ethanol or Both.

Detection of note is done through our self-made computer vision algorithms which detects the note and dispatches it to its slot in the tray.

Detection of note is done through pure mecchanical means based on the diameter of the respected coins.

### Note Detection using CV

Camera placed inside the machine sends continous video streams while the process is working. 
The detection algorithm is trained on hundreds of notes and is able to identify most of the torned notes

#### Internal working of Algorithms

Video Stream is captured through camera then keypoints and features are extracted from this video stream of currency notes and is matched with the keypoints and features of
training data using [Descriptive Matcher](https://docs.opencv.org/3.4/db/d39/classcv_1_1DescriptorMatcher.html) with [Bruteforce Hamming](https://docs.opencv.org/3.4/db/d39/classcv_1_1DescriptorMatcher.html#aea3d791a454b74e7a215b926e98cef24a7362dae849e477ed4b1bc862c8ebb5c4)

#### UI

User interface is made with the help of [QT](https://www.qt.io/) and is connected with Python based backend with the help of [Pyside2](https://pypi.org/project/PySide2/) 
and self developed [Slots](https://github.com/d4rk-lucif3r/Dhanrakshak/blob/master/helpers/slots.py) which are responsible to render data from sensors to UI

## Dependencies

Dependencies for this project is defined in [Requirements.txt](https://github.com/d4rk-lucif3r/Dhanrakshak/blob/master/requirements.txt)




