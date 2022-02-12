import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15
import PlcTags 1.0
import "./pages"
import "./fontAwesome"

ApplicationWindow {
    id: appRoot

    width: 1280
    height: 720
    visible: true
    title: "Shoe Factory Manager"

    Material.accent: Material.BlueGrey

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

    Connections {
        target: ConnectionWatchdog

        function onIsOnlineChanged() {
            if(!ConnectionWatchdog.isOnline) {
                popupConnection.open()
            }
            else {
                popupConnection.close()
            }
        }
    }

    Popup {
        id: popupConnection
        anchors.centerIn: parent
        modal: true
        closePolicy: Popup.NoAutoClose
        padding: 30

        background: Rectangle {
            radius: 15
            color: Material.backgroundColor
        }

        ColumnLayout {
            anchors.fill: parent

            Label {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignCenter
                font.family: FontAwesome.fontFamily
                text: FontAwesome.spinner
                font.pointSize: 40
                horizontalAlignment: Text.AlignHCenter

                RotationAnimation on rotation {
                    from: 0
                    to: 360
                    duration: 1500
                    running: true
                    loops: Animation.Infinite
                }
            }

            Label {
                font.pointSize: 20
                text: qsTr("Connection to PLC currently offline, please check cabling")
            }
        }
    }

}
