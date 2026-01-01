import QtQuick
import "../include/Colors.mjs" as Colors
import "../include/Fonts.mjs" as Fonts

Rectangle {
    id: root

    required property string textIcon
    required property color textColor
    property real fontSize: 12
    property real padding: 5
    property bool centered: true
    anchors.verticalCenter: parent.verticalCenter
    implicitHeight: Math.max(text.implicitHeight, 25)
    implicitWidth: text.implicitWidth + padding * 2
    radius: implicitHeight / 2

    color: Colors.color_itembg

    Text {
        id: text
        anchors.centerIn: { if (root.centered) return parent }
        anchors.verticalCenter: parent.verticalCenter
        text: root.textIcon
        color: root.textColor
        font.pointSize: root.fontSize
        font.weight: Fonts.weight 
        font.family: "Adwaita Sans"
    }

}
