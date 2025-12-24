import qs.modules
import qs.services
import QtQuick

Row {
    spacing: 5

    SystemItem {
        textIcon: VolumeService.icon
        textColor: VolumeService.color
    }

    SystemItem {
        textIcon: VolumeService.volume + "%"
        textColor: VolumeService.color
        fontSize: 10
    }
}
