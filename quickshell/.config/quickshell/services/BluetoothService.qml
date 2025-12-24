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
        if (!adapter || !adapter.devices) {
            return false
        }

        let isConnected = false
        adapter.devices.values.forEach(dev => { if (dev.connected) isConnected = true })
        return isConnected
    }
    property string icon: {
        let res;
        switch (state) {
            case BluetoothAdapterState.Enabled:
                if (connected) {
                    res = "󰂱";
                } else {
                    res = "󰂯";
                }
                break;
            default:
                res = "󰂲";
        }

        return res;
    } 
    property string color: {
        let res;
        switch(state) {
            case BluetoothAdapterState.Enabled:
                if (connected) {
                    res = Colors.bt_connected;
                } else {
                    res = Colors.bt_on;
                }
                break;
            default:
                res = Colors.bt_off;
                break;
        }

        return res;
    }
}
