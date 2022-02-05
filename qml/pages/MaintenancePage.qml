import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import PlcTags 1.0

Page {
    id: root
    title: "Maintenance"
    padding: 50

    property var repeaterModel: [
        {label : qsTr("Carpet Motor"), maxValTag : "GL_Max_Motor_Time", currValTag : "GL_Current_Motor_Time", resetToZero: true, units : "H",},
        {label : qsTr("Brush 1"), maxValTag : "GL_NumberMaxBrush1", currValTag : "s2_brushType_1_value", resetToZero: true, units : "u"},
        {label : qsTr("Brush 2"), maxValTag : "GL_NumberMaxBrush2", currValTag : "s2_brushType_2_value", resetToZero: true, units : "u"},
        {label : qsTr("Brush 3"), maxValTag : "GL_NumberMaxBrush3", currValTag : "s2_brushType_3_value", resetToZero: true, units : "u"},
        {label : qsTr("Ink tank A"), maxValTag : "GL_Max_Ink_tank1", currValTag : "GL_Liters_in_tank_1", resetToZero: false, units : "L"},
        {label : qsTr("Ink tank B"), maxValTag : "GL_Max_Ink_tank2", currValTag : "GL_Liters_in_tank_2", resetToZero: false, units : "L"},
        {label : qsTr("Ink tank C"), maxValTag : "GL_Max_Ink_tank3", currValTag : "GL_Liters_in_tank_3", resetToZero: false, units : "L"}
    ]

    property int labelSize: 20

    ColumnLayout {
        id: col
        anchors.fill: parent

        // First row
        RowLayout {
            Item {
                Layout.preferredWidth: 25
                Layout.fillWidth: true
            }
            Label {
                text: qsTr("Max value")
                Layout.preferredWidth: 20
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: labelSize
            }
            Item {
                Layout.preferredWidth: 5
                Layout.fillWidth: true
            }
            Label {
                text: qsTr("Current value")
                Layout.preferredWidth: 20
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: labelSize
            }
            Item {
                Layout.preferredWidth: 5
                Layout.fillWidth: true
            }
            Label {
                text: qsTr("Reset")
                Layout.preferredWidth: 25
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: labelSize
            }
        }

        Repeater {

            model: repeaterModel
            delegate: RowLayout {
                Layout.fillHeight: true

                spacing: 50
                Label {
                    text: modelData.label
                    Layout.preferredWidth: 25
                    Layout.fillWidth: true
                    font.pointSize: labelSize
                }
                TextField {
                    text: maxValTag.data
                    Layout.preferredWidth: 20
                    Layout.fillWidth: true
                    font.pointSize: labelSize
                    validator: IntValidator {
                        bottom: 0
                        top: 9999
                    }
                    onEditingFinished: {
                        maxValTag.data = parseInt(text)
                        maxValTag.writeTag()
                    }
                }
                Label {
                    text: modelData.units
                    Layout.preferredWidth: 5
                    Layout.fillWidth: true
                    font.pointSize: labelSize
                }
                TextField {
                    text: currValTag.data
                    Layout.preferredWidth: 20
                    Layout.fillWidth: true
                    font.pointSize: labelSize
                    readOnly: true
                }
                Label {
                    text: modelData.units
                    Layout.preferredWidth: 5
                    Layout.fillWidth: true
                    font.pointSize: labelSize
                }

                Button {
                    Layout.preferredWidth: 25
                    Layout.fillWidth: true
                    font.pointSize: labelSize
                    onClicked: {
                        currValTag.data = modelData.resetToZero ? 0 : maxValTag.data
                        currValTag.writeTag()
                    }
                }

                Tag {
                    id: maxValTag
                    tagName: modelData.maxValTag
                    tagType: Tag.INT
                    Component.onCompleted: initializeTag()
                }
                Tag {
                    id: currValTag
                    tagName: modelData.currValTag
                    tagType: Tag.INT
                    Component.onCompleted: initializeTag()
                }
            }
        }
    }
}
