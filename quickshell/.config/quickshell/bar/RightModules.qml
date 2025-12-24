import QtQuick
import qs.modules

Row {
    anchors {
        verticalCenter: parent.verticalCenter
        right: parent.right
        leftMargin: 10
        rightMargin: 10
    }

    spacing: 5

    Bluetooth {}
    Wifi {}
    Brightness {}
    Volume {}
    Battery {}
}
