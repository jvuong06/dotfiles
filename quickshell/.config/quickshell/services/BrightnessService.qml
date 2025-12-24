pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import "../include/Colors.mjs" as Colors

Singleton {
    id: root

    property int curr: 0
    property int max: 0
    property int brightness: Math.round(100 * curr / max)
    property string icon: 
          brightness < 15 ? "󰃚"
        : brightness < 29 ? "󰃛"
        : brightness < 43 ? "󰃜"
        : brightness < 57 ? "󰃝"
        : brightness < 71 ? "󰃞"
        : brightness < 85 ? "󰃟"
        : "󰃠"
    property string color: Colors.color_fg

    Timer {
        interval: 100
        running: true
        repeat: true
        onTriggered: {
            brightnessGetProc.running = true
        }
    }

    Process {
        id: brightnessGetProc
        running: true
        command: [ "sh", "-c", "brightnessctl g"]
        
        stdout: StdioCollector {
            onStreamFinished: root.curr = this.text
        }
    }

    Process {
        id: brightnessMaxProc
        running: true
        command: [ "sh", "-c", "brightnessctl m"]

        stdout: StdioCollector {
            onStreamFinished: root.max = this.text
        }
    }
}

