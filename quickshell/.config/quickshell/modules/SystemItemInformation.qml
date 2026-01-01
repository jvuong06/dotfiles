import QtQuick
import qs.modules
import "../include/Colors.mjs" as Colors

Rectangle {
    implicitHeight: child.implicitHeight 
    implicitWidth: child.implicitWidth
    color: Colors.color_itembg

    Row {
        id: child

    }
}
