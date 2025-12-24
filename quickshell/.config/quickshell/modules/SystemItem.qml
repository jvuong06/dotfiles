import QtQuick
import "../include/Colors.mjs" as Colors
import "../include/Fonts.mjs" as Fonts

Rectangle {
    id: root

    required property string textIcon
    required property color textColor
    property real fontSize: 12
    
    anchors.verticalCenter: parent.verticalCenter
    implicitHeight: 25 
    implicitWidth: implicitHeight

    color: Colors.color_bg

    Text {
        anchors.centerIn: parent
        text: root.textIcon
        color: root.textColor
        font.pointSize: root.fontSize
        font.weight: Fonts.weight 
        font.family: "Adwaita Sans"
    }
}
