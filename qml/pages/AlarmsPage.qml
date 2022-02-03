import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import PlcTags 1.0

Page {
    id: root
    title: "Alarms"

    Tag {
        id: alarm
        tagName: "Al_set_Fill_30"
        tagType: Tag.BOOL
        //periodicReads: true
        readInterval: 1000

        onDataChanged: console.log("Data: " + data)

        Component.onCompleted: initializeTag()
    }

    Rectangle {
        anchors.centerIn: parent
        radius: 100
        width: 100
        height: 100
        color: alarm.data === true ? "lightgreen" : "lightsalmon"
    }
}
