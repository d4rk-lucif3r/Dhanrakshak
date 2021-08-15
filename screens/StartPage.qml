import QtQuick 2.12
import QtQuick.Controls 2.1
import QtQuick.Dialogs 1.1

Item {
    id: root
    width: 800
    height: 480

Rectangle {
    anchors.fill: parent
    radius: 15
    id: startPageRoot
    objectName: "startPageRoot"
    property bool isPremium : false
    property bool isStart : false
    property bool noteisUV : false
    property bool noteisEthanol : false
    property bool coinisUV : false
    property bool coinisEthanol : false
    Rectangle{
        anchors.fill: parent
        id:pageRect
        color: "#bdbdbd"
        radius: 0
        Rectangle{
            id:selectorRootRect

            x: 581
            y: 0
            width: 219
            height: 480
            color: "#90a4ae"
            border.width: 0
            Rectangle {
                id: selectorRect
                visible: false
                x: 8
                y: 13
                width: 203
                height: 459
                color: "#000000"
                radius: 15

//                Rectangle {
//                    id: basicSantizeRectangle
//                    x: 8
//                    y: 177
//                    width: 187
//                    height: 63
//                    color: "#ffc400"
//                    radius: 15
//                    Text {
//                        id: basicSantizeText
//                        anchors.fill: parent
//                        color: "#000000"
//                        text: qsTr("Basic Sanitize")
//                        font.pixelSize: 25
//                        horizontalAlignment: Text.AlignHCenter
//                        verticalAlignment: Text.AlignVCenter
//                        wrapMode: Text.Wrap
//                        font.family: "Source Sans Pro"
//                    }
//                  MouseArea{
//                      anchors.fill: parent
//                      onClicked: {
//                          startPageRoot.isPremium = false
//                          confirmMessageDialog.visible = true
//                      }
//                  }

//                }


//                Rectangle {
//                    id: premiumSanitizeRect
//                    x: 8
//                    y: 260
//                    width: 187
//                    height: 63
//                    color: "#ffc400"
//                    radius: 15

//                    Text {
//                        id: premiumSanitizeText
//                       anchors.fill: parent
//                       color: "#000000"
//                       text: qsTr("Premium Sanitize")
//                       font.pixelSize: 25
//                       horizontalAlignment: Text.AlignHCenter
//                       verticalAlignment: Text.AlignVCenter
//                       lineHeight: 0.8
//                       wrapMode: Text.Wrap
//                       fontSizeMode: Text.Fit
//                       font.family: "Source Sans Pro"
//                    }
//                    MouseArea{
//                        anchors.fill: parent
//                        onClicked: {
//                            startPageRoot.isPremium = true
//                            confirmMessageDialog.visible = true
//                        }
//                    }
//                }

                Rectangle {
                    id: instructionRect
                    x: 8
                    y: 16
                    width: 187
                    height: 130
                    color: "#ffc400"
                    radius: 15

                    Text {
                        id: instructionText
                        anchors.fill:parent
                        width: 187
                        height: 118
                        color: "#000000"
                        text: qsTr("Select Mode")
                        elide: Text.ElideNone
                        font.pixelSize: 35
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.NoWrap
                        renderType: Text.QtRendering
                        textFormat: Text.AutoText
                        topPadding: 5

                        fontSizeMode: Text.Fit
                        leftPadding: 10

                        padding: 5
                        rightPadding: 10
                        font.family: "Source Sans Pro"

                        Rectangle {
                            id: cancelSelectorRect

                            x: 0
                            y: 378
                            width: 187
                            height: 53
                            color: "#ffab00"
                            radius: 15

                            Text {
                                id: startText
                                text: qsTr("Lets GO!!")
                                anchors.fill: parent
                                font.pixelSize: 30
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.family: "Source Sans Pro"
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked:{
//                                    selectorRect.visible=false;
                                      messagealert.visible = true
//                                    dataPage_view.visible = true
//                                    selectorRect.visible = false
//                                    startPageRoot.isStart = true
//                                   // dataPage_view.dataPageRoot.timer.running = true
//                                    initializeStartText.visible = true
//                                    initializeStartText.visible = true;
                                }
                            }
                        }
                    }
                }

                Rectangle {
                    id: sanitizemethodrect
                    x: 8
                    y: 158
                    width: 187
                    height: 224
                    color: "#ffc400"
                    radius: 15

                    Rectangle {
                        id: notesantizieselect
                        x: 8
                        y: 8
                        width: 171
                        height: 99
                        color: "#ffab00"
                        radius: 15

                        Text {
                            id: text4
                            x: 8
                            y: 37
                            text: qsTr("Notes")
                            font.pixelSize: 20
                            font.bold: false
                            font.family: "Source Sans Pro"

                        }

//                        CheckBox {
//                            id: noteuvcheck
//                            x: 68
//                            y: 8
//                            width: 87
//                            height: 40
//                            text: qsTr("UV")
//                            onCheckStateChanged: {
//                                startPageRoot.noteisUV = noteuvcheck.checkState
//                            }
////                            checked: startPageRoot.noteisUV
//                            font.family: "Source Sans Pro"
//                            indicator: Rectangle {
//                                implicitWidth: 26
//                                implicitHeight: 26
//                                x: noteuvcheck.leftPadding
//                                y: parent.height / 2 - height / 2
//                                radius: 15
//                                color: "#000000"
//                                border.color: noteuvcheck.down ? "#ffab00" : "#ffc400"

//                                Rectangle {
//                                    width: 14
//                                    height: 14
//                                    x: 6
//                                    y: 6
//                                    radius: 15
//                                    color: noteuvcheck.down ? "#ffab00" : "#ffc400"
//                                    visible: noteuvcheck.checked
//                                }

//                            }
//                        }
                        Switch {
                            id: noteuvcheck
                            x: 56
                            y: 8
                            width: 99
                            height: 40
                            text: qsTr("UV")

                            font.pointSize: 12
                            onCheckedChanged: {
                                startPageRoot.noteisUV = noteuvcheck.checked
                            }
//                            checked: startPageRoot.noteisUV
                            font.family: "Source Sans Pro"
                            indicator: Rectangle {
                                    implicitWidth: 40
                                    implicitHeight: 20
                                    x: noteuvcheck.leftPadding
                                    y: parent.height / 2 - height / 2
                                    radius: 13
                                    color: noteuvcheck.checked ? "#ffc400" : "#ffffff"
                                    border.color: noteuvcheck.checked ? "#000000" : "#cccccc"

                                    Rectangle {
                                        x: noteuvcheck.checked ? parent.width - width : 0
                                        width: 20
                                        height: 20
                                        radius: 13
                                        color: noteuvcheck.checked ? "#e5b000" : "#ffffff"
                                        border.color: noteuvcheck.checked ?
                                                          (noteuvcheck.down ? "#ffc400" : "#000000") : "#999999"
                                    }
                                }

                                contentItem: Text {
                                    text: noteuvcheck.text
                                    font: noteuvcheck.font
                                    opacity: enabled ? 1.0 : 0.3
                                    color: noteuvcheck.down ? "#17a81a" : "#000000"
                                    verticalAlignment: Text.AlignVCenter
                                    leftPadding: noteuvcheck.indicator.width + noteuvcheck.spacing
                                }
                        }

//                        CheckBox {
//                            id: noteethanolcheck
//                            x: 68
//                            y: 51
//                            width: 87
//                            height: 40
//                            onCheckStateChanged: {
//                                startPageRoot.noteisEthanol = noteethanolcheck.checkState
//                            }

//                            text: qsTr("Ethanol")
//                            font.family: "Source Sans Pro"
//                            indicator: Rectangle {
//                                implicitWidth: 26
//                                implicitHeight: 26
//                                x: noteethanolcheck.leftPadding
//                                y: parent.height / 2 - height / 2
//                                radius: 15
//                                color: "#000000"
//                                border.color: noteethanolcheck.down ? "#ffab00" : "#ffc400"

//                                Rectangle {
//                                    width: 14
//                                    height: 14
//                                    x: 6
//                                    y: 6
//                                    radius: 15
//                                    color: noteethanolcheck.down ? "#ffab00" : "#ffc400"
//                                    visible: noteethanolcheck.checked
//                                }
//                            }
//                        }
                        CheckBox {
                            id: noteethanolcheck
                            x: 56
                            y: 51
                            width: 107
                            height: 40
                            onCheckedChanged: {
                                startPageRoot.noteisEthanol = noteethanolcheck.checked
                            }

                            text: qsTr("Ethanol")
                            font.family: "Source Sans Pro"
                            font.pointSize: 10
                            indicator: Rectangle {
                                    implicitWidth: 40
                                    implicitHeight: 20
                                    x: noteethanolcheck.leftPadding
                                    y: parent.height / 2 - height / 2
                                    radius: 13
                                    color: noteethanolcheck.checked ? "#ffc400" : "#ffffff"
                                    border.color: noteethanolcheck.checked ? "#000000" : "#cccccc"

                                    Rectangle {
                                        x: noteethanolcheck.checked ? parent.width - width : 0
                                        width: 20
                                        height: 20
                                        radius: 13
                                        color: noteethanolcheck.checked ? "#e5b000" : "#ffffff"
                                        border.color: noteethanolcheck.checked ?
                                                          (noteethanolcheck.down ? "#ffc400" : "#000000") : "#999999"
                                    }
                                }

                                contentItem: Text {
                                    text: noteethanolcheck.text
                                    font: noteethanolcheck.font
                                    opacity: enabled ? 1.0 : 0.3
                                    color: noteethanolcheck.down ? "#17a81a" : "#000000"
                                    verticalAlignment: Text.AlignVCenter

                                    leftPadding: noteethanolcheck.indicator.width + noteethanolcheck.spacing
                                }
                            }
                        }
                    
                    Rectangle {
                        id: coinsantizieselect
                        x: 8
                        y: 113
                        width: 171
                        height: 99
                        color: "#ffab00"
                        radius: 15
                        Text {
                            id: text5
                            x: 8
                            y: 37
                            text: qsTr("Coins")
                            font.pixelSize: 20
                            font.bold: false
                            font.family: "Source Sans Pro"
                        }

//                        CheckBox {
//                            id: coinuvcheck
//                            x: 68
//                            y: 8
//                            width: 87
//                            height: 40
//                            onCheckStateChanged: {
//                                startPageRoot.coinisUV = coinuvcheck.checkState
//                            }
////                            checked: startPageRoot.coinisUV
//                            text: qsTr("UV")
//                            font.family: "Source Sans Pro"
//                            indicator: Rectangle {
//                                    implicitWidth: 26
//                                    implicitHeight: 26
//                                    x: coinuvcheck.leftPadding
//                                    y: parent.height / 2 - height / 2
//                                    radius: 15
//                                    color: "#000000"
//                                    border.color: coinuvcheck.down ? "#ffab00" : "#ffc400"

//                                    Rectangle {
//                                        width: 14
//                                        height: 14
//                                        x: 6
//                                        y: 6
//                                        radius: 15
//                                        color: coinuvcheck.down ? "#ffab00" : "#ffc400"
//                                        visible: coinuvcheck.checked
//                                    }
//                                }
//                        }
                        Switch {
                            id: coinuvcheck
                            x: 56
                            y: 8
                            width: 107
                            height: 40
                            onCheckedChanged: {
                                startPageRoot.coinisUV = coinuvcheck.checked
                            }
//                            checked: startPageRoot.coinisUV
                            text: qsTr("UV")
                            font.pointSize: 12
                            font.family: "Source Sans Pro"
                            indicator: Rectangle {
                                    implicitWidth: 40
                                    implicitHeight: 20
                                    x: coinuvcheck.leftPadding
                                    y: parent.height / 2 - height / 2
                                    radius: 13
                                    color: coinuvcheck.checked ? "#ffc400" : "#ffffff"
                                    border.color: coinuvcheck.checked ? "#000000" : "#cccccc"

                                    Rectangle {
                                        x: coinuvcheck.checked ? parent.width - width : 0
                                        width: 20
                                        height: 20
                                        radius: 13
                                        color: coinuvcheck.checked ? "#e5b000" : "#ffffff"
                                        border.color: coinuvcheck.checked ?
                                                          (coinuvcheck.down ? "#ffc400" : "#000000") : "#999999"
                                    }
                                }

                                contentItem: Text {
                                    text: coinuvcheck.text
                                    font: coinuvcheck.font
                                    opacity: enabled ? 1.0 : 0.3
                                    color: coinuvcheck.down ? "#17a81a" : "#000000"
                                    verticalAlignment: Text.AlignVCenter

                                    leftPadding: coinuvcheck.indicator.width + coinuvcheck.spacing
                                }
                            
                        }

//                        CheckBox {
//                            id: coinethanolcheck
//                            x: 68
//                            y: 51
//                            width: 87
//                            height: 40
//                            onCheckStateChanged: {
//                                startPageRoot.coinisEthanol = coinethanolcheck.checkState
//                            }
////                            checked: startPageRoot.coinisEthanol
//                            text: qsTr("Ethanol")
//                            font.family: "Source Sans Pro"

//                            indicator: Rectangle {
//                                implicitWidth: 26
//                                implicitHeight: 26
//                                x: noteuvcheck.leftPadding
//                                y: parent.height / 2 - height / 2
//                                radius: 15
//                                color: "#000000"
//                                border.color: coinethanolcheck.down ? "#ffab00" : "#ffc400"

//                                Rectangle {
//                                    width: 14
//                                    height: 14
//                                    x: 6
//                                    y: 6
//                                    radius: 15
//                                    color: coinethanolcheck.down ? "#ffab00" : "#ffc400"
//                                    visible: coinethanolcheck.checked
//                                }
//                            }
//                        }
//                        CheckBox {
//                            id: coinethanolcheck
//                            x: 68
//                            y: 51
//                            width: 87
//                            height: 40
//                            onCheckStateChanged: {
//                                startPageRoot.coinisEthanol = coinethanolcheck.checkState
//                            }
////                            checked: startPageRoot.coinisEthanol
//                            text: qsTr("Ethanol")
//                            font.family: "Source Sans Pro"

//                            indicator: Rectangle {
//                                implicitWidth: 26
//                                implicitHeight: 26
//                                x: noteuvcheck.leftPadding
//                                y: parent.height / 2 - height / 2
//                                radius: 15
//                                color: "#000000"
//                                border.color: coinethanolcheck.down ? "#ffab00" : "#ffc400"

//                                Rectangle {
//                                    width: 14
//                                    height: 14
//                                    x: 6
//                                    y: 6
//                                    radius: 15
//                                    color: coinethanolcheck.down ? "#ffab00" : "#ffc400"
//                                    visible: coinethanolcheck.checked
//                                }
//                            }
//                        }
                        
                        Switch {
                            id: coinethanolcheck
                            x: 56
                            y: 51
                            width: 107
                            height: 40
                            onCheckedChanged: {
                                startPageRoot.coinisEthanol = coinethanolcheck.checked
                            }
//                            checked: startPageRoot.coinisEthanol
                            text: qsTr("Ethanol")
                            font.pointSize: 10
                            font.family: "Source Sans Pro"

                            indicator: Rectangle {
                                    implicitWidth: 40
                                    implicitHeight: 20
                                    x: coinethanolcheck.leftPadding
                                    y: parent.height / 2 - height / 2
                                    radius: 13
                                    color: coinethanolcheck.checked ? "#ffc400" : "#ffffff"
                                    border.color: coinethanolcheck.checked ? "#000000" : "#cccccc"

                                    Rectangle {
                                        x: coinethanolcheck.checked ? parent.width - width : 0
                                        width: 20
                                        height: 20
                                        radius: 13
                                        color: coinethanolcheck.checked ? "#e5b000" : "#ffffff"
                                        border.color: coinethanolcheck.checked ?
                                                          (coinethanolcheck.down ? "#ffc400" : "#000000") : "#999999"
                                    }
                                }

                                contentItem: Text {
                                    text: coinethanolcheck.text
                                    font: coinethanolcheck.font
                                    opacity: enabled ? 1.0 : 0.3
                                    color: coinethanolcheck.down ? "#17a81a" : "#000000"
                                    verticalAlignment: Text.AlignVCenter

                                    leftPadding: coinethanolcheck.indicator.width + coinethanolcheck.spacing
                                }
                            
                        }
                    }
                }
            }

            Text {
                id: initializeStartText
                x: 8
                y: 189
                width: 203
                height: 81
                visible: true
                color: "#fdfdfd"
                text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\n</style></head><body style=\" font-family:'MS Shell Dlg 2'; font-size:8.25pt; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Titillium Web','Source Sans Pro'; font-size:16pt;\">Tap on Select Method</span></p></body></html>"
                font.pixelSize: 15
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                textFormat: Text.RichText
                font.family: "Source Sans Pro Black"
            }
        }

        Rectangle {
            id: introRect
            x: 8
            y: 13
            width: 567
            height: 459
            color: "#000000"
            radius: 20
            border.color: "#000000"
            border.width: 0


            Rectangle {
                id: startButton
                x: 389
                y: 386
                width: 162
                height: 55
                color: "#ffc400"
                radius: 15

                Text {
                    id: text1
                    anchors.fill:parent
                    text: qsTr("Select Method")
                    font.pixelSize: 25
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.bold: false
                    font.family: "Source Sans Pro"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        selectorRect.visible = true
                        initializeStartText.visible = false
                    }}
            }

            Rectangle {
                id: rectangle
                x: 16
                y: 15
                width: 535
                height: 86
                color: "#ffc400"
                radius: 15
                Text {
                id: introText
                anchors.fill:parent
                color: "#ffffff"
                text: qsTr("Currency Sanitizer & Sorter")
                font.pixelSize: 35
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.Wrap
                font.bold: true
                font.family: "Source Sans Pro"
                }
            }

            Rectangle {
                id: rectangle2
                x: 16
                y: 112
                width: 535
                height: 260
                color: "#ffc400"
                radius: 15


                Text {
                    id: text3
                    x: 8
                    y: 167
                    width: 519
                    height: 85
                    text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\n</style></head><body style=\" font-family:'Titillium Web'; font-size:7pt; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Titillium Web','Source Sans Pro Black','Source Sans Pro'; font-size:14pt; font-weight:600;\">Note:</span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Source Sans Pro Black','Source Sans Pro'; font-size:14pt;\">Please Maintain 6 feet Social Distancing </span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Source Sans Pro Black','Source Sans Pro'; font-size:14pt;\">and wear Mask</span></p></body></html>"
                    font.pixelSize: 12
                    textFormat: Text.RichText
                }

                Text {
                    id: text2
                    text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\n</style></head><body style=\" font-family:'MS Shell Dlg 2'; font-size:8.25pt; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Titillium Web','Source Sans Pro'; font-size:10pt; font-weight:600;\">Instructions:</span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Titillium Web','Source Sans Pro'; font-size:10pt;\">1) Click on Select Method</span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Titillium Web','Source Sans Pro'; font-size:10pt;\">2) Select Which type of method you want to use for Coins and Notes:</span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Titillium Web','Source Sans Pro'; font-size:10pt;\">3) After you select any method tray box will open. </span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Titillium Web','Source Sans Pro'; font-size:10pt;\">4) Put your currency in that and click OK</span></p></body></html>"
                    anchors.fill:parent
                    font.pixelSize: 20
                    font.family: "Source Sans Pro"
                    textFormat: Text.RichText
                    anchors.rightMargin: 6
                    anchors.leftMargin: 8
                    anchors.bottomMargin: 104
                    anchors.topMargin: 8
                }


            }
        }

    }
    Rectangle{
        id : messagealert
        x: 265
        y: 173
        width:271
        height:135
        visible: false
        color: "#ecc679"
        radius: 15
        border.color :'#000000'
        border.width : 2

        Rectangle {
            id: rectangle1
            x: 8
            y: 38
            width: 255
            height: 51
            color: "#999999"
            radius: 15
            border.color :'#000000'
            border.width : 2

            Text {
                id: text6
                text: qsTr("Put money in slots and click ok")
                anchors.fill: parent
                font.pixelSize: 15
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.topMargin: 0
                font.family: "Source Sans Pro Black"
                font.bold: true
            }
        }

        Rectangle {
            id: rectangle3
            x: 8
            y: 95
            width: 120
            height: 32
            color: "#de5454"
            radius: 15
            border.color :'#000000'
            border.width : 2

            Text {
                id: alertcanceltxt
                text: qsTr("Cancel")
                anchors.fill: parent
                font.pixelSize: 15
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: true

            }
            MouseArea{
            anchors.fill:parent
            onClicked: {
                messagealert.visible = false
            }
            }
        }

        Rectangle {
            id: rectangle4
            x: 143
            y: 95
            width: 120
            height: 32
            color: "#a5f17c"
            radius: 15
            border.color :'#000000'
            border.width : 2
            Text {
                id: alertstarttext
                text: qsTr("Start")
                anchors.fill: parent
                font.pixelSize: 15
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: true
            }
            MouseArea{
            anchors.fill:parent
            onClicked: {
                  slot.start()
                  load_page('Page 2')
            }
            }
        }

        Rectangle {
            id: rectangle5
            x: 8
            y: 8
            width: 255
            height: 24
            color: "#999999"
            radius: 15
            border.color: "#000000"
            border.width: 2
            Text {
                id: text7
                text: qsTr("Alert Needed!")
                anchors.fill: parent
                font.pixelSize: 15
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.topMargin: 0
                font.family: "Source Sans Pro Black"
                font.bold: true
            }
        }
    }
}

    Timer{
            id : timer
            interval:500
            running: true
            repeat: true
            onTriggered: {
               // print('Timer Running')
                slot.methodCheck(startPageRoot)

            }
    }



}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.100000023841858}D{i:43}D{i:45}
}
##^##*/
