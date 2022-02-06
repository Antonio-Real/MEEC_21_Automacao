import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Translation 1.0

Page {
    id: root

    GridLayout {
        anchors.fill: parent
        columns: 2
        anchors.margins: 50

        Image {
            Layout.fillWidth: true
            Layout.fillHeight: true
            fillMode: Image.PreserveAspectFit
            source: "qrc:/qml/assets/pt_flag.png"
            opacity: TranslationManager.language === TranslationManager.PT ? 1.0 : 0.2
            MouseArea {
                anchors.fill: parent
                onClicked: TranslationManager.language = TranslationManager.PT
            }
        }
        Image {
            Layout.fillWidth: true
            Layout.fillHeight: true
            fillMode: Image.PreserveAspectFit
            source: "qrc:/qml/assets/uk_flag.png"
            opacity: TranslationManager.language === TranslationManager.EN ? 1.0 : 0.2
            MouseArea {
                anchors.fill: parent
                onClicked: TranslationManager.language = TranslationManager.EN
            }
        }

        Label {
            Layout.fillWidth: true
            text: qsTr("Portuguese")
            font.pointSize: 20
            horizontalAlignment: Text.AlignHCenter
        }
        Label {
            Layout.fillWidth: true
            text: qsTr("English")
            font.pointSize: 20
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
