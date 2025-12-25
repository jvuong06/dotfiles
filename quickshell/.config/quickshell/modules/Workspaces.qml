pragma ComponentBehavior: Bound

import Quickshell.Hyprland
import QtQuick
import "../include/Colors.mjs" as Colors

Rectangle {
    color: Colors.color_bg2
    height: root.implicitHeight + root.spacing * 2
    width: root.implicitWidth + root.spacing * 2
    radius: height / 2

    Row {
        id: root

        property var wsList: Hyprland.workspaces.values

        anchors.centerIn: parent
        spacing: 5

        Timer {
            interval: 100
            running: true
            repeat: true
            onTriggered: {
                root.ws_list = Hyprland.workspaces.values
            }
        }

        Repeater { 
            model: root.wsList

            Rectangle {
                id: workspace

                required property HyprlandWorkspace modelData 
                property int workspaceId: modelData.id
                property bool special: modelData.id < 0
                property bool focused: modelData.focused

                visible: !special

                anchors.verticalCenter: parent.verticalCenter
                height: mouse.hovered || focused ? 10   : 6
                width:  focused       ? height * 2.5    : height
                radius: mouse.hovered ? height / 4      : height / 2
                color:  focused       ? Colors.color_fg : mouse.hovered ? Colors.color_hv : Colors.color_uf

                Behavior on color  { ColorAnimation  { duration: 200 } }
                Behavior on radius { NumberAnimation { duration: 200 } }
                Behavior on width  { NumberAnimation { duration: 150 } }


                Text {
                    anchors.centerIn: parent
                    color: workspace.focused ? Colors.color_bg : Colors.color_fg
                    font.family: "Adwaita Sans"
                    font.pointSize: 6
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: Hyprland.dispatch("workspace " + (workspace.workspaceId))
                }

                HoverHandler {
                    id: mouse
                }
            }
        }
    }
}
