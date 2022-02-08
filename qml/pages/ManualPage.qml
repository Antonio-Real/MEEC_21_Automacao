import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import PlcTags 1.0

Page {
    id: root

    property bool isCurrentPage: SwipeView.isCurrentItem

    //TODO:
    // 1 - Tags should fetch data periodically
    // 2 - Only fetch data if the current page is being shown in the swipeview

    // FILLING TAGS
    Tag {
        tagName: "man_set_fill_axis_value"
        tagType: Tag.LREAL
        data: fillDist.value
        onDataChanged: writeTag()
        periodicReads: isCurrentPage
        Component.onCompleted: {
            initializeTag()
            fillDist.value = data
        }
    }
    Tag {
        tagName: "man_active_fill_axis"
        tagType: Tag.BOOL
        data: switchFillDist.checked
        onDataChanged: writeTag()
        periodicReads: isCurrentPage
        Component.onCompleted: {
            initializeTag()
            switchFillDist.checked = data
        }
    }
    Tag {
        tagName: "man_fill"
        tagType: Tag.BOOL
        data: switchFill.checked
        onDataChanged: writeTag()
        periodicReads: isCurrentPage
        Component.onCompleted: {
            initializeTag()
            switchFill.checked = data
        }
    }

    // POLISHING TAGS
    Tag {
        tagName: "man_brush_type"
        tagType: Tag.INT
        data: cboxBrushType.currentIndex + 1
        onDataChanged: writeTag()
        periodicReads: isCurrentPage
        Component.onCompleted: {
            initializeTag()
            cboxBrushType.currentIndex = data - 1
        }
    }
    Tag {
        tagName: "man_polish"
        tagType: Tag.BOOL
        data: switchPolish.checked
        onDataChanged: writeTag()
        periodicReads: isCurrentPage
        Component.onCompleted: {
            initializeTag()
            switchPolish.checked = data
        }
    }

    // CLEANING TAGS
    Tag {
        tagName: "man_set_air"
        tagType: Tag.REAL
        data: airPressureSlider.value
        onDataChanged: writeTag()
        periodicReads: isCurrentPage
        Component.onCompleted: {
            initializeTag()
            airPressureSlider.value = data
        }
    }
    Tag {
        tagName: "man_cleaning"
        tagType: Tag.BOOL
        data: switchClean.checked
        onDataChanged: writeTag()
        periodicReads: isCurrentPage
        Component.onCompleted: {
            initializeTag()
            switchClean.checked = data
        }
    }

    // PAINTING TAGS
    Tag {
        tagName: "man_set_paint_axis_value"
        tagType: Tag.LREAL
        data: paintDist.value
        onDataChanged: writeTag()
        periodicReads: isCurrentPage
        Component.onCompleted: {
            initializeTag()
            paintDist.value = data
        }
    }
    Tag {
        tagName: "man_active_paint_axis"
        tagType: Tag.BOOL
        data: switchPaintDist.checked
        onDataChanged: writeTag()
        periodicReads: isCurrentPage
        Component.onCompleted: {
            initializeTag()
            switchPaintDist.checked = data
        }
    }
    Tag {
        tagName: "man_ink_type"
        tagType: Tag.INT
        data: cboxPaintType.currentIndex + 1
        onDataChanged: writeTag()
        periodicReads: isCurrentPage
        Component.onCompleted: {
            initializeTag()
            cboxPaintType.currentIndex = data - 1
        }
    }
    Tag {
        tagName: "man_active_ink"
        tagType: Tag.BOOL
        data: switchPaint.checked
        onDataChanged: writeTag()
        periodicReads: isCurrentPage
        Component.onCompleted: {
            initializeTag()
            switchPaint.checked = data
        }
    }

    // DRYING TAGS
    Tag {
        tagName: "man_active_uv"
        tagType: Tag.BOOL
        data: switchUV.checked
        onDataChanged: writeTag()
        periodicReads: isCurrentPage
        Component.onCompleted: {
            initializeTag()
            switchUV.checked = data
        }
    }
    Tag {
        tagName: "man_active_heat"
        tagType: Tag.BOOL
        data: switchHeat.checked
        onDataChanged: writeTag()
        periodicReads: isCurrentPage
        Component.onCompleted: {
            initializeTag()
            switchHeat.checked = data
        }
    }
    Tag {
        tagName: "man_active_fan"
        tagType: Tag.BOOL
        data: switchFan.checked
        onDataChanged: writeTag()
        periodicReads: isCurrentPage
        Component.onCompleted: {
            initializeTag()
            switchFan.checked = data
        }
    }


    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 50
        spacing: 20

        Frame {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.preferredHeight: 30

            RowLayout {
                anchors.fill: parent

                Label {
                    text: qsTr("Filling")
                    font.pointSize: 20
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }

                Label {
                    text: qsTr("Distance: %1").arg(fillDist.value.toFixed(2))
                    font.pointSize: 15
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }
                Slider {
                    id: fillDist
                    from: 0
                    to: 100
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }

                Switch {
                    id: switchFillDist
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }
                Switch {
                    id: switchFill
                    text: qsTr("Filling")
                    font.pointSize: 15
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }
            }
        }

        Frame {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.preferredHeight: 30

            RowLayout {
                anchors.fill: parent

                Label {
                    text: qsTr("Polishing")
                    font.pointSize: 20
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
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }

                Switch {
                    id: switchPolish
                    text: qsTr("Polishing")
                    font.pointSize: 15
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }
                Item {
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }

            }
        }

        Frame {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.preferredHeight: 30

            RowLayout {
                anchors.fill: parent

                Label {
                    text: qsTr("Clean")
                    font.pointSize: 20
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }

                Label {
                    text: qsTr("Air pressure: %1").arg(airPressureSlider.value.toFixed(2))
                    font.pointSize: 15
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }
                Slider {
                    id: airPressureSlider
                    from: 0
                    to: 10
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }
                Switch {
                    id: switchClean
                    text: qsTr("Cleaning")
                    font.pointSize: 15
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }
                Item {
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }
            }
        }

        Frame {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.preferredHeight: 30

            RowLayout {
                anchors.fill: parent

                Label {
                    text: qsTr("Painting")
                    font.pointSize: 20
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }

                Label {
                    text: qsTr("Distance: %1").arg(paintDist.value.toFixed(2))
                    font.pointSize: 15
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }
                Slider {
                    id: paintDist
                    from: 0
                    to: 100
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }

                Switch {
                    id: switchPaintDist
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }
                Label {
                    text: qsTr("Ink type"); font.pointSize: 15
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }
                ComboBox {
                    id: cboxPaintType
                    model: [qsTr("Ink 1"), qsTr("Ink 2"), qsTr("Ink 3")]
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }
                Switch {
                    id: switchPaint
                    text: qsTr("Painting")
                    font.pointSize: 15
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }
            }
        }

        Frame {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.preferredHeight: 30

            RowLayout {
                anchors.fill: parent

                Label {
                    text: qsTr("Drying")
                    font.pointSize: 20
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }

                Switch {
                    id: switchUV
                    text: qsTr("UV")
                    font.pointSize: 15
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }
                Switch {
                    id: switchHeat
                    text: qsTr("Heat")
                    font.pointSize: 15
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }
                Switch {
                    id: switchFan
                    text: qsTr("Fan")
                    font.pointSize: 15
                    Layout.fillWidth: true
                    Layout.preferredWidth: 20
                }
            }
        }
    }
}
