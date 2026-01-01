import QtQuick
import qs.modules
import qs.services
import "../include/Colors.mjs" as Colors

Rectangle {
    implicitHeight: child.implicitHeight
    implicitWidth: child.implicitWidth 
    color: Colors.color_itembg
    radius: implicitHeight / 2
    
    Row {
        id: child
        anchors.centerIn: parent

        SystemItem {
            textIcon: BrightnessService.icon
            textColor: BrightnessService.color
            color: "transparent"
        }

        SystemItem {
            textIcon: BrightnessService.brightness + "%"
            textColor: BrightnessService.color
            fontSize: 10
            color: "transparent"
        }
    }
}
