from helpers.slots import ValUpdate
from shutil import which
from PySide2.QtCore import QUrl, Qt, QCoreApplication, QObject, QTimer
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtWidgets import QApplication
import sys

import random




def runQML():
   try:
      app =QApplication(sys.argv)
      slot = ValUpdate()
      engine = QQmlApplicationEngine()
      engine.rootContext().setContextProperty("slot", slot)
      engine.load(QUrl.fromLocalFile('screens/Segregation.qml'))


      if not engine.rootObjects():
         return -1
   
   
      return app.exec_()
   except KeyboardInterrupt:
      slot.stop()
      return -1
 
 
 
 
if __name__ == "__main__":
    sys.exit(runQML())

