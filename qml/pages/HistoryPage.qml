import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15
import PlcTags 1.0

Page {
    id: root

    Component.onCompleted: {
        if(productionHistoryModelData) {
            listModel.clear()

            var datamodel = JSON.parse(productionHistoryModelData)
            for (var i = 0; i < datamodel.length; ++i) listModel.append(datamodel[i])
        }
    }
    Component.onDestruction: {
        var datamodel = []
        for (var i = 0; i < listModel.count; ++i) datamodel.push(listModel.get(i))
            productionHistoryModelData = JSON.stringify(datamodel)
    }

    function shoeSelection(type) {
        if(type === 1)
            return qsTr("Shoe")
        else if(type === 2)
            return qsTr("Boot")
        else if(type === 3)
            return qsTr("High Boot")
        else
            return qsTr("Shoe")
    }


    Tag {
        id: tagShoeType
        tagName: "GL_historic_shoestype"
        tagType: Tag.INT
        Component.onCompleted: initializeTag()
    }

    Tag {
        id: tagShoeQuantity
        tagName: "GL_historic_shoesquantity"
        tagType: Tag.INT
        Component.onCompleted: initializeTag()
    }


    Tag {
        property bool firstTime: true

        tagName: "GL_set_historic"
        tagType: Tag.BOOL
        periodicReads: true
        onDataChanged: {
            if((data === true) && (!firstTime)) {
                tagShoeQuantity.readTag()
                tagShoeType.readTag()
                listModel.append({"time" : new Date().toUTCString(), "type" : tagShoeType.data, "quantity" : tagShoeQuantity.data})
            }
            else {
                firstTime = false
            }
        }
        Component.onCompleted: initializeTag()
    }

    footer: RowLayout {
        spacing: 20
        Button {
            text: qsTr("Clear history")
            font.pointSize: 15
            Layout.leftMargin: 20
            onClicked: listModel.clear()
        }
        Item { Layout.fillWidth: true }
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
