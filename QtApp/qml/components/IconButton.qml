import QtQuick 2.15
import QtQuick.Controls 2.15
import "../fontAwesome"

Button {
    id: root
    property string btnIcon
    property color color

    text: "<font color='" + color + "'>" + btnIcon + "</font>"
    font.family: FontAwesome.fontFamily
    flat: true
}
