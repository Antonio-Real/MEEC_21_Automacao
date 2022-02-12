import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15
import PlcTags 1.0

Page {
    id: root

    function shoeSelection(type) {
        if(data === 1)
            return qsTr("Shoe")
        else if(data === 2)
            return qsTr("Boot")
        else if(data === 3)
            return qsTr("High Boot")
        else
            return qsTr("Shoe")
    }


    Tag {
        id: tagShoeType
        tagName: "GL_historic_shoestype"
        tagType: Tag.BOOL
        Component.onCompleted: initializeTag()
    }

    Tag {
        id: tagShoeQuantity
        tagName: "GL_historic_shoesquantity"
        tagType: Tag.BOOL
        Component.onCompleted: initializeTag()
    }


    Tag {
        tagName: "GL_set_historic"
        tagType: Tag.BOOL
        periodicReads: true
        onDataChanged: {
            if(data === true) {
                tagShoeQuantity.readTag()
                tagShoeType.readTag()
                listModel.append({"time" : new Date().toUTCString(), "type" : tagShoeType.data, "quantity" : tagShoeQuantity.data})
            }
        }
        Component.onCompleted: initializeTag()
    }


    ListView {
        id: alarmList
        anchors.fill: parent
        anchors.margins: 50
        spacing: 15
        clip: true

        model: ListModel {
            id: listModel
        }

        headerPositioning: ListView.OverlayHeader
        header: Rectangle {
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
                    text: qsTr("Time")
                    font.pointSize: 20
                    Layout.preferredWidth: 50
                    Layout.fillWidth: true
                    Layout.bottomMargin: 50
                }
                Label {
                    text: qsTr("Shoe type")
                    font.pointSize: 20
                    Layout.preferredWidth: 50
                    Layout.fillWidth: true
                    Layout.bottomMargin: 50
                }
                Label {
                    text: qsTr("Quantity")
                    font.pointSize: 20
                    Layout.preferredWidth: 70
                    Layout.fillWidth: true
                    Layout.bottomMargin: 50
                }
            }
        }

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
                    text: shoeSelection(type)
                    font.pointSize: 15
                    Layout.preferredWidth: 50
                    Layout.fillWidth: true
                }
                Label {
                    text: quantity
                    font.pointSize: 15
                    Layout.preferredWidth: 50
                    Layout.fillWidth: true
                }
            }
        }
    }
}
