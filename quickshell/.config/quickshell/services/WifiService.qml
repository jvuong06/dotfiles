pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import "../include/Colors.mjs" as Colors

Singleton {
    id: root

    property var connections: [] 
    property bool connected: false
    property string connectedSSID: "No Internet"
    property int signalStrength: 0
    property string icon: 
        connected ?
            (signalStrength < 26 ? "󰤟" : signalStrength < 51 ? "󰤢" : signalStrength < 76 ? "󰤥": "󰤨")
            : "󰤫"
    property string color: connected ? Colors.color_fg: Colors.color_warn
    
    Timer {
        interval: 3000
        running: true
        repeat: true
        onTriggered: networkProc.running = true
    }

    Process {
        id: networkProc
        running: true
        command: [ "sh", "-c", "nmcli -t -f active,ssid,signal dev wifi", "|", "grep", "\'yes\'"]

        property string output: ""

        stdout: StdioCollector {
            onStreamFinished: networkProc.output = this.text
        }

        onOutputChanged: {
            let networkMap = new Map();
            const stdout = output
                .split('\n')
                .map(line => line.split(':'))
                .forEach(arr => {
                    let SSID = arr[1];
                    let connectionStrength = arr[2];
                    networkMap.set(SSID, connectionStrength);
                });

            if (networkMap.size > 0) {
                root.connected = true;
            }

            if (root.connected) {
                let firstConnection = networkMap.entries().next().value;
                root.connectedSSID = firstConnection[0];
                root.signalStrength = firstConnection[1];
            }

            root.connections = networkMap;
        }
    }
}


