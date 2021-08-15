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
    property int oneThNote: 0
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
            id:imgRect
            x: 8
            y: 8
            width: 168
            height: 332
            color: "#0f0f0f"
            radius: 15
            Rectangle {
                id: rectangle10
                x: 9
                y: 48
                width: 151
                height: 50
                color: "#ffc400"
                radius: 15

                Text {
                    id: text10
                    text: qsTr("₹20")
                    anchors.fill: parent
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                    anchors.bottomMargin: 26
                    anchors.rightMargin: 0
                    padding: 5
                }

                Text {
                    id: text38
                    y: 42
                    height: 50
                    text: "Count :"
                    anchors.fill: parent
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 0
                    anchors.rightMargin: 73
                    padding: 5
                    anchors.topMargin: 25
                    anchors.bottomMargin: 0
                    font.bold: true
                }

                Text {
                    id: text39
                    y: 42
                    height: 50
                    text: twentyCoin
                    anchors.fill: parent
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 73
                    anchors.topMargin: 25
                    padding: 5
                    anchors.rightMargin: 0
                    anchors.bottomMargin: 0
                    font.bold: true
                }
            }

            Rectangle {
                id: rectangle11
                x: 8
                y: 104
                width: 152
                height: 50
                color: "#ffab00"
                radius: 15

                Text {
                    id: text11
                    text: qsTr("₹10")
                    anchors.fill: parent
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                    padding: 5
                    anchors.rightMargin: 0
                    anchors.bottomMargin: 26
                }

                Text {
                    id: text40
                    y: 42
                    height: 50
                    text: "Count :"
                    anchors.fill: parent
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 0
                    anchors.topMargin: 25
                    padding: 5
                    anchors.rightMargin: 73
                    anchors.bottomMargin: 0
                    font.bold: true
                }

                Text {
                    id: text41
                    y: 42
                    height: 50
                    text: tenCoin
                    anchors.fill: parent
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 73
                    anchors.rightMargin: 0
                    padding: 5
                    anchors.topMargin: 25
                    anchors.bottomMargin: 0
                    font.bold: true
                }


            }

            Rectangle {
                id: rectangle12
                x: 8
                y: 272
                width: 152
                height: 50
                color: "#ffc400"
                radius: 15

                Text {
                    id: text14
                    text: qsTr("₹1")
                    anchors.fill: parent
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                    padding: 5
                    anchors.rightMargin: 0
                    anchors.bottomMargin: 26
                }

                Text {
                    id: text46
                    y: 42
                    height: 50
                    text: "Count :"
                    anchors.fill: parent
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 0
                    anchors.topMargin: 25
                    padding: 5
                    anchors.rightMargin: 73
                    anchors.bottomMargin: 0
                    font.bold: true
                }

                Text {
                    id: text47
                    y: 42
                    height: 50
                    text: fiveCoin
                    anchors.fill: parent
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 73
                    anchors.topMargin: 25
                    padding: 5
                    anchors.rightMargin: 0
                    anchors.bottomMargin: 0
                    font.bold: true
                }
            }

            Rectangle {
                id: rectangle13
                x: 8
                y: 216
                width: 152
                height: 50
                color: "#ffab00"
                radius: 15

                Text {
                    id: text13
                    text: qsTr("₹2")
                    anchors.fill: parent
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                    anchors.rightMargin: 0
                    padding: 5
                    anchors.bottomMargin: 26
                }

                Text {
                    id: text44
                    y: 42
                    height: 50
                    text: fiveCoin
                    anchors.fill: parent
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 73
                    anchors.rightMargin: 0
                    padding: 5
                    anchors.topMargin: 25
                    anchors.bottomMargin: 0
                    font.bold: true
                }

                Text {
                    id: text45
                    y: 42
                    height: 50
                    text: "Count :"
                    anchors.fill: parent
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 0
                    anchors.rightMargin: 73
                    padding: 5
                    anchors.topMargin: 25
                    anchors.bottomMargin: 0
                    font.bold: true
                }
            }

            Rectangle {
                id: rectangle14
                x: 8
                y: 160
                width: 152
                height: 50
                color: "#ffc400"
                radius: 15

                Text {
                    id: text12
                    text: qsTr("₹5")
                    anchors.fill: parent
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                    padding: 5
                    anchors.rightMargin: 0
                    anchors.bottomMargin: 26
                }

                Text {
                    id: text42
                    y: 42
                    height: 50
                    text: "Count :"
                    anchors.fill: parent
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 0
                    anchors.topMargin: 25
                    padding: 5
                    anchors.rightMargin: 73
                    anchors.bottomMargin: 0
                    font.bold: true
                }

                Text {
                    id: text43
                    y: 42
                    height: 50
                    text: fiveCoin
                    anchors.fill: parent
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 73
                    anchors.topMargin: 25
                    padding: 5
                    anchors.rightMargin: 0
                    anchors.bottomMargin: 0
                    font.bold: true
                }
        }

        Rectangle {
            id: rectangle8
            x: 0
            y: 405
            width: 660
            height: 59

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
            id: rectangle9
            x: 175
            y: 2
            width: 485
            height: 330
            color: "#0f0f0f"
            radius: 15

            Rectangle {
                id: rectangle1
                x: 8
                y: 49
                width: 152
                height: 100
                color: "#ffc400"
                radius: 15
                Text {
                    id: text8
                    text: "₹2000"
                    
                    anchors.bottomMargin: 55
                    font.bold: true
                    textFormat: Text.RichText
                    anchors.fill: parent
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.rightMargin: 0
                    padding: 5
                }

                Text {
                    id: text18
                    x: 76
                    width: 76
                    height: 54
                    text: twoThNote
                    anchors.fill: parent
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 75
                    anchors.topMargin: 46
                    padding: 5
                    anchors.rightMargin: -2
                }

                Text {
                    id: text31
                    width: 76
                    height: 50
                    text: "Count :"
                    anchors.fill: parent
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 0
                    anchors.rightMargin: 73
                    padding: 5
                    anchors.topMargin: 46
                    anchors.bottomMargin: 0
                    font.bold: true
                }
            }

            Rectangle {
                id: rectangle2
                x: 325
                y: 49
                width: 152
                height: 100
                color: "#ffc400"
                radius: 15

                Text {
                    id: text21
                    height: 45
                    text: "₹500"
                    anchors.fill: parent
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    
                    anchors.bottomMargin: 58
                    textFormat: Text.RichText
                    anchors.rightMargin: 0
                    padding: 5
                    font.bold: true
                }

                Text {
                    id: text22
                    x: 76
                    width: 76
                    height: 54
                    text: fiveHunNote

                    anchors.fill: parent
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 82
                    anchors.topMargin: 48
                    padding: 5
                    anchors.rightMargin: -2
                    anchors.bottomMargin: 0
                    font.bold: true
                }

                Text {
                    id: text33
                    height: 50
                    text: "Count :"
                    anchors.fill: parent
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 0
                    anchors.topMargin: 46
                    padding: 5
                    anchors.rightMargin: 73
                    anchors.bottomMargin: 0
                    font.bold: true
                }
            }

            Rectangle {
                id: rectangle3
                x: 8
                y: 155
                width: 152
                height: 100
                color: "#ffc400"
                radius: 15

                Text {
                    id: text23
                    height: 45
                    text: "₹100"
                    anchors.fill: parent
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    
                    anchors.bottomMargin: 62
                    padding: 5
                    anchors.rightMargin: 0
                    textFormat: Text.RichText
                    font.bold: true
                }

                Text {
                    id: text24
                    x: 76
                    y: 42
                    width: 76
                    height: 54
                    text: oneHunNote
                    anchors.fill: parent
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 76
                    anchors.rightMargin: -2
                    padding: 5
                    anchors.topMargin: 44
                    anchors.bottomMargin: 0
                    font.bold: true
                }

                Text {
                    id: text34
                    y: 42
                    height: 50
                    text: "Count :"
                    anchors.fill: parent
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 0
                    anchors.topMargin: 46
                    padding: 5
                    anchors.rightMargin: 73
                    anchors.bottomMargin: 0
                    font.bold: true
                }
            }

            Rectangle {
                id: rectangle4
                x: 167
                y: 49
                width: 152
                height: 100
                color: "#ffab00"
                radius: 15

                Text {
                    id: text19
                    height: 45
                    text: "₹1000"
                    anchors.fill: parent
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    
                    anchors.bottomMargin: 62
                    padding: 5
                    anchors.rightMargin: 0
                    textFormat: Text.RichText
                    font.bold: true
                }

                Text {
                    id: text20
                    x: 76
                    width: 76
                    height: 544
                    text: oneThNote
                    anchors.fill: parent
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 77
                    anchors.rightMargin: -2
                    padding: 5
                    anchors.topMargin: 44
                    anchors.bottomMargin: 0
                    font.bold: true
                }

                Text {
                    id: text32
                    width: 76
                    height: 50
                    text: "Count :"
                    anchors.fill: parent
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 0
                    anchors.topMargin: 46
                    padding: 5
                    anchors.rightMargin: 73
                    anchors.bottomMargin: 0
                    font.bold: true
                }
            }

            Rectangle {
                id: rectangle5
                x: 166
                y: 155
                width: 152
                height: 100
                color: "#ffab00"
                radius: 15

                Text {
                    id: text25
                    height: 45
                    text: "₹50"
                    anchors.fill: parent
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    
                    anchors.bottomMargin: 64
                    textFormat: Text.RichText
                    anchors.rightMargin: 0
                    padding: 5
                    font.bold: true
                }

                Text {
                    id: text26
                    x: 76
                    width: 76
                    height: 54
                    text: fiftyNote
                    anchors.fill: parent
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 78
                    anchors.topMargin: 42
                    padding: 5
                    anchors.rightMargin: -2
                    anchors.bottomMargin: 0
                    font.bold: true
                }

                Text {
                    id: text35
                    height: 50
                    text: "Count :"
                    anchors.fill: parent
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 0
                    anchors.topMargin: 46
                    padding: 5
                    anchors.rightMargin: 73
                    anchors.bottomMargin: 0
                    font.bold: true
                }
            }

            Rectangle {
                id: rectangle6
                x: 325
                y: 155
                width: 152
                height: 100
                color: "#ffc400"
                radius: 15

                Text {
                    id: text27
                    height: 45
                    text: "₹20"
                    anchors.fill: parent
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    
                    anchors.bottomMargin: 64
                    padding: 5
                    anchors.rightMargin: 0
                    textFormat: Text.RichText
                    font.bold: true
                }

                Text {
                    id: text28
                    x: 76
                    width: 76
                    height: 54
                    text: twentyNote
                    anchors.fill: parent
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 77
                    anchors.rightMargin: -2
                    padding: 5
                    anchors.topMargin: 42
                    anchors.bottomMargin: 0
                    font.bold: true
                }

                Text {
                    id: text36
                    height: 50
                    text: "Count :"
                    anchors.fill: parent
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 0
                    anchors.topMargin: 46
                    padding: 5
                    anchors.rightMargin: 73
                    anchors.bottomMargin: 0
                    font.bold: true
                }
            }

            Rectangle {
                id: rectangle7
                x: 8
                y: 261
                width: 469
                height: 61
                color: "#ffab00"
                radius: 15

                Text {
                    id: text29
                    text: "₹10"
                    anchors.fill: parent
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    
                    anchors.topMargin: 8
                    anchors.bottomMargin: 33
                    textFormat: Text.RichText
                    anchors.rightMargin: 8
                    padding: 5
                    font.bold: true
                }

                Text {
                    id: text30
                    text: tenNote
                    anchors.fill: parent
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 229
                    anchors.rightMargin: -2
                    padding: 5
                    anchors.topMargin: 29
                    anchors.bottomMargin: 0
                    font.bold: true
                }

                Text {
                    id: text37
                    height: 50
                    text: "Count :"
                    anchors.fill: parent
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 0
                    anchors.topMargin: 29
                    padding: 5
                    anchors.rightMargin: 239
                    anchors.bottomMargin: 0
                    font.bold: true
                }
            }

            Rectangle {
                id: rectangle
                x: 8
                y: 8
                width: 467
                height: 35
                color: "#ffab00"
                radius: 15
                border.color :'#ffffff'
                border.width : 2

                Text {
                    id: text17
                    text: qsTr("Notes")
                    anchors.fill: parent
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                }
            }


        }

            Rectangle {
                id: rectangle16
                x: 8
                y: 8
                width: 152
                height: 35
                color: "#ffab00"
                radius: 15
                border.color: "#ffffff"
                border.width: 2

                Text {
                    id: text16
                    text: qsTr("Coins")
                    anchors.fill: parent
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                }
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

        Rectangle {
            id: cancelBtRoot
            x: 680
            y: 8
            width: 112
            height: 464
            color: "#0f0f0f"
            radius: 15
            Rectangle {
                id: cancelBt
                color: "#ffab00"
                radius: 15
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 7
                anchors.rightMargin: 7
                anchors.topMargin: 7
                Text {
                    id: canceBtText
                    text: qsTr("Stop")
                    anchors.fill: parent
                    font.pixelSize: 35
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: "Source Sans Pro "
                    font.bold: false
                }

                MouseArea {
                    anchors.fill: parent
                    anchors.bottomMargin: 0
                    onClicked: {

                    exitmessagealert.visible = true
                    }
                }
                anchors.bottomMargin: 7
            }
        }

        Rectangle {
            id: rectangle15
            x: 13
            y: 346
            width: 655
            height: 60
            color: "#ffc400"
            radius: 15
            border.color :'#000000'
            border.width : 5
            Text {
                id: text15
                text: "Total Money"
                anchors.fill: parent
                font.pixelSize: 30
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.leftMargin: 0
                padding: 5
                anchors.topMargin: 0
                anchors.rightMargin: 314
                anchors.bottomMargin: 0
                font.family: "Source Sans Pro"
                font.bold: true
            }

            Text {
                id: text48
                text: qsTr("₹ "+total)
                anchors.fill: parent
                font.pixelSize: 30
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.leftMargin: 342
                anchors.rightMargin: 0
                anchors.topMargin: 0
                padding: 5
                anchors.bottomMargin: 0
                font.family: "Source Sans Pro"
                font.bold: false
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

