import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import QtMultimedia 5.15
import PlcTags 1.0

Page {
    id: root

    signal alarmDetected()

    header: TabBar {
        id: tab
        width: root.width
        TabButton {
            text: qsTr("Alarms")
            font.pointSize: 20
        }
        TabButton {
            text: qsTr("Alarm History")
            font.pointSize: 20
        }
    }
    footer: RowLayout {
        spacing: 20
        Button {
            text: qsTr("Clear all alarms")
            font.pointSize: 20
            Layout.leftMargin: 20
            onClicked: {
                alarmModel.clear()
                alarmHistoryModel.clear()
            }
        }
        Item { Layout.fillWidth: true }
    }

    property var tagList: [
        { tagName : "Al_Emergency", alarmMessage : qsTr("Emergency") },
        { tagName : "Al_set_Fill_30", alarmMessage : qsTr("Amount of filling is less than 30%") },
        { tagName : "Al_set_Filing5", alarmMessage : qsTr("Amount of filling is less than 30%") },
        { tagName : "Al_set_Paint_Tank1_30", alarmMessage : qsTr("Paint level in tank A is lower than 30%") },
        { tagName : "Al_set_Ink_1", alarmMessage : qsTr("Paint level in tank A is lower than 5%") },
        { tagName : "Al_set_Paint_Tank2_30", alarmMessage : qsTr("Paint level in tank B is lower than 30%") },
        { tagName : "Al_set_Ink_2", alarmMessage : qsTr("Paint level in tank B is lower than 5%") },
        { tagName : "Al_set_Paint_Tank3_30", alarmMessage : qsTr("Paint level in tank C is lower than 30%") },
        { tagName : "Al_set_Ink_3", alarmMessage : qsTr("Paint level in tank C is lower than 5%") },
        { tagName : "Al_conveyor_alarm", alarmMessage : qsTr("Conveyor belt fault") },
        { tagName : "Al_system_pause", alarmMessage : qsTr("System is paused") },
        { tagName : "Al_set_Air_Insufficiet", alarmMessage : qsTr("Insufficient air pressure") },
        { tagName : "Al_set_Brush_1_Use", alarmMessage : qsTr("Brush 1 usage limit reached") },
        { tagName : "Al_set_Brush_2_Use", alarmMessage : qsTr("Brush 2 usage limit reached") },
        { tagName : "Al_set_Brush_3_Use", alarmMessage : qsTr("Brush 3 usage limit reached") }
    ]

    Repeater {
        model: tagList
        delegate: Item {
            Tag {
                tagType: Tag.BOOL
                tagName: modelData.tagName
                readInterval: 500
                periodicReads: true
                onDataChanged: {
                    if(data === true) {
                        alarmModel.append({"time" : new Date().toUTCString(), "message" : modelData.alarmMessage})
                        buzzer.play()
                        alarmDetected()
                    }
                }

                Component.onCompleted: initializeTag()
            }
        }
    }

    Audio {
        id: buzzer
        source: "qrc:/qml/assets/buzzer.mp3"
    }

    Component {
        id: listHeader
        Rectangle {
            width: alarmList.width
            implicitWidth: headerRow.implicitWidth
            implicitHeight: headerRow.implicitHeight
            color: Material.backgroundColor
            clip: true
            z: 2

            RowLayout {
                id: headerRow
                anchors.fill: parent
                spacing: 10

                Label {
                    text: qsTr("Time of alarm")
                    font.pointSize: 20
                    Layout.preferredWidth: 50
                    Layout.fillWidth: true
                    Layout.bottomMargin: 50
                }
                Label {
                    text: qsTr("Alarm message")
                    font.pointSize: 20
                    Layout.preferredWidth: 70
                    Layout.fillWidth: true
                    Layout.bottomMargin: 50
                }
            }
        }
    }

    StackLayout {
        anchors.fill: parent
        anchors.margins: 50
        currentIndex: tab.currentIndex

        ListView {
            id: alarmList
            spacing: 15
            clip: true

            model: ListModel {
                id: alarmModel
            }

            headerPositioning: ListView.OverlayHeader
            header: listHeader

            delegate: Frame {
                width: alarmList.width
                RowLayout {
                    anchors.fill: parent
                    spacing: 10
                    Label {
                        text: time
                        font.pointSize: 15
                        Layout.preferredWidth: 50
                        Layout.fillWidth: true
                    }
                    Label {
                        text: message
                        font.pointSize: 15
                        Layout.preferredWidth: 50
                        Layout.fillWidth: true
                    }
                    Button {
                        text: "Confirm"
                        font.pointSize: 16
                        Layout.fillWidth: true
                        Layout.preferredWidth: 20
                        onClicked: {
                            alarmHistoryModel.append({"time" : time, "message" : message})
                            alarmModel.remove(index)
                        }
                    }
                }
            }
        }

        ListView {
            id: alarmHistoryList
            spacing: 15
            clip: true

            model: ListModel {
                id: alarmHistoryModel
            }

            headerPositioning: ListView.OverlayHeader
            header: listHeader

            delegate: Frame {
                width: alarmList.width
                RowLayout {
                    anchors.fill: parent
                    spacing: 10
                    Label {
                        text: time
                        font.pointSize: 15
                        Layout.preferredWidth: 50
                        Layout.fillWidth: true
                    }
                    Label {
                        text: message
                        font.pointSize: 15
                        Layout.preferredWidth: 50
                        Layout.fillWidth: true
                    }
                }
            }
        }
    }
}
