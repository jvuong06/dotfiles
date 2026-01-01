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
            textIcon: BatteryService.icon
            textColor: BatteryService.color
            color: "transparent"
        }

        SystemItem {
            textIcon: BatteryService.percentage + "%"
            textColor: Colors.color_fg
            fontSize: 10
            color: "transparent"
        }
    }
}
