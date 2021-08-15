import QtQuick 2.12
import QtQuick.Controls 2.1
import QtQuick.Dialogs 1.1

Rectangle {
    width: 800
    height: 480
    radius: 15
    id: dataPageRoot
    objectName: "dataPageRootObj"
    property int progress: 0
    property int total: 0

    property int twoThNote: 0
    property int fiveHunNote: 0
    property int twoHunNote: 0
    property int oneHunNote: 0
    property int fiftyNote: 0
    property int twentyNote: 0
    property int tenNote: 0


    property int twentyCoin: 0
    property int tenCoin: 0
    property int fiveCoin: 0
    property int twoCoin: 0
    property int oneCoin: 0

    

    Rectangle{
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        id: dataPageRect
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
                id: rectangle
                x: 8
                y: 8
                width: 203
                height: 464
                color: "#0f0f0f"
                radius: 15

                Rectangle {
                    id: rectangle1
                    x: 8
                    y: 8
                    width: 187
                    height: 50
                    color: "#ffc400"
                    radius: 15
                    Text {
                        id: text8
                        text: qsTr("₹2000 Note/s"+" : "+twoThNote)
                        anchors.fill: parent
                        font.pixelSize: 16
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        padding: 5


                    }
                }

                Rectangle {
                    id: rectangle2
                    x: 8
                    y: 72
                    width: 187
                    height: 50
                    color: "#ffab00"
                    radius: 15
                    Text {
                        id: text2
                       text: qsTr("₹500 Note/s"+"   : "+fiveHunNote)
                        anchors.fill: parent
                        font.pixelSize: 16
                        verticalAlignment: Text.AlignVCenter
                        padding: 5
                    }
                }

                Rectangle {
                    id: rectangle3
                    x: 8
                    y: 136
                    width: 187
                    height: 50
                    color: "#ffc400"
                    radius: 15

                    Text {
                        id: text3
                        text: qsTr("₹200 Note/s"+"   : "+twoHunNote)
                        anchors.fill: parent
                        font.pixelSize: 16
                        verticalAlignment: Text.AlignVCenter
                        padding: 5
                    }
                }

                Rectangle {
                    id: rectangle4
                    x: 8
                    y: 200
                    width: 187
                    height: 50
                    color: "#ffab00"
                    radius: 15

                    Text {
                        id: text4
                        text: qsTr("₹100 Note/s"+"   : "+oneHunNote)
                        anchors.fill: parent
                        font.pixelSize: 16
                        verticalAlignment: Text.AlignVCenter
                        padding: 5
                    }
                }

                Rectangle {
                    id: rectangle5
                    x: 8
                    y: 264
                    width: 187
                    height: 50
                    color: "#ffc400"
                    radius: 15

                    Text {
                        id: text5
                        text: qsTr("₹50 Note/s"+"     : "+fiftyNote)
                        anchors.fill: parent
                        font.pixelSize: 16
                        verticalAlignment: Text.AlignVCenter
                        padding: 5
                    }
                }

                Rectangle {
                    id: rectangle6
                    x: 8
                    y: 328
                    width: 187
                    height: 50
                    color: "#ffab00"
                    radius: 15

                    Text {
                        id: text6
                        text: qsTr("₹20 Note/s"+"     : "+twentyNote)
                        anchors.fill: parent
                        font.pixelSize: 16
                        verticalAlignment: Text.AlignVCenter
                        padding: 5
                    }
                }

                Rectangle {
                    id: rectangle7
                    x: 8
                    y: 390
                    width: 187
                    height: 54
                    color: "#ffc400"
                    radius: 15

                    Text {
                        id: text7
                        text: qsTr("₹10 Note/s"+"     : "+tenNote)
                        anchors.fill: parent
                        font.pixelSize: 16
                        verticalAlignment: Text.AlignVCenter
                        padding: 5


                    }
                }
            }
        }

        Rectangle {
            id: rectangle8
            x: 8
            y: 410
            width: 358
            height: 62

            color: "#0f0f0f"
            radius: 15

            ProgressBar {
                id: progressBar1
                height: 45
                anchors.fill: parent
                anchors.rightMargin: 10
                anchors.topMargin: 30
                value: dataPageRoot.progress * .01
                anchors.leftMargin: 10
            }

            Text {
                id: text1
               anchors.fill:parent
                color: "#fdfdfd"
                text: qsTr(" Progress")
                font.pixelSize: 18
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignTop
                anchors.leftMargin: 8
                anchors.topMargin: 8
                anchors.bottomMargin: 29
                anchors.rightMargin: 181


                font.family: "Source Sans Pro"

            }

            Text {
                id: text9
               anchors.fill:parent
                color: "#ffffff"
                text: qsTr(progress+"%")
                font.pixelSize: 25
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                anchors.topMargin: 8
                anchors.rightMargin: 10
                anchors.bottomMargin: 29
                anchors.leftMargin: 205
                padding: 5
                font.family: "Source Sans Pro Light"
            }
        }

        Rectangle {
            id: cancelBtRoot
            x: 372
            y: 410
            width: 203
            height: 62
            color: "#0f0f0f"
            radius: 15

            Rectangle {
                id: cancelBt
                anchors.rightMargin: 7
                anchors.leftMargin: 7
                anchors.bottomMargin: 7
                anchors.topMargin: 7
                color: "#ffab00"
                radius: 15
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom

                Text {
                    id: canceBtText
                   anchors.fill:parent
                    text: qsTr("Stop")
                    font.pixelSize: 35
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.bold: false
                    font.family: "Source Sans Pro "
                }
                MouseArea{
                    anchors.fill: parent
                    anchors.bottomMargin: 0
                    onClicked:
                    {
                        //popup.open()
                    //dataPageRoot.visible = false
                    exitmessagealert.visible = true

                    }

                }}

        }

        Rectangle {
            id: rectangle9
            x: 372
            y: 8
            width: 203
            height: 396
            color: "#0f0f0f"
            radius: 15

            Rectangle {
                id: rectangle10
                x: 8
                y: 13
                width: 187
                height: 50
                color: "#ffc400"
                radius: 15

                Text {
                    id: text10
                    text: qsTr("₹20 Coin/s"+" : "+twentyCoin)
                    anchors.fill: parent
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    padding: 5
                }
            }

            Rectangle {
                id: rectangle11
                x: 8
                y: 69
                width: 187
                height: 50
                color: "#ffab00"
                radius: 15

                Text {
                    id: text11
                    text: qsTr("₹10 Coin/s"+" : "+tenCoin)
                    anchors.fill: parent
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    padding: 5
                }


            }

            Rectangle {
                id: rectangle12
                x: 8
                y: 237
                width: 187
                height: 50
                color: "#ffc400"
                radius: 15

                Text {
                    id: text14
                    text: qsTr("₹1  Coin/s"+" : "+oneCoin)
                    anchors.fill: parent
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    padding: 5
                }
            }

            Rectangle {
                id: rectangle13
                x: 8
                y: 181
                width: 187
                height: 50
                color: "#ffab00"
                radius: 15

                Text {
                    id: text13
                    text: qsTr("₹2  Coin/s"+" : "+twoCoin)
                    anchors.fill: parent
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    padding: 5
                }
            }

            Rectangle {
                id: rectangle14
                x: 8
                y: 125
                width: 187
                height: 50
                color: "#ffc400"
                radius: 15

                Text {
                    id: text12
                    text: qsTr("₹5  Coin/s"+" : "+fiveCoin)
                    anchors.fill: parent
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    padding: 5
                }
            }
            Rectangle {
                id: rectangle15
                x: 8
                y: 295
                width: 187
                height: 93
                color: "#ffab00"
                radius: 15

                Text {
                    id: text15
                    text: qsTr("Total Money : ₹ "+total)
                    anchors.fill: parent
                    font.pixelSize: 15
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    font.bold: false
                    font.family: "Verdana"
                    padding: 5
                }
            }
        }
        Rectangle{
            id:imgRect
            x: 8
            y: 8
            width: 358
            height: 261
            color: "#0f0f0f"
            radius: 15
            Image {
                id: image
                anchors.fill:parent
                source: "../imports/assets/corona_mask.png"
                anchors.rightMargin: 9
                anchors.leftMargin: 9
                anchors.bottomMargin: 9
                anchors.topMargin: 9
                fillMode: Image.PreserveAspectFit

            }
        }

        Rectangle {
            id: rectangle16
            x: 8
            y: 275
            width: 358
            height: 129
            color: "#0f0f0f"
            radius: 15

            Text {
                id: text16
                color: "#fdfdfd"
                text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\n</style></head><body style=\" font-family:'Titillium Web'; font-size:7pt; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Source Sans Pro'; font-size:10pt;\">Earth is under the impact of Covid-19. </span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Source Sans Pro'; font-size:10pt;\">Help us to prevent its spread by </span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Source Sans Pro'; font-size:10pt;\">Wearing Masks, Using Hand Sanitizers and </span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Source Sans Pro'; font-size:10pt;\">Maintaining Social Distancing </span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Source Sans Pro'; font-size:10pt;\">Be a Hero not a Villain</span></p></body></html>"
                anchors.fill: parent
                font.pixelSize: 19
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignTop
                padding: 7
                font.family: "Source Sans Pro"
                wrapMode: Text.Wrap
                anchors.rightMargin: 7
                anchors.leftMargin: 7
                anchors.bottomMargin: 7
                anchors.topMargin: 7
                textFormat: Text.RichText
                font.weight: Font.Thin
                font.bold: false
            }
        }
        Rectangle{
            id : exitmessagealert
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
                id: alertmsgrect
                x: 8
                y: 38
                width: 255
                height: 51
                color: "#999999"
                radius: 15
                border.color :'#000000'
                border.width : 2

                Text {
                    id: alertmsgtxt
                    text: qsTr("Do you want to cancel??")
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
                id: alertcancelrect
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
                    text: qsTr("No")
                    anchors.fill: parent
                    font.pixelSize: 15
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true

                }
                MouseArea{
                anchors.fill:parent
                onClicked: {
                    exitmessagealert.visible = false
                }
                }
            }

            Rectangle {
                id: alertstartrect
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
                    text: qsTr("Yes")
                    anchors.fill: parent
                    font.pixelSize: 15
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                }
                MouseArea{
                anchors.fill:parent
                onClicked: {
                    slot.stop(timer)
                    load_page('Page 1')

                }
                }
            }

            Rectangle {
                id: alertmsgheadrect
                x: 8
                y: 8
                width: 255
                height: 24
                color: "#999999"
                radius: 15
                border.color: "#000000"
                border.width: 2
                Text {
                    id: alertmsgheadtxt
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
                slot.noteUpdate(dataPageRoot)
                slot.coinUpdate(dataPageRoot)
                slot.progress(dataPageRoot)
            }
    }

}

