import QtQuick 2.3

import QtQuick.Window 2.2
import QtQuick.Controls 1.1


ApplicationWindow
{
    id:main_v
    objectName: "main_view"
    width: 800

    height: 480
    flags: Qt.FramelessWindowHint | Qt.Window

    visible:true

    StackView {
        id: stack
        initialItem: starting_page
        anchors.fill: parent
}
    Component {
        id:  starting_page
        StartPage {}
    }
    Component {
        id: second_page
        DataPage {}
    }
    function load_page(page) {
           switch (page) {
           case 'Page 1':
               stack.pop(second_page)
               stack.push(starting_page)
               break;
           case 'Page 2':
               stack.pop(starting_page)
               stack.push(second_page);
               break;

       }


}}
