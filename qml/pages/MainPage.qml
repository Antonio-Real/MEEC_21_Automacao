import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt.labs.settings 1.0
import Translation 1.0
import "../fontAwesome"
import "../pages"

Page {
    id: root

    // For saving the data in the ListModels
    property string alarmHistoryModelData: ""
    property string alarmModelData: ""
    property string productionHistoryModelData: ""

    Settings {
        property alias alarmHistoryModel: root.alarmHistoryModelData
        property alias alarmModel: root.alarmModelData
        property alias productionHistoryModel: root.productionHistoryModelData

        Component.onDestruction: {
            console.log(alarmHistoryModel)
            console.log(alarmModel)
            console.log(productionHistoryModel)
        }
    }

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
                        text: qsTr("Lang: EN")
                        onTriggered: TranslationManager.language = TranslationManager.EN
                    }

                    Action {
                        text: qsTr("Lang: PT")
                        onTriggered: TranslationManager.language = TranslationManager.PT
                    }

                    Action {
                        text: qsTr("Quit app")
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
            height: 200
            fillMode: Image.PreserveAspectFit
            source: "qrc:/qml/assets/logo.png"
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

            model: [{ title: qsTr("System"), icon: FontAwesome.dashboard },
                { title: qsTr("Automatic"), icon: FontAwesome.plug },
                { title: qsTr("Manual"), icon: FontAwesome.handOUp },
                { title: qsTr("Alarms"), icon: FontAwesome.warning },
                { title: qsTr("Maintenance"), icon: FontAwesome.wrench },
                { title: qsTr("History"), icon: FontAwesome.list },
                { title: qsTr("Settings"), icon: FontAwesome.cogs },]

            ScrollIndicator.vertical: ScrollIndicator { }
        }
    }

    SwipeView {
        interactive: false
        anchors.fill: parent
        currentIndex: listView.currentIndex

        SystemPage {}
        AutomaticPage {
            onProductionStarted: listView.currentIndex = 0 // Change to system page
        }
        ManualPage {}
        AlarmsPage {
            onAlarmDetected: listView.currentIndex = SwipeView.index
        }
        MaintenancePage {}
        HistoryPage {}
        SettingsPage {}
    }
}
