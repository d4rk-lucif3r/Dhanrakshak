#!python
#cython: language_level=3

import sys

from PySide2.QtCore import Qt, QUrl
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtWidgets import QApplication

from helpers.connection import Connection


def runQML():

    app = QApplication(sys.argv)
    QApplication.setOverrideCursor(Qt.BlankCursor)
    slot = Connection()
    engine = QQmlApplicationEngine()
    engine.rootContext().setContextProperty("slot", slot)
    engine.load(QUrl.fromLocalFile('screens/Dhanrakshak.qml'))

    if not engine.rootObjects():
        return -1

    return app.exec_()


if __name__ == "__main__":
    try:
        sys.exit(runQML())
    except KeyboardInterrupt:
        sys.exit(None)
