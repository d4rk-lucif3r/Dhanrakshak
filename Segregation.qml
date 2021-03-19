import QtQuick 2.15

import QtQuick.Window 2.2
Window {
    id:main_v
    objectName: "main_view"
    width: 800
    height: 480

    visible:true
        Loader{
        id:pageloader
        source:"StartPage.qml"
        }



}
