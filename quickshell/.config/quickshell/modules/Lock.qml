import QtQuick
import qs.modules
import "../include/Colors.mjs" as Colors

SystemItem {
    textIcon: ""
    textColor: Colors.color_fg 

    MouseArea {
        anchors.fill: parent
        onClicked: lock.launch()
    }

    ScriptLauncher {
        id: lock
        scriptName: "launch-lock.sh"
    }
}
