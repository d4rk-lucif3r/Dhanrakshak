from shutil import which
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtWidgets import QApplication
import sys
from PyQt5 import QtCore
from functools import partial
import random

def CheckStart(dataRootObj,startRootObj):
   isStart=startRootObj.property("isStart")
   if isStart:
      CheckMethod(startRootObj)
      Note(dataRootObj)
      Coin(dataRootObj)
      Misc(dataRootObj)

def Note(rootObj) :
   rootObj.setProperty("twoThNote",random.randint(0,120))
   rootObj.setProperty("fiveHunNote",random.randint(0,120))
   rootObj.setProperty("twoHunNote",random.randint(0,120))
   rootObj.setProperty("oneHunNote",random.randint(0,120))
   rootObj.setProperty("fiftyNote",random.randint(0,120))
   rootObj.setProperty("twentyNote",random.randint(0,120))
   rootObj.setProperty("tenNote",random.randint(0,120))
def Misc(rootObj):
   rootObj.setProperty("progress",random.randint(0,100))
   rootObj.setProperty("total",random.randint(0,120))
def Coin(rootObj):
   rootObj.setProperty("twentyCoin",random.randint(0,120))
   rootObj.setProperty("tenCoin",random.randint(0,120))
   rootObj.setProperty("fiveCoin",random.randint(0,120))
   rootObj.setProperty("twoCoin",random.randint(0,120))
   rootObj.setProperty("oneCoin",random.randint(0,120))
def CheckMethod(rootObj):
   whichMethod=rootObj.property("isPremium")
   if whichMethod:
      print("Premium Method Selected")
   else:
      print("Basic Method Selected")



def runQML():
    app =QApplication(sys.argv)
    engine = QQmlApplicationEngine()
    engine.load(QtCore.QUrl.fromLocalFile('Segregation.qml'))
    dataRootObj = engine.rootObjects()[0].findChild(QtCore.QObject, "dataPageRootObj")
    startRootObj = engine.rootObjects()[0].findChild(QtCore.QObject, "startPageRoot")
    

    timer = QtCore.QTimer(interval=300)
    timer.timeout.connect(partial(CheckStart,dataRootObj,startRootObj))
    

    timer.start()

    if not engine.rootObjects():
        return -1
 
    return app.exec_()
 
 
 
 
if __name__ == "__main__":
    sys.exit(runQML())

