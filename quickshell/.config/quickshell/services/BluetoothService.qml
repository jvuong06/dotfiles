pragma Singleton

import Quickshell
import Quickshell.Bluetooth 
import QtQuick
import "../include/Colors.mjs" as Colors

Singleton {
    id: root
    property BluetoothAdapter adapter: Bluetooth.defaultAdapter
    property int state: adapter ? adapter.state : 0
    property bool connected: {
        adapter
            .devices
            .values
            .forEach(dev => { 
                if (dev.connected) {
                    return true
                }
            });

        return false;
    }
    property string icon: {
        let res;
        switch (state) {
            case BluetoothAdapterState.Enabled:
                res = connected ? "󰂱" : "󰂯"
                break;
            default:
                res = "󰂲";
        }

        return res;
    } 
    property string color: Colors.color_fg
}
