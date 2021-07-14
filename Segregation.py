from helpers.slots import ValUpdate
from shutil import which
from PySide2.QtCore import QUrl, Qt, QCoreApplication, QObject, QTimer
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtWidgets import QApplication
import sys

import random




def runQML():

   app =QApplication(sys.argv)
   slot = ValUpdate()
   engine = QQmlApplicationEngine()
   engine.rootContext().setContextProperty("slot", slot)
   engine.load(QUrl.fromLocalFile('screens/Segregation.qml'))


   if not engine.rootObjects():
      return -1


   return app.exec_()

 
 
 
 
if __name__ == "__main__":
   try:
      sys.exit(runQML())
   except KeyboardInterrupt:
      sys.exit(None)

