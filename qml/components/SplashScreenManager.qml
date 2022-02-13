import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

Item {
    property int sv_timer: 60000
    property int sv_fadein_fadeout_time: 3000
    property bool sv_enabled: false
    property bool sv_active: false
    property string sv_pass_code: "1234"

    onSv_enabledChanged: {
        if(sv_enabled == true)
            screenSaverTimer.start()
        else
            screenSaverTimer.stop()
    }

    function oneShotStart()
    {
        screenSaver.sv_active = true
        screenSaver.visible = true
        screenSaverItem.visible = true
        screenUnlockItem.visible = false
        screenSaverTimer.interval = 3000
        passCodeArea.text = ""
        passwordLabel.text = ""
    }

    function startScreenSaverTimer()
    {
        if(sv_enabled)
            screenSaverTimer.start()
    }

    function stopScreenSaverTimer()
    {
        screenSaverTimer.stop()
    }

    Timer {
        id: screenSaverTimer
        interval: sv_timer
        running: false
        onTriggered: {
            screenSaver.sv_active = true
            screenSaver.visible = true
            screenSaverItem.visible = true
            screenUnlockItem.visible = false
            interval = 3000
            passCodeArea.text = ""
            passwordLabel.text = ""
        }
    }

    function resetScreenSaver()
    {
        if(sv_active)
        {
            screenSaverItem.visible = false
            screenUnlockItem.visible = true
        }
        screenSaverTimer.restart()
    }

    Rectangle {
        id: screenSaverItem
        anchors.fill: parent
        visible: false
        color: Material.backgroundColor
        z:4

        Image{
            id: img_circle
            source: "qrc:/qml/assets/logo.png"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            transformOrigin: Item.Center
            enabled: screenSaver.visible ? true : false
            height: parent.height * 2
            width: parent.width * 2

            transform: Scale{
                id: scale_circle
                property real scalevalue: 0.5
                origin.x: img_circle.width/2
                origin.y: img_circle.height/2
                xScale: scalevalue
                yScale: scalevalue
            }

            SequentialAnimation{
                running: true
                loops: Animation.Infinite

                PropertyAnimation{
                    target: scale_circle
                    properties: "scalevalue"
                    from: 0.5
                    to: 0.55
                    duration: sv_fadein_fadeout_time
                    easing.type: Easing.InQuad
                }

                PropertyAnimation{
                    target: scale_circle
                    properties: "scalevalue"
                    from: 0.55
                    to: 0.5
                    duration: sv_fadein_fadeout_time
                    easing.type: Easing.OutQuad
                }
            }
        }

    }

    Rectangle {
        id: screenUnlockItem
        anchors.fill: parent
        visible: false
        color: Material.backgroundColor
        z: 3

        property string sv_pass_code_entered: ""

        ColumnLayout {
            anchors.centerIn: parent
            anchors.fill: parent
            spacing: 20

            Label{
                id: passwordLabel
                text: ""
                font.pointSize: 20
                color: "red"
                Layout.alignment: Qt.AlignHCenter
                Layout.topMargin: 15
            }

            TextField {
                id: passCodeArea
                text: ""
                implicitWidth: 130
                passwordCharacter: "*"
                echoMode: TextInput.Password
                font.pointSize: 50
                Layout.alignment: Qt.AlignHCenter

                onTextChanged: {
                    if(text.length === sv_pass_code.length)
                    {
                        if(text != sv_pass_code)
                        {
                            passwordLabel.text = "Password is Wrong. Please type again"
                        }
                        else {
                            screenUnlockItem.visible = false
                            screenSaver.sv_active = false
                            screenSaverTimer.interval = sv_timer
                            passwordLabel.text = ""
                        }
                        passCodeArea.text = ""
                    }
                }

            }

            GridLayout {
                flow: GridLayout.LeftToRight
                rows: 3
                columns: 3
                columnSpacing: 5
                rowSpacing: 5
                Layout.alignment: Qt.AlignHCenter
                enabled: screenUnlockItem.visible


                Button {
                    id: button1
                    text: "1"
                    implicitWidth: 80
                    implicitHeight: 80
                    font.pointSize: 20

                    onClicked: passCodeArea.text = passCodeArea.text + text
                }

                Button {
                    text: "2"
                    implicitWidth: button1.implicitWidth
                    implicitHeight: button1.implicitHeight
                    font.pointSize: button1.font.pointSize

                    onClicked: passCodeArea.text = passCodeArea.text + text
                }

                Button {
                    text: "3"
                    implicitWidth: button1.implicitWidth
                    implicitHeight: button1.implicitHeight
                    font.pointSize: button1.font.pointSize

                    onClicked: passCodeArea.text = passCodeArea.text + text
                }

                Button {
                    text: "4"
                    implicitWidth: button1.implicitWidth
                    implicitHeight: button1.implicitHeight
                    font.pointSize: button1.font.pointSize

                    onClicked: passCodeArea.text = passCodeArea.text + text
                }

                Button {
                    text: "5"
                    implicitWidth: button1.implicitWidth
                    implicitHeight: button1.implicitHeight
                    font.pointSize: button1.font.pointSize

                    onClicked: passCodeArea.text = passCodeArea.text + text
                }

                Button {
                    text: "6"
                    implicitWidth: button1.implicitWidth
                    implicitHeight: button1.implicitHeight
                    font.pointSize: button1.font.pointSize

                    onClicked: passCodeArea.text = passCodeArea.text + text
                }

                Button {
                    text: "7"
                    implicitWidth: button1.implicitWidth
                    implicitHeight: button1.implicitHeight
                    font.pointSize: button1.font.pointSize

                    onClicked: passCodeArea.text = passCodeArea.text + text
                }

                Button {
                    text: "8"
                    implicitWidth: button1.implicitWidth
                    implicitHeight: button1.implicitHeight
                    font.pointSize: button1.font.pointSize

                    onClicked: passCodeArea.text = passCodeArea.text + text
                }

                Button {
                    text: "9"
                    implicitWidth: button1.implicitWidth
                    implicitHeight: button1.implicitHeight
                    font.pointSize: button1.font.pointSize

                    onClicked: passCodeArea.text = passCodeArea.text + text
                }
            }
        }
    }
}
