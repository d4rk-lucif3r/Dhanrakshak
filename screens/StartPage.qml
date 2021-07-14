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

                Rectangle {
                    id: basicSantizeRectangle
                    x: 8
                    y: 177
                    width: 187
                    height: 63
                    color: "#ffc400"
                    radius: 15
                    Text {
                        id: basicSantizeText
                        anchors.fill: parent
                        color: "#000000"
                        text: qsTr("Basic Sanitize")
                        font.pixelSize: 25
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.Wrap
                        font.family: "Source Sans Pro"
                    }
                  MouseArea{
                      anchors.fill: parent
                      onClicked: {
                          startPageRoot.isPremium = false
                          confirmMessageDialog.visible = true
                      }
                  }

                }


                Rectangle {
                    id: premiumSanitizeRect
                    x: 8
                    y: 260
                    width: 187
                    height: 63
                    color: "#ffc400"
                    radius: 15

                    Text {
                        id: premiumSanitizeText
                       anchors.fill: parent
                       color: "#000000"
                       text: qsTr("Premium Sanitize")
                       font.pixelSize: 25
                       horizontalAlignment: Text.AlignHCenter
                       verticalAlignment: Text.AlignVCenter
                       lineHeight: 0.8
                       wrapMode: Text.Wrap
                       fontSizeMode: Text.Fit
                       font.family: "Source Sans Pro"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            startPageRoot.isPremium = true
                            confirmMessageDialog.visible = true
                        }
                    }
                }

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
                                id: cancelSelectorText
                                text: qsTr("Cancel")
                                anchors.fill: parent
                                font.pixelSize: 30
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.family: "Source Sans Pro"
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked:{
                                    selectorRect.visible=false;
                                    initializeStartText.visible = true;
                                }
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
                height: 83
                color: "#fdfdfd"
                text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\n</style></head><body style=\" font-family:'Titillium Web'; font-size:7pt; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Titillium Web','Source Sans Pro'; font-size:12pt;\">Please select</span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Titillium Web','Source Sans Pro'; font-size:12pt;\"> start button to Continue</span></p></body></html>"
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
                x: 419
                y: 386
                width: 132
                height: 55
                color: "#ffc400"
                radius: 15

                Text {
                    id: text1
                    anchors.fill:parent
                    text: qsTr("Start")
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
                    id: text2
                    text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\n</style></head><body style=\" font-family:'Titillium Web'; font-size:7pt; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Titillium Web','Source Sans Pro'; font-size:10pt; font-weight:600;\">Instructions:</span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Titillium Web','Source Sans Pro'; font-size:10pt;\">1) Click on start Button </span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Titillium Web','Source Sans Pro'; font-size:10pt;\">2) Select Which type of method you want to use:</span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Titillium Web','Source Sans Pro'; font-size:10pt;\">      a) Basic Method will only Sanitize with UV light </span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Titillium Web','Source Sans Pro'; font-size:10pt;\">      b) Premium Method will Sanitize with both UV light and Alcohol</span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Titillium Web','Source Sans Pro'; font-size:10pt;\">3) After you select any method tray box will open. </span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Titillium Web','Source Sans Pro'; font-size:10pt;\">4) Put your currency in that and click OK</span></p></body></html>"
                    anchors.fill:parent
                    font.pixelSize: 20
                    font.family: "Source Sans Pro"
                    textFormat: Text.RichText
                    anchors.rightMargin: 6
                    anchors.leftMargin: 8
                    anchors.bottomMargin: 104
                    anchors.topMargin: 8
                }

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
            }
        }

    }
}
    DataPage{
           id:dataPage_view
           visible: false
       }

    MessageDialog {
        id: confirmMessageDialog
        title: "Confirm"
        text: startPageRoot.isPremium?"You have Selected Premium Sanitize \nClick OK After Putting Currency in the Box":"You have Selected Basic Sanitize \nClick OK After Putting Currency in the Box"

        width: 350
        height:350
        onAccepted: {

            dataPage_view.visible = true
            selectorRect.visible = false
            startPageRoot.isStart = true
           // dataPage_view.dataPageRoot.timer.running = true
            initializeStartText.visible = true
        }
        visible:false

    }

}
