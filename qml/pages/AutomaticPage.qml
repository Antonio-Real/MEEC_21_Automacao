import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import PlcTags 1.0

Page {
    id: root
    title: "Program configuration"

    property bool isCurrentPage: SwipeView.isCurrentItem

    Tag {
        id: shoeSelect
        tagType: Tag.BOOL
        tagName: "GL_Prog1_shoes"
        periodicReads: isCurrentPage
        readInterval: 500
        onDataChanged: plcProgramConfig.readData()
        Component.onCompleted: initializeTag()
    }
    Tag {
        id: bootSelect
        tagType: Tag.BOOL
        tagName: "GL_Prog2_boot"
        periodicReads: isCurrentPage
        readInterval: 500
        onDataChanged: plcProgramConfig.readData()
        Component.onCompleted: initializeTag()
    }
    Tag {
        id: highBootSelect
        tagType: Tag.BOOL
        tagName: "GL_Prog3_highboot"
        periodicReads: isCurrentPage
        readInterval: 500
        onDataChanged: plcProgramConfig.readData()
        Component.onCompleted: initializeTag()
    }

    Tag {
        id: tagStartButton
        tagType: Tag.INT
        tagName: "GL_START_AUTO"
        data: startButton.pressed
        onDataChanged: plcProgramConfig.writeData()
        Component.onCompleted: initializeTag()
    }

    PlcProgram {
        id: plcProgramConfig

        function refreshData() {
            txtFieldQuantity.text = quantity
            ckBoxEnableFill.checked = sfill_exec === 1
            sliderFillAxisPos.value = sfill_axisPosition
            spinBoxFillTimer.value = sfill_timer
            ckBoxEnablePolishing.checked = spol_exec === 1
            cboxBrushType.currentIndex = spol_brushType - 1
            spinBoxPolishingTimer.value = spol_timer
            ckBoxEnableClean.checked = sclean_exec === 1
            sliderAirPressure.value = sclean_air_pressure
            spinBoxCleanTimer.value = sclean_timer
            ckBoxEnablePaint.checked = spaint_exec === 1
            sliderPaintAxisPos.value = spaint_axisPosition
            spinBoxPaintTimer.value = spaint_timer
            ckBoxEnableDry.checked = sdry_exec === 1
            ckUv.checked = sdry_UV_exec === 1
            ckHeat.checked = sdry_Heat_exec === 1
            ckFan.checked = sdry_Fan_exec === 1
            spinBoxUVTimer.value = sdry_UV_timer
            spinBoxHeatTimer.value = sdry_Heat_timer
            spinBoxFanTimer.value = sdry_Fan_timer
        }

        sfill_exec: ckBoxEnableFill.checked ? 1 : 0
        sfill_axisPosition: sliderFillAxisPos.value
        sfill_timer: spinBoxFillTimer.value
        spol_exec: ckBoxEnablePolishing.checked ? 1 : 0
        spol_brushType: cboxBrushType.currentIndex + 1
        spol_timer: spinBoxPolishingTimer.value
        sclean_exec: ckBoxEnableClean.checked ? 1 : 0
        sclean_air_pressure: sliderAirPressure.value
        sclean_timer: spinBoxCleanTimer.value
        spaint_exec: ckBoxEnablePaint.checked ? 1 : 0
        spaint_axisPosition: sliderPaintAxisPos.value
        spaint_timer: spinBoxPaintTimer.value
        sdry_exec: ckBoxEnableDry.checked ? 1 : 0
        sdry_UV_exec: ckUv.checked ? 1 : 0
        sdry_Heat_exec: ckHeat.checked ? 1 : 0
        sdry_Fan_exec: ckFan.checked ? 1 : 0
        sdry_UV_timer: spinBoxUVTimer.value
        sdry_Heat_timer: spinBoxHeatTimer.value
        sdry_Fan_timer: spinBoxFanTimer.value

        onNewTagData: refreshData()
    }

    GridLayout {
        id: grid

        anchors {
            fill: parent
            leftMargin: 50
            rightMargin: 50
            topMargin: 20
            bottomMargin: 20
        }

        columns: 2
        rows: 6
        columnSpacing: 20
        rowSpacing: 15

        ColumnLayout {
            Layout.rowSpan: 6
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 20

            Label {
                text: qsTr("Boot type:")
                font.pointSize: 25
                Layout.bottomMargin: 50
            }

            Image {
                horizontalAlignment: Image.AlignLeft | Image.AlignVCenter
                Layout.fillHeight: true
                Layout.preferredHeight: 25
                fillMode: Image.PreserveAspectFit
                source: "qrc:/qml/assets/shoe.png"

                Rectangle {
                    anchors {
                        left: parent.left
                        top: parent.top
                        bottom: parent.bottom
                        margins: -10
                    }
                    width: parent.paintedWidth + 20
                    border.width: 2
                    radius: 10
                    border.color: shoeSelect.data === true ? "grey" : "transparent"
                    color: "transparent"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            shoeSelect.data = true
                            shoeSelect.writeTag()
                        }
                    }
                }
            }
            Label { text: qsTr("Shoe"); font.pointSize: 20; Layout.bottomMargin: 20; horizontalAlignment: Text.AlignHCenter }

            Image {
                horizontalAlignment: Image.AlignLeft | Image.AlignVCenter
                Layout.fillHeight: true
                Layout.preferredHeight: 25
                fillMode: Image.PreserveAspectFit
                source: "qrc:/qml/assets/boot.png"

                Rectangle {
                    anchors {
                        left: parent.left
                        top: parent.top
                        bottom: parent.bottom
                        margins: -10
                    }
                    width: parent.paintedWidth + 20
                    border.width: 2
                    radius: 10
                    border.color: bootSelect.data === true ? "grey" : "transparent"
                    color: "transparent"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            bootSelect.data = true
                            bootSelect.writeTag()
                        }
                    }
                }
            }
            Label { text: qsTr("Boot"); font.pointSize: 20; Layout.bottomMargin: 20; horizontalAlignment: Text.AlignHCenter }

            Image {
                horizontalAlignment: Image.AlignLeft | Image.AlignVCenter
                Layout.fillHeight: true
                Layout.preferredHeight: 25
                fillMode: Image.PreserveAspectFit
                source: "qrc:/qml/assets/high_boot.png"

                Rectangle {
                    anchors {
                        left: parent.left
                        top: parent.top
                        bottom: parent.bottom
                        margins: -10
                    }
                    width: parent.paintedWidth + 20
                    border.width: 2
                    radius: 10
                    border.color: highBootSelect.data === true ? "grey" : "transparent"
                    color: "transparent"
                    MouseArea {
                        anchors.fill: parent
                        z: 5
                        onClicked: {
                            highBootSelect.data = true
                            highBootSelect.writeTag()
                        }
                    }
                }
            }
            Label { text: qsTr("High Boot"); font.pointSize: 20; Layout.bottomMargin: 20; horizontalAlignment: Text.AlignHCenter }

            TextField {
                id: txtFieldQuantity
                validator: IntValidator {
                    bottom: 0
                    top: 9999
                }
                onEditingFinished: plcProgramConfig.quantity = parseInt(text)
                font.pointSize: 15
                Layout.preferredWidth: 100
            }
            Label { text: qsTr("Quantity"); font.pointSize: 20}
        }

        Frame {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 30



            RowLayout {
                anchors.fill: parent
                spacing: 10
                Label {
                    text: qsTr("Fill")
                    font.pointSize: 20
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }
                CheckBox {
                    id: ckBoxEnableFill
                    text: qsTr("Enable")
                    font.pointSize: 15
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }

                Label {
                    text: qsTr("Distance"); font.pointSize: 15
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }
                Slider {
                    id: sliderFillAxisPos
                    from: 0; to: 100
                    enabled: ckBoxEnableFill.checked
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }

                Label {
                    text: qsTr("Fill timer"); font.pointSize: 15
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }
                SpinBox {
                    id: spinBoxFillTimer
                    enabled: ckBoxEnableFill.checked
                    editable: true
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }

            }
        }

        Frame {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 30

            RowLayout {
                anchors.fill: parent
                spacing: 10
                Label {
                    text: qsTr("Polishing")
                    font.pointSize: 20
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }

                CheckBox {
                    id: ckBoxEnablePolishing
                    text: qsTr("Enable")
                    font.pointSize: 15
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20

                }

                Label {
                    text: qsTr("Brush type"); font.pointSize: 15
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }
                ComboBox {
                    id: cboxBrushType
                    model: [qsTr("Brush 1"), qsTr("Brush 2"), qsTr("Brush 3")]
                    enabled: ckBoxEnablePolishing.checked
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }

                Label {
                    text: qsTr("Polishing timer"); font.pointSize: 15
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }
                SpinBox {
                    id: spinBoxPolishingTimer
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                    enabled: ckBoxEnablePolishing.checked
                    editable: true
                }

            }
        }

        Frame {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 30

            RowLayout {
                anchors.fill: parent
                spacing: 10
                Label {
                    text: qsTr("Clean")
                    font.pointSize: 20
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }

                CheckBox {
                    id: ckBoxEnableClean
                    text: qsTr("Enable")
                    font.pointSize: 15
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }

                Label {
                    text: qsTr("Air pressure"); font.pointSize: 15
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }
                Slider {
                    id: sliderAirPressure
                    from: 0; to: 10
                    enabled: ckBoxEnableClean.checked
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }

                Label {
                    text: qsTr("Clean timer"); font.pointSize: 15
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }
                SpinBox {
                    id: spinBoxCleanTimer
                    enabled: ckBoxEnableClean.checked
                    editable: true
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }

            }
        }

        Frame {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 30

            RowLayout {
                anchors.fill: parent
                spacing: 10
                Label {
                    text: qsTr("Paint")
                    font.pointSize: 20
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }

                CheckBox {
                    id: ckBoxEnablePaint
                    text: qsTr("Enable")
                    font.pointSize: 15
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }

                Label {
                    text: qsTr("Distance"); font.pointSize: 15
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }
                Slider {
                    id: sliderPaintAxisPos
                    from: 0; to: 100
                    enabled: ckBoxEnablePaint.checked
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }

                Label {
                    text: qsTr("Paint timer"); font.pointSize: 15
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }
                SpinBox {
                    id: spinBoxPaintTimer
                    enabled: ckBoxEnablePaint.checked
                    editable: true
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }
            }
        }

        Frame {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 30

            GridLayout {
                anchors.fill: parent
                flow: GridLayout.TopToBottom
                rows: 3
                columns: 5
                rowSpacing: 0
                columnSpacing: 0

                Label {
                    text: qsTr("Paint")
                    font.pointSize: 20
                    Layout.rowSpan: 3
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }

                CheckBox {
                    id: ckBoxEnableDry
                    text: qsTr("Enable")
                    font.pointSize: 15
                    Layout.rowSpan: 3
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }

                CheckBox {
                    id: ckUv
                    enabled: ckBoxEnableDry.checked
                    text: "UV"
                    font.pointSize: 15
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20

                }
                CheckBox {
                    id: ckHeat
                    enabled: ckBoxEnableDry.checked
                    text: "Heat"
                    font.pointSize: 15
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }
                CheckBox {
                    id: ckFan
                    enabled: ckBoxEnableDry.checked
                    text: "Fan"
                    font.pointSize: 15
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }

                Label { text: qsTr("UV timer"); font.pointSize: 15; Layout.fillWidth: true; Layout.preferredWidth: 20 }
                Label { text: qsTr("Heat timer"); font.pointSize: 15; Layout.fillWidth: true; Layout.preferredWidth: 20 }
                Label { text: qsTr("Fan timer"); font.pointSize: 15; Layout.fillWidth: true; Layout.preferredWidth: 20 }
                SpinBox {
                    id: spinBoxUVTimer
                    enabled: ckUv.checked && ckBoxEnableDry.checked
                    editable: true
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }
                SpinBox {
                    id: spinBoxHeatTimer
                    enabled: ckHeat.checked && ckBoxEnableDry.checked
                    editable: true
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }
                SpinBox {
                    id: spinBoxFanTimer
                    enabled: ckFan.checked && ckBoxEnableDry.checked
                    editable: true
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }
            }
        }

        Button {
            id: startButton
            Layout.alignment: Qt.AlignCenter
            text: qsTr("Start program")
            onPressed: {
                plcProgramConfig.writeData()
            }
        }
    }
}
