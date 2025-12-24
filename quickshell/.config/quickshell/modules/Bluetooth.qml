import QtQuick
import qs.modules
import qs.services

SystemItem {
    textIcon: BluetoothService.icon
    textColor: BluetoothService.color
 
    MouseArea {
        anchors.fill: parent
        onClicked: BluetoothLauncher.launch()
    }
}
