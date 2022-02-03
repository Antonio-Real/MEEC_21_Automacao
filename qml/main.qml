import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "./pages"

ApplicationWindow {
    width: 1280
    height: 720
    visible: true
    title: qsTr("Hello World")

    id: appRoot


    footer: Label {
        id: labelTime

        font.pointSize: 10
        padding: 10
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter

        Timer {
            running: true
            triggeredOnStart: true
            interval: 1000
            repeat: true
            onTriggered: labelTime.text = new Date().toUTCString()
        }
    }

    MainPage {
        anchors.fill: parent
    }

}
