import QtQuick
import qs.modules
import qs.services

SystemItem {
    textIcon: WifiService.icon
    textColor: WifiService.color

    MouseArea {
        anchors.fill: parent
        onClicked: WifiLauncher.launch()
    }
}
