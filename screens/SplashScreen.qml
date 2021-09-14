import QtQuick 2.12
import QtQuick.Controls 2.1
import QtQuick.Dialogs 1.1

Item {
    id: splashroot
    width: 800
    height: 480

Rectangle {
    id: splashrect
    anchors.fill: parent

    Rectangle{
        id: imgWRapper
        anchors.fill: parent

        AnimatedImage {
            id: image
            anchors.fill: parent
            source: "../assets/img/logo.gif"

        }
}

}}
