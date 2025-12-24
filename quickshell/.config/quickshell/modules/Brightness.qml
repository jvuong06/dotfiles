import QtQuick
import qs.modules
import qs.services

Row {
    spacing: 5

    SystemItem {
        textIcon: BrightnessService.icon
        textColor: BrightnessService.color
    }

    SystemItem {
        textIcon: BrightnessService.brightness + "%"
        textColor: BrightnessService.color
        fontSize: 10
    }
}
