import QtQuick 2.10
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
    property int count : 0
    property string pin_hint : 'Enter PIN to Shutdown'
    property string pin : ''
    property string asterisk : ''
    property int shutCount: 0
    property bool showSplash: true
    Rectangle{
        anchors.fill: parent
        id:pageRect
        color: "#d1d9ff"
        radius: 0


        Rectangle{
            id:selectorRootRect

            x: 581
            y: 0
            width: 219
            height: 480
            color: "#d1d9ff"
            border.width: 0

            Rectangle{
                id:shutdownselectorroot
                x: 8
                y: 13
                width: 203
                height: 459
                color: "#d1d9ff"

                visible: false

                Rectangle {
                    id: pin_rect
                    x: 3
                    y: 67
                    width: 200
                    height: 53
                    color: "#ffffff"
                    radius: 15

                    Text {
                        id: pin_rect_txt
                        color: startPageRoot.pin != '1258'?"#eb4934" :"#2cc75a"
                        text: startPageRoot.pin_hint

                        font.bold: true
                        verticalAlignment: Text.AlignVCenter
                        font.family: "Courier"
                        horizontalAlignment: Text.AlignHCenter
                        anchors.fill: parent
                        font.pixelSize: 11
                    }


                }

                Image {
                    id: image
                    x: 3
                    y: 138
                    width: 200
                    height: 254
                    sourceSize.width: -2
                    source: "../assets/img/numpad1.jpg"
                    fillMode: Image.PreserveAspectFit
                    Timer{
                        id: shutdownpinchecktimer
                        running: true
                        repeat: true
                        interval:100
                        onTriggered: {

                            if((startPageRoot.pin != '')&&(startPageRoot.pin.length<=4))
                            {
                               pin_rect_txt.text = startPageRoot.asterisk
                            }
                            if (startPageRoot.pin.length == 4){
                                if (startPageRoot.pin !='1258'){
                                    startPageRoot.pin = ''
                                    startPageRoot.asterisk =''
                                    pin_rect_txt.text = 'Incorrect PIN'
                                }

                            }


                        }

                    }
                    MouseArea {
                        id: mouseArea_1
                        x: 26
                        y: 24
                        width: 39
                        height: 41
                        onClicked: {
                            if (startPageRoot.pin.length<=4){
                                startPageRoot.pin+='1'
                                startPageRoot.asterisk+='*'
                            }

                        }
                    }

                    MouseArea {
                        id: mouseArea_2
                        x: 81
                        y: 24
                        width: 39
                        height: 41
                        onClicked: {
                            if (startPageRoot.pin.length<=4){
                                startPageRoot.pin+='2'
                                startPageRoot.asterisk+='*'
                            }
                        }
                    }

                    MouseArea {
                        id: mouseArea_3
                        x: 137
                        y: 24
                        width: 39
                        height: 41
                        onClicked: {
                            if (startPageRoot.pin.length<=4){
                                startPageRoot.pin+='3'
                                startPageRoot.asterisk+='*'
                            }
                        }
                    }

                    MouseArea {
                        id: mouseArea_4
                        x: 26
                        y: 82
                        width: 39
                        height: 41
                        onClicked: {
                            if (startPageRoot.pin.length<=4){
                                startPageRoot.pin+='4'
                                startPageRoot.asterisk+='*'
                            }
                        }
                    }

                    MouseArea {
                        id: mouseArea_5
                        x: 81
                        y: 82
                        width: 39
                        height: 41
                        onClicked: {
                            if (startPageRoot.pin.length<=4){
                                startPageRoot.pin+='5'
                                startPageRoot.asterisk+='*'
                            }
                        }
                    }

                    MouseArea {
                        id: mouseArea_6
                        x: 137
                        y: 82
                        width: 39
                        height: 41
                        onClicked: {
                            if (startPageRoot.pin.length<=4){
                                startPageRoot.pin+='6'
                                startPageRoot.asterisk+='*'
                            }
                        }
                    }

                    MouseArea {
                        id: mouseArea_7
                        x: 26
                        y: 134
                        width: 39
                        height: 41
                        onClicked: {
                            if (startPageRoot.pin.length<=4){
                                startPageRoot.pin+='7'
                                startPageRoot.asterisk+='*'
                            }
                        }
                    }

                    MouseArea {
                        id: mouseArea_8
                        x: 81
                        y: 134
                        width: 39
                        height: 41
                        onClicked: {
                            if (startPageRoot.pin.length<=4){
                                startPageRoot.pin+='8'
                                startPageRoot.asterisk+='*'
                            }
                        }
                    }

                    MouseArea {
                        id: mouseArea_9
                        x: 137
                        y: 134
                        width: 39
                        height: 41
                        onClicked: {
                            if (startPageRoot.pin.length<=4){
                                startPageRoot.pin+='9'
                                startPageRoot.asterisk+='*'
                            }
                        }
                    }

                    MouseArea {
                        id: mouseArea_asterisk
                        x: 26
                        y: 189
                        width: 39
                        height: 41
                        onClicked: {
                            if (startPageRoot.pin.length<=4){
                                startPageRoot.pin+='*'
                                startPageRoot.asterisk+='*'
                            }
                        }
                    }

                    MouseArea {
                        id: mouseArea_0
                        x: 81
                        y: 189
                        width: 39
                        height: 41
                        onClicked: {
                            if (startPageRoot.pin.length<=4){
                                startPageRoot.pin+='0'
                                startPageRoot.asterisk+='*'
                            }
                        }
                    }
                    MouseArea {
                        id: mouseArea_hashtag
                        x: 137
                        y: 189
                        width: 39
                        height: 41
                        onClicked: {
                            if (startPageRoot.pin.length<=4){
                                startPageRoot.pin+='#'
                                startPageRoot.asterisk+='*'
                            }
                        }
                    }
                }

                Rectangle {
                    id: rectangle6
                    x: 3
                    y: 398
                    width: 200
                    height: 53
                    color: "#bf0d0d"
                    radius: 15
                    border.width: 3

                    Text {
                        id: element
                        text: qsTr("Shutdown")
                        font.bold: true
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        anchors.fill: parent
                        font.pixelSize: 21
                    }
                    MouseArea{
                        enabled: startPageRoot.pin == '1258' ? true : false
                        anchors.fill: parent
                        onClicked: {
                            print('Shutting Down')
                            slot.shutdown()
                        }
                    }

                }



            }
            Rectangle {
                id: selectorRect
                visible: false
                x: 0
                y: 13
                width: 211
                height: 459
                color: "#000000"
                radius: 15

//                Rectangle {
//                    id: basicSantizeRectangle
//                    x: 8
//                    y: 177
//                    width: 187
//                    height: 63
//                    color: "#7986cb"
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
//                    color: "#7986cb"
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
                    color: "#7986cb"
                    radius: 15
                    border.color: "#aab6f3"
                    border.width: 3

                    Text {
                        id: instructionText
                        anchors.fill:parent
                        width: 187
                        height: 118
                        color: "#000000"
                        text: qsTr("Modes")
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
                            color: "#b2fab4"
                            radius: 15
                            border.width: 3
                            border.color: "#519657"

                            Text {
                                id: startText
                                text: qsTr("Let's GO!!")
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
                                                Text {
                            id: modenotselectedtxt
                            x: 25
                            y: 108
                            color: "#da0e0e"
                            text: qsTr("Please Select Either Mode")
                            visible: false
                            font.pixelSize: 12
                        }
                    }
                }

                Rectangle {
                    id: sanitizemethodrect
                    x: 8
                    y: 158
                    width: 187
                    height: 224
                    color: "#aab6f3"
                    radius: 15

                    Rectangle {
                        id: notesantizieselect
                        x: 8
                        y: 8
                        width: 171
                        height: 99
                        color: "#7986cb"
                        radius: 15
                        border.width: 2

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
//                                startPageRoot.noteisUV = noteuvcheck.checkState;
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
//                                border.color: noteuvcheck.down ? "#aab6fe" : "#7986cb"

//                                Rectangle {
//                                    width: 14
//                                    height: 14
//                                    x: 6
//                                    y: 6
//                                    radius: 15
//                                    color: noteuvcheck.down ? "#aab6fe" : "#7986cb"
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
                                startPageRoot.noteisUV = noteuvcheck.checked;
                                modenotselectedtxt.visible = false;
                            }
//                            checked: startPageRoot.noteisUV
                            font.family: "Source Sans Pro"
                            indicator: Rectangle {
                                    implicitWidth: 40
                                    implicitHeight: 20
                                    x: noteuvcheck.leftPadding
                                    y: parent.height / 2 - height / 2
                                    radius: 13
                                    border.color: "#000000"
                                    color: noteuvcheck.checked ? "#7986cb" : "#ffffff"
                                    Rectangle {
                                        x: noteuvcheck.checked ? parent.width - width : 0
                                        width: 20
                                        height: 20
                                        radius: 13
                                        color: noteuvcheck.checked ? "#474f8e" : "#ffffff"
                                        border.color: noteuvcheck.checked ?
                                                          (noteuvcheck.down ? "#7986cb" : "#000000") : "#999999"
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
//                                border.color: noteethanolcheck.down ? "#aab6fe" : "#7986cb"

//                                Rectangle {
//                                    width: 14
//                                    height: 14
//                                    x: 6
//                                    y: 6
//                                    radius: 15
//                                    color: noteethanolcheck.down ? "#aab6fe" : "#7986cb"
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
                                startPageRoot.noteisEthanol = noteethanolcheck.checked;
                                modenotselectedtxt.visible = false;
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
                                    border.color: "#000000"
                                    color: noteethanolcheck.checked ? "#7986cb" : "#ffffff"
                                    Rectangle {
                                        x: noteethanolcheck.checked ? parent.width - width : 0
                                        width: 20
                                        height: 20
                                        radius: 13
                                        color: noteethanolcheck.checked ? "#474f8e" : "#ffffff"
                                        border.color: noteethanolcheck.checked ?
                                                          (noteethanolcheck.down ? "#7986cb" : "#000000") : "#999999"
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
                        color: "#7986cb"
                        radius: 15
                        border.width: 2
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
//                                startPageRoot.coinisUV = coinuvcheck.checkState;
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
//                                    border.color: coinuvcheck.down ? "#aab6fe" : "#7986cb"

//                                    Rectangle {
//                                        width: 14
//                                        height: 14
//                                        x: 6
//                                        y: 6
//                                        radius: 15
//                                        color: coinuvcheck.down ? "#aab6fe" : "#7986cb"
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
                                startPageRoot.coinisUV = coinuvcheck.checked;
                                modenotselectedtxt.visible = false;
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
                                    border.width: 1
                                    color: coinuvcheck.checked ? "#7986cb" : "#ffffff"
                                    Rectangle {
                                        x: coinuvcheck.checked ? parent.width - width : 0
                                        width: 20
                                        height: 20
                                        radius: 13
                                        color: coinuvcheck.checked ? "#474f8e" : "#ffffff"
                                        border.color: coinuvcheck.checked ?
                                                          (coinuvcheck.down ? "#7986cb" : "#000000") : "#999999"
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
//                                border.color: coinethanolcheck.down ? "#aab6fe" : "#7986cb"

//                                Rectangle {
//                                    width: 14
//                                    height: 14
//                                    x: 6
//                                    y: 6
//                                    radius: 15
//                                    color: coinethanolcheck.down ? "#aab6fe" : "#7986cb"
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
//                                border.color: coinethanolcheck.down ? "#aab6fe" : "#7986cb"

//                                Rectangle {
//                                    width: 14
//                                    height: 14
//                                    x: 6
//                                    y: 6
//                                    radius: 15
//                                    color: coinethanolcheck.down ? "#aab6fe" : "#7986cb"
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
                                startPageRoot.coinisEthanol = coinethanolcheck.checked;
                                modenotselectedtxt.visible = false;
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
                                    border.color: "#000000"
                                    color: coinethanolcheck.checked ? "#7986cb" : "#ffffff"

                                    Rectangle {
                                        x: coinethanolcheck.checked ? parent.width - width : 0
                                        width: 20
                                        height: 20
                                        radius: 13
                                        color: coinethanolcheck.checked ? "#474f8e" : "#ffffff"
                                        border.color: coinethanolcheck.checked ?
                                                          (coinethanolcheck.down ? "#7986cb" : "#000000") : "#999999"
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
                color: "#000000"
                text: "Tap on Select Method"
                font.pixelSize: 15
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                textFormat: Text.RichText
                font.family: "Source Sans Pro Black"
            }

            Image {
                id: shutdowncallbtn
                x: 185
                y: 8
                width: 26
                height: 31
                z: 1
                source: "../assets/img/shutdown.png"
                fillMode: Image.PreserveAspectFit
                MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(startPageRoot.shutCount == 0){
                    shutdownselectorroot.visible = true;
                    startPageRoot.pin = ''
                    startPageRoot.asterisk = ''
                    pin_rect_txt.text = startPageRoot.pin_hint
                        initializeStartText.visible = false;
                        startPageRoot.shutCount = 1;
                        return
                    }

                    if(startPageRoot.shutCount == 1){
                    shutdownselectorroot.visible = false;
                    startPageRoot.pin = ''
                    startPageRoot.asterisk = ''
                    pin_rect_txt.text = startPageRoot.pin_hint
                    initializeStartText.visible = true;
                        startPageRoot.shutCount = 0;
                        return
                    }
                }
                }
            }
        }

        Rectangle {
            id: introRect
            x: 8
            y: 13
            width: 567
            height: 459
            radius: 20
            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: "#000000"
                }

                GradientStop {
                    position: 1
                    color: "#020202"
                }
            }
            border.color: "#000000"
            border.width: 0


            Rectangle {
                id: startButton
                x: 391
                y: 391
                width: 162
                height: 55
                color: "#7986cb"
                radius: 15
                border.color: "#aab6f3"
                border.width: 3

                Text {
                    id: text1
                    color: "#000000"
                    anchors.fill:parent
                    text: qsTr("Select Mode")
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
                        startButton2.visible = true
                        startButton.visible = false
                        shutdowncallbtn.visible = false
                        shutdownselectorroot.visible = false

                    }}
            }
            Rectangle {
                id: startButton2
                x: 390
                y: 391
                width: 162
                height: 55
                color: "#d32f2f"
                radius: 15
                visible: false
                border.color: "#aab6f3"
                border.width: 3

                Text {
                    id: text12
                    anchors.fill:parent
                    text: qsTr("Cancel")
                    font.pixelSize: 25
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.bold: false
                    font.family: "Source Sans Pro"
                }

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        selectorRect.visible = false
                        initializeStartText.visible = true
                        startButton.visible = true
                        startButton2.visible = false
                        shutdowncallbtn.visible = true
                    }}
            }
            Rectangle {
                id: rectangle
                x: 16
                y: 15
                width: 535
                height: 86
                color: "#7986cb"
                radius: 15
                border.color: "#aab6f3"
                border.width: 3
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
                height: 268
                color: "#aab6fe"
                radius: 15
                border.color: "#7986cb"
                border.width: 3

                Rectangle
                {
                    x: 8
                    y: 175
                    width: 519
                    height: 85
                    color: "#aab6fe"
                    radius: 15
                    border.width: 2

                    Text {
                    id: text3

                    text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\n</style></head><body style=\" font-family:'Titillium Web'; font-size:7pt; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Titillium Web','Source Sans Pro Black','Source Sans Pro'; font-size:14pt; font-weight:600;\">Note:</span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Source Sans Pro Black','Source Sans Pro'; font-size:14pt;\">Please Maintain 6 feet Social Distancing </span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Source Sans Pro Black','Source Sans Pro'; font-size:14pt;\">and wear Mask</span></p></body></html>"
                    anchors.leftMargin: 6
                    anchors.topMargin: 7
                    anchors.fill: parent
                    font.capitalization: Font.MixedCase
                    font.family: "Times New Roman"
                    font.pixelSize: 10
                    textFormat: Text.RichText
                }}

                Text {
                    id: text2
                    text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\n</style></head><body style=\" font-family:'MS Shell Dlg 2'; font-size:8.25pt; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Titillium Web','Source Sans Pro'; font-size:14pt; font-weight:600;\">Instructions:</span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Titillium Web','Source Sans Pro'; font-size:14pt;\">1) Click on Select Method</span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Titillium Web','Source Sans Pro'; font-size:14pt;\">2) Select Which type of method you want to use for <br>    Coins and Notes</span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Titillium Web','Source Sans Pro'; font-size:14pt;\">3) After you select any method tray box will open. </span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Titillium Web','Source Sans Pro'; font-size:14pt;\">4) Put your currency in that and click OK</span></p></body></html>"
                    font.pointSize: 6
                    fontSizeMode: Text.FixedSize
                    verticalAlignment: Text.AlignTop
                    horizontalAlignment: Text.AlignLeft
                    anchors.fill:parent
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
        color: "#0d47a1"
        radius: 15
        border.color :"#000000"
        border.width : 3

        Rectangle {
            id: rectangle1
            x: 8
            y: 43
            width: 255
            height: 46
            color: "#aab6fe"
            radius: 15
            border.color :'#000000'
            border.width : 2

            Text {
                id: text6
                text: qsTr("Put money in slots and click ok")
                anchors.fill: parent
                font.pixelSize: 13
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
            radius: 15
            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: "#fd8b82"
                }

                GradientStop {
                    position: 1.4
                    color: "#000000"
                }
            }
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
            radius: 15
            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: "#a5f17c"
                }

                GradientStop {
                    position: 1.4
                    color: "#000000"
                }
            }
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
                  if((startPageRoot.noteisUV)||(startPageRoot.noteisEthanol)||(startPageRoot.coinisUV)||(startPageRoot.coinisEthanol)){
                  slot.start()
                   modenotselectedtxt.visible = false;
                  load_page('Page 2')
            }
            else{
                  modenotselectedtxt.visible = true;
                  }
            }
            }
        }

        Rectangle {
            id: rectangle5
            x: 8
            y: 8
            width: 255
            height: 29
            color: "#d6b404"
            radius: 15
            border.color: "#000000"
            border.width: 2
            Text {
                id: text7
                text: qsTr("ALERT!!!")
                anchors.bottomMargin: 0
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
    Timer{
        id : splashTimer
        interval: 10000
        running: true
        onTriggered: {
          startPageRoot.showSplash = false
        //    slot.splashCheck(startPageRoot)

        }


    }

SplashScreen{
id: splash
visible: startPageRoot.showSplash
}

}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.100000023841858}D{i:43}D{i:45}
}
##^##*/



















































































































































/*##^## Designer {
    D{i:22;anchors_x:89;anchors_y:20}
}
 ##^##*/
