import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import PlcTags 1.0

Page {
    id: root
    title: "Program configuration"

    PlcProgram {
        id: plcProgramConfig

        name: cboxBootType.currentText
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
        sdry_UV_timer: spinBoxUVTimer.value
        sdry_Heat_timer: spinBoxHeatTimer.value
        sdry_Fan_timer: spinBoxFanTimer.value

        Component.onCompleted: readData()

        onNewTagData: {
            cboxBootType.currentIndex = cboxBootType.model.indexOf(name)
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
            spinBoxUVTimer.value = sdry_UV_timer
            spinBoxHeatTimer.value = sdry_Heat_timer
            spinBoxFanTimer.value = sdry_Fan_timer
        }        
    }

    GridLayout {
        id: grid

        anchors.fill: parent
        anchors.margins: 50

        columns: 3
        rowSpacing: 20
        columnSpacing: 20

        RowLayout {
            Layout.columnSpan: 3
            Layout.alignment: Qt.AlignCenter

            Label {
                text: "Boot type:"
                font.pointSize: 20
            }
            ComboBox {
                id: cboxBootType
                model: ["Shoe", "Boot", "High Boot"]
            }
        }

        GroupBox {
            title: "Fill"
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.maximumHeight: 250

            label: Label {
                x: parent.leftPadding
                width: parent.availableWidth
                text: parent.title
                elide: Text.ElideRight
                font.pointSize: 10
            }

            GridLayout {
                columns: 2
                rowSpacing: 10
                columnSpacing: 10

                CheckBox {
                    id: ckBoxEnableFill
                    text: "Enable"
                    Layout.columnSpan: 2
                    Layout.fillWidth: true
                }

                Label { text: "Axis Postion" }
                Slider {
                    id: sliderFillAxisPos
                    from: 0; to: 100
                    enabled: ckBoxEnableFill.checked
                }

                Label { text: "Fill timer" }
                SpinBox {
                    id: spinBoxFillTimer
                    enabled: ckBoxEnableFill.checked
                    editable: true
                }

            }
        }

        GroupBox {
            title: "Polishing"
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.maximumHeight: 250

            label: Label {
                x: parent.leftPadding
                width: parent.availableWidth
                text: parent.title
                elide: Text.ElideRight
                font.pointSize: 10
            }

            GridLayout {
                columns: 2
                rowSpacing: 10
                columnSpacing: 10

                CheckBox {
                    id: ckBoxEnablePolishing
                    text: "Enable"
                    Layout.columnSpan: 2
                    Layout.fillWidth: true
                }

                Label { text: "Brush type" }
                ComboBox {
                    id: cboxBrushType
                    model: ["Brush 1", "Brush 2", "Brush 3"]
                    enabled: ckBoxEnablePolishing.checked
                }

                Label { text: "Polishing timer" }
                SpinBox {
                    id: spinBoxPolishingTimer
                    enabled: ckBoxEnablePolishing.checked
                    editable: true
                }

            }
        }

        GroupBox {
            title: "Clean"
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.maximumHeight: 250

            label: Label {
                x: parent.leftPadding
                width: parent.availableWidth
                text: parent.title
                elide: Text.ElideRight
                font.pointSize: 10
            }

            GridLayout {
                columns: 2
                rowSpacing: 10
                columnSpacing: 10

                CheckBox {
                    id: ckBoxEnableClean
                    text: "Enable"
                    Layout.columnSpan: 2
                    Layout.fillWidth: true
                }

                Label { text: "Air Pressure" }
                Slider {
                    id: sliderAirPressure
                    from: 0; to: 100
                    enabled: ckBoxEnableClean.checked
                }

                Label { text: "Clean timer" }
                SpinBox {
                    id: spinBoxCleanTimer
                    enabled: ckBoxEnableClean.checked
                    editable: true
                }

            }
        }

        GroupBox {
            title: "Paint"
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.maximumHeight: 250


            label: Label {
                x: parent.leftPadding
                width: parent.availableWidth
                text: parent.title
                elide: Text.ElideRight
                font.pointSize: 10
            }

            GridLayout {
                columns: 2
                rowSpacing: 10
                columnSpacing: 10

                CheckBox {
                    id: ckBoxEnablePaint
                    text: "Enable"
                    Layout.columnSpan: 2
                    Layout.fillWidth: true
                }

                Label { text: "Axis Postion" }
                Slider {
                    id: sliderPaintAxisPos
                    from: 0; to: 100
                    enabled: ckBoxEnablePaint.checked
                }

                Label { text: "Paint timer" }
                SpinBox {
                    id: spinBoxPaintTimer
                    enabled: ckBoxEnablePaint.checked
                    editable: true
                }

            }
        }

        GroupBox {
            title: "Drying"
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.maximumHeight: 250

            label: Label {
                x: parent.leftPadding
                width: parent.availableWidth
                text: parent.title
                elide: Text.ElideRight
                font.pointSize: 10
            }

            GridLayout {
                columns: 2
                rowSpacing: 10
                columnSpacing: 10

                CheckBox {
                    id: ckBoxEnableDry
                    text: "Enable"
                    Layout.columnSpan: 2
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }

                Label { text: "UV timer" }
                SpinBox {
                    id: spinBoxUVTimer
                    enabled: ckBoxEnableDry.checked
                    editable: true
                }

                Label { text: "Heat timer" }
                SpinBox {
                    id: spinBoxHeatTimer
                    enabled: ckBoxEnableDry.checked
                    editable: true
                }

                Label { text: "Fan timer" }
                SpinBox {
                    id: spinBoxFanTimer
                    enabled: ckBoxEnableDry.checked
                    editable: true
                }

            }
        }

        Button {
            Layout.alignment: Qt.AlignCenter
            text: "Save config"
            onClicked: plcProgramConfig.writeData()
        }

        Item {
            Layout.columnSpan: 3
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }
}
