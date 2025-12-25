import QtQuick
import qs.modules
import qs.services
import "../include/Colors.mjs" as Colors

Row {
    spacing: 5

    SystemItem {
        textIcon: BatteryService.icon
        textColor: BatteryService.color
    }

    SystemItem {
        textIcon: BatteryService.percentage + "%"
        textColor: Colors.color_fg
        fontSize: 10
    }
}
