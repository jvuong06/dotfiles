import Quickshell
import QtQuick
import qs.bar
import qs.modules
import "../include/Colors.mjs" as Colors

Scope { 
    PanelWindow {
        id: bar
        implicitHeight: 30
        color: Colors.color_bg

        anchors {
            top: true; left: true; right: true;
        }

        LeftModules{}
        CenterModules {}
        RightModules {}
    }
}
