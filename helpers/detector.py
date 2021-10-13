import time

import cv2
import numpy as np
from PIL import Image, ImageEnhance
from tensorflow.keras.models import load_model

from helpers.config import *
from helpers.sensors.ir import Ir


class Detector:
    def __init__(self):

        self.indice = {'10': 0, '100': 1, '20': 2, '200': 3,
                       '2000': 4, '50': 5, '500': 6, 'Background': 7}
        self.keys = list(self.indice.keys())
        self.val = list(self.indice.values())
        self.result_list = []
        self.currency = 0
        self.result = 0
        self.model = load_model('helpers/saved_models/dhanrakshakDetector.h5')
        self.trigger_ir = Ir(IR_DISPENSE_TRAY)
        self.ret = 0

    def start(self):
        self.videoCapture = cv2.VideoCapture(0)

    def most_common(self, lst):
        return max(set(lst), key=lst.count)

    def detect(self):
        self.start()
        print('[DETECTING]')
        start = time.time()
        for i in range(0, 10):
            _, self.frame = self.videoCapture.read()
            self.frame = cv2.rotate(self.frame, cv2.ROTATE_90_COUNTERCLOCKWISE)
            self.frame = self.frame[170:700, 100:400]
            self.frame = cv2.cvtColor(self.frame, cv2.COLOR_BGR2RGB)
            self.image = Image.fromarray(self.frame, 'RGB')
            self.sharpness_enhancer = ImageEnhance.Sharpness(self.image)
            self.image = self.sharpness_enhancer.enhance(2)
            self.contrast_enhancer = ImageEnhance.Contrast(self.image)
            self.image = self.contrast_enhancer.enhance(1.5)
            self.brightness_enhancer = ImageEnhance.Brightness(self.image)
            self.image = self.brightness_enhancer.enhance(.8)
            self.image = self.image.resize((224, 224))
            self.image_array = np.array(self.image)
            self.image_array = np.expand_dims(self.image_array, axis=0)
            self.prediction = self.model.predict(self.image_array)
            self.max_position = np.argmax(self.prediction, axis=1)
            self.currency = self.keys[self.val.index(self.max_position)]
            self.result_list.append(self.currency)
        self.videoCapture.release()
        print(self.result_list)
        self.max_currency = self.most_common(self.result_list)
        self.result_list = []
        self.prediction = 0
        self.image_array = 0
        if self.max_currency == 'Background':
            self.max_currency = '0'
        print('[Result Detector]   ', self.max_currency, time.time())
        if DEBUG:
            cv2.imshow('Prediction', self.frame)
            key = cv2.waitKey(1)
            if key == ord('q'):
                self.stop()
        end = time.time()
        print('[DEBUG] prediction took : {} seconds'.format(end-start))

    def clear(self):
        self.ret = 0
        self.result_list = []
        self.prediction = 0
        self.max_currency = 0
        self.frame = 0
        self.image = 0
        print('[CLEARED]')

    def stop(self):
        self.videoCapture.release()
        cv2.destroyAllWindows()
