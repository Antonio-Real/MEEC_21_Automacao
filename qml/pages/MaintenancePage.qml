import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import PlcTags 1.0

Page {
    id: root
    title: "Maintenance"

    padding: 50


    property var repeaterModel: [
        {label : "Carpet Motor", maxVal : 20, currVal : 0, units : "H"},
        {label : "Brush 1", maxVal : 36, currVal : 0, units : "u"},
        {label : "Brush 2", maxVal : 25, currVal : 0, units : "u"},
        {label : "Brush 3", maxVal : 45, currVal : 0, units : "u"},
        {label : "Ink tank A", maxVal : 560, currVal : 0, units : "L"},
        {label : "Ink tank B", maxVal : 690, currVal : 0, units : "L"},
        {label : "Ink tank C", maxVal : 222, currVal : 0, units : "L"}
    ]


    ColumnLayout {
        id: col
        anchors.fill: parent

        // First row
//        RowLayout {
//            Layout.fillWidth: true
//            spacing: 50
//            Item {
//                //Layout.preferredWidth: col.width / 4
//            }
//            Label {
//                text: "Max value"
//                //Layout.preferredWidth: col.width / 4
//            }
//            Label {
//                text: "Current value"
//                //Layout.preferredWidth: col.width / 4
//            }
//            Label {
//                text: "Reset"
//                //Layout.preferredWidth: col.width / 4
//            }
//        }

        Repeater {

            model: repeaterModel
            delegate: RowLayout {
                Layout.fillWidth: true

                spacing: 50
                Label {
                    text: modelData.label
                    Layout.preferredWidth: col.width / 4
                }
                TextField {
                    text: modelData.maxVal + " " + modelData.units
                    Layout.preferredWidth: col.width / 4

                }
                TextField {
                    text: modelData.currVal + " " + modelData.units
                    Layout.preferredWidth: col.width / 4

                }
                Button {
                    Layout.preferredWidth: col.width / 4
                }
            }
        }
    }
}
