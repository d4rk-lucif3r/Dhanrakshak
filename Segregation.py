import sys

from PySide2.QtCore import QUrl
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtWidgets import QApplication

from helpers.slots import ValUpdate


def runQML():

    app = QApplication(sys.argv)
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
