import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Extras 1.4
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import PlcTags 1.0
import "../fontAwesome"

Page {
    id: root

    property bool isCurrentPage: SwipeView.isCurrentItem

    function imageSelection(data) {
        if(data === 1)
            return "qrc:/qml/assets/shoe.png"
        else if(data === 2)
            return "qrc:/qml/assets/boot.png"
        else if(data === 3)
            return "qrc:/qml/assets/high_boot.png"
        else
            return "qrc:/qml/assets/shoe.png"
    }


    // INDICATOR TAGS
    Tag {
        id: tagFill
        tagName: "GL_fill_led"
        tagType: Tag.BOOL
        periodicReads: isCurrentPage
        readInterval: 500
        Component.onCompleted: initializeTag()
    }
    Tag {
        id: tagPolish
        tagName: "GL_polish_led"
        tagType: Tag.BOOL
        periodicReads: isCurrentPage
        readInterval: 500
        Component.onCompleted: initializeTag()
    }
    Tag {
        id: tagClean
        tagName: "GL_clean_led"
        tagType: Tag.BOOL
        periodicReads: isCurrentPage
        readInterval: 500
        Component.onCompleted: initializeTag()
    }
    Tag {
        id: tagPaint
        tagName: "GL_paint_led"
        tagType: Tag.BOOL
        periodicReads: isCurrentPage
        readInterval: 500
        Component.onCompleted: initializeTag()
    }
    Tag {
        id: tagDry
        tagName: "GL_drying_led"
        tagType: Tag.BOOL
        periodicReads: isCurrentPage
        readInterval: 500
        Component.onCompleted: initializeTag()
    }

    // SHOE VISIBILITY
    Tag {
        id: shoe1
        tagType: Tag.INT
        tagName: "GL_shoes_filling"
        periodicReads: isCurrentPage
        Component.onCompleted: initializeTag()
    }
    Tag {
        id: shoe2
        tagType: Tag.INT
        tagName: "GL_shoes_polishing"
        periodicReads: isCurrentPage
        Component.onCompleted: initializeTag()
    }
    Tag {
        id: shoe3
        tagType: Tag.INT
        tagName: "GL_shoes_cleaning"
        periodicReads: isCurrentPage
        Component.onCompleted: initializeTag()
    }
    Tag {
        id: shoe4
        tagType: Tag.INT
        tagName: "GL_shoes_painting"
        periodicReads: isCurrentPage
        Component.onCompleted: initializeTag()
    }
    Tag {
        id: shoe5
        tagType: Tag.INT
        tagName: "GL_shoes_drying"
        periodicReads: isCurrentPage
        Component.onCompleted: initializeTag()
    }

    // BELT
    Tag {
        id: moveBelt
        tagType: Tag.BOOL
        tagName: "GL_move_conveyor"
        periodicReads: isCurrentPage
        Component.onCompleted: initializeTag()
    }

    // ROW TAGS
    Tag {
        id: tagQuantity
        tagType: Tag.INT
        tagName: "GL_current_shoes_produced"
        periodicReads: isCurrentPage
        Component.onCompleted: initializeTag()
    }
    Tag {
        id: tagPause
        tagType: Tag.BOOL
        tagName: "GL_Pause_auto"
        data: btnPause.pressed
        onDataChanged: writeTag()
        periodicReads: isCurrentPage
        Component.onCompleted: initializeTag()
    }
    Tag {
        id: tagResume
        tagType: Tag.BOOL
        tagName: "GL_Resume_auto"
        data: btnResume.pressed
        onDataChanged: writeTag()
        periodicReads: isCurrentPage
        Component.onCompleted: initializeTag()
    }
    Tag {
        id: tagEmergency
        tagType: Tag.BOOL
        tagName: "GL_Stop_auto"
        data: btnEmergency.checked
        onDataChanged: writeTag()
        periodicReads: isCurrentPage
        Component.onCompleted: initializeTag()
    }


    footer: RowLayout {
        spacing: 20
        width: 80

        Label {
            text: qsTr("Quantity:")
            font.pointSize: 15
            Layout.leftMargin: 50
        }
        TextField {
            readOnly: true
            text: tagQuantity.data
            font.pointSize: 15
        }

        Button {
            id: btnPause
            text: qsTr("Pause")
            font.pointSize: 15
        }
        Button {
            id: btnResume
            text: qsTr("Resume")
            font.pointSize: 15
        }
        Button {
            id: btnEmergency
            text: qsTr("Emergency")
            font.pointSize: 15
            highlighted: true
            checkable: true

            Material.accent: checked ? Material.Orange : Material.Red

            Material.elevation: checked ? 10 : 1
        }
        Item {Layout.fillWidth: true}
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 50


        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: 50
            Layout.rightMargin: 100
            Layout.leftMargin: 100
            spacing: 100
            StatusIndicator {
                active: tagFill.data
                color: "lightgreen"
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredWidth: 20
            }
            StatusIndicator {
                active: tagPolish.data
                color: "lightgreen"
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredWidth: 20
            }
            StatusIndicator {
                active: tagClean.data
                color: "lightgreen"
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredWidth: 20
            }
            StatusIndicator {
                active: tagPaint.data
                color: "lightgreen"
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredWidth: 20
            }
            StatusIndicator {
                active: tagDry.data
                color: "lightgreen"
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredWidth: 20
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: 100
            Layout.rightMargin: 100
            Layout.leftMargin: 100
            spacing: 100
            Label {
                text: qsTr("Filling")
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 15
                Layout.fillWidth: true
                Layout.preferredWidth: 20
            }
            Label {
                text: qsTr("Polishing")
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 15
                Layout.fillWidth: true
                Layout.preferredWidth: 20
            }
            Label {
                text: qsTr("Cleaning")
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 15
                Layout.fillWidth: true
                Layout.preferredWidth: 20
            }
            Label {
                text: qsTr("Painting")
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 15
                Layout.fillWidth: true
                Layout.preferredWidth: 20
            }
            Label {
                text: qsTr("Drying")
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 15
                Layout.fillWidth: true
                Layout.preferredWidth: 20
            }
        }

        GridLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: 150
            columnSpacing: 0
            rowSpacing: 0
            columns: 3
            Item { Layout.fillHeight: true; Layout.fillWidth: true; Layout.columnSpan: 3 }

            RowLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.rightMargin: 100
                Layout.leftMargin: 100
                Layout.preferredHeight: 50
                Layout.columnSpan: 3

                Image {
                    opacity: shoe1.data === 0 ? 0 : 1
                    source: imageSelection(shoe1.data)
                    fillMode: Image.PreserveAspectFit
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.preferredWidth: 10
                    verticalAlignment: Image.AlignBottom
                }
                Item { Layout.fillWidth: true; Layout.preferredWidth: 10 }
                Image {
                    opacity: shoe2.data === 0 ? 0 : 1
                    source: imageSelection(shoe2.data)
                    fillMode: Image.PreserveAspectFit
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.preferredWidth: 10
                    verticalAlignment: Image.AlignBottom
                }
                Item { Layout.fillWidth: true; Layout.preferredWidth: 10 }
                Image {
                    opacity: shoe3.data === 0 ? 0 : 1
                    source: imageSelection(shoe3.data)
                    fillMode: Image.PreserveAspectFit
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.preferredWidth: 10
                    verticalAlignment: Image.AlignBottom
                }
                Item { Layout.fillWidth: true; Layout.preferredWidth: 10 }
                Image {
                    opacity: shoe4.data === 0 ? 0 : 1
                    source: imageSelection(shoe4.data)
                    fillMode: Image.PreserveAspectFit
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.preferredWidth: 10
                    verticalAlignment: Image.AlignBottom
                }
                Item { Layout.fillWidth: true; Layout.preferredWidth: 10 }
                Image {
                    opacity: shoe5.data === 0 ? 0 : 1
                    source: imageSelection(shoe5.data)
                    fillMode: Image.PreserveAspectFit
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.preferredWidth: 10
                    verticalAlignment: Image.AlignBottom
                }
            }

            Rectangle {
                Layout.columnSpan: 3
                Layout.fillWidth: true
                Layout.leftMargin: gear1.width/2
                Layout.rightMargin: gear1.width/2
                Layout.preferredHeight: 10
                radius: 10
                color: "lightgrey"
            }
            Text {
                id: gear1
                font.family: FontAwesome.fontFamily
                text: FontAwesome.timesCircle
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 100
                fontSizeMode: Text.Fit
                Layout.preferredHeight: 80

                RotationAnimation on rotation {
                    from: 0
                    to: 360
                    duration: 500
                    loops: Animation.Infinite
                    running: moveBelt.data
                }
            }
            Item { Layout.fillWidth: true }
            Text {
                id: gear2
                font.family: FontAwesome.fontFamily
                text: FontAwesome.timesCircle
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 100
                fontSizeMode: Text.Fit
                Layout.preferredHeight: 80

                RotationAnimation on rotation {
                    from: 0
                    to: 360
                    duration: 500
                    loops: Animation.Infinite
                    running: moveBelt.data
                }
            }
            Rectangle {
                Layout.columnSpan: 3
                Layout.fillWidth: true
                Layout.leftMargin: gear2.width/2
                Layout.rightMargin: gear2.width/2
                Layout.preferredHeight: 10
                radius: 10
                color: "lightgrey"
            }
        }
    }
}
