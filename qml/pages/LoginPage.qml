import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15
import "../assets"
import "../fontAwesome"

Page {
    id: root

    property StackView stack: StackView.view

    Users { id: users }

    Timer {
        id: loginTimer
        interval: 500
        onTriggered: {
            for(var i=0; i < users.userDatabase.length; i++) {
                var user = users.userDatabase[i]
                var name = user.name
                var pw = user.pw

                if((txtField_email.text === name) && (txtField_password.text === pw)) {
                    // LOGIN SUCCESS
                    currentUser = user
                    stack.replace(null, "qrc:/qml/pages/MainPage.qml")
                    return
                }
            }
            errorOcurred(qsTr("Username or password are incorrect"))
        }
    }

    function login() {
        txt_error.text = ""
        spinner.running = true
        loginTimer.start()
    }

    function errorOcurred(error) {
        spinner.running = false
        txt_error.text = error
        txtField_email.clear()
        txtField_password.clear()
    }

    ColumnLayout {
        anchors.fill: parent

        Item { Layout.fillHeight: true }
        Text {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 150
            Layout.preferredHeight: 150
            horizontalAlignment: Text.AlignHCenter
            font.family: FontAwesome.fontFamily
            minimumPointSize: 20
            font.pointSize: 100
            fontSizeMode: Text.VerticalFit
            text: FontAwesome.userCircle
        }
        BusyIndicator {
            id: spinner
            Layout.alignment: Qt.AlignHCenter
            running: false
            visible: running
        }
        Text {
            id: txt_error
            Layout.alignment: Qt.AlignHCenter
            color: "#ff0000"
            font.pointSize: 12

            function errorMessage(error) {
                spinner.running = false
                txt_error.text = error
            }
        }

        TextField {
            id: txtField_email
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 200
            placeholderText: "Username"
        }
        TextField {
            id: txtField_password
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 200
            placeholderText: "Password"
            echoMode: TextInput.Password
            onAccepted: login()
        }
        Button {
            Layout.alignment: Qt.AlignHCenter
            text: "Login"
            onClicked: login()
        }
        Item { Layout.fillHeight: true }
    }
}
