import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../fontAwesome"
import "../pages"

Page {
    id: root

    header: ToolBar {

        RowLayout {
            spacing: 20
            anchors.fill: parent

            ToolButton {
                font.family: FontAwesome.fontFamily
                font.pixelSize: 20
                text: FontAwesome.bars
                onClicked: drawer.open()
            }

            Label {
                id: titleLabel
                text: listView.currentItem.text
                font.pixelSize: 20
                font.family: FontAwesome.fontFamily
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }

            ToolButton {
                font.family: FontAwesome.fontFamily
                font.pixelSize: 20
                text: FontAwesome.ellipsisV
                onClicked: optionsMenu.open()


                Menu {
                    id: optionsMenu
                    x: parent.width - width
                    transformOrigin: Menu.TopRight

                    Action {
                        property bool isOn: false
                        text: isOn ? "Turn off fan" : "Turn on fan"
                        onTriggered: {
                            if(isOn)
                                serial.writeToSerial("OFF\n")
                            else
                                serial.writeToSerial("ON\n")
                            isOn = !isOn
                        }
                    }
                    Action {
                        text: "Quit app"
                        onTriggered: Qt.quit()
                    }
                }
            }
        }
    }



    Drawer {
        id: drawer
        z: 5
        width: Math.min(root.width, root.height) / 3 * 2
        height: root.height

        Image {
            id: logo
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                margins: 10
            }
            fillMode: Image.PreserveAspectFit
            //source: "qrc:/assets/icons/est_logo.jpg"
        }

        ListView {
            id: listView

            focus: true
            anchors {
                top: logo.bottom
                topMargin: 20
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }

            delegate: ItemDelegate {
                width: listView.width
                highlighted: ListView.isCurrentItem
                font.family: FontAwesome.fontFamily
                font.pixelSize: 16
                text: modelData.icon + "    " + modelData.title

                onClicked: {
                    listView.currentIndex = index
                    drawer.close()
                }
            }

            model: [{ title: "System", icon: FontAwesome.wrench },
                    { title: "Automatic", icon: FontAwesome.plug },
                    { title: "Settings", icon: FontAwesome.cogs },
                    { title: "Alarms", icon: FontAwesome.warning },
                    { title: "Alarm history", icon: FontAwesome.list }]

            ScrollIndicator.vertical: ScrollIndicator { }
        }
    }

    StackLayout {
        anchors.fill: parent
        currentIndex: listView.currentIndex

        ProgramConfigPage {}
        Rectangle {}
        Rectangle {}
        AlarmsPage {}
    }
}
