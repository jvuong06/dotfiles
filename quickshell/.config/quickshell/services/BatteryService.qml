// Battery power service
pragma Singleton

import Quickshell
import Quickshell.Services.UPower
import QtQuick
import "../include/Colors.mjs" as Colors

Singleton {
    property UPowerDevice device: UPower.displayDevice
    property bool ready: device.ready
    property int percentage: ready ? device.percentage * 100 : 0
    property int state: ready ? device.state : UPowerDeviceState.Unknown
    property string icon: get_icon()
    property string color: get_color()

    function get_icon() {
        let res;
        switch(state) {
            case UPowerDeviceState.Unknown:
                res = "󰂑"
                break;
            case UPowerDeviceState.Charging:
                res = percentage < 10  ? "󰢟"
                    : percentage < 20  ? "󰢜" 
                    : percentage < 30  ? "󰂆" 
                    : percentage < 40  ? "󰂇" 
                    : percentage < 50  ? "󰂈"
                    : percentage < 60  ? "󰢝"
                    : percentage < 70  ? "󰂉"
                    : percentage < 80  ? "󰢞"
                    : percentage < 90  ? "󰂊"
                    : "󰂋"
                break;
            case UPowerDeviceState.FullyCharged:
                res = "󰂄"
                break;
            case UPowerDeviceState.Empty:
                res = "󰂃"
                break;
            default: 
                res = percentage < 5   ? "󰂃" 
                    : percentage < 10  ? "󰂎"
                    : percentage < 20  ? "󰁺" 
                    : percentage < 30  ? "󰁻" 
                    : percentage < 40  ? "󰁼" 
                    : percentage < 50  ? "󰁽"
                    : percentage < 60  ? "󰁾"
                    : percentage < 70  ? "󰁿"
                    : percentage < 80  ? "󰂀"
                    : percentage < 90  ? "󰂁"
                    : percentage < 95  ? "󰂂"
                    : "󰁹"
                }
        return res;
    }

    function get_color() {
        return Colors.color_fg
    }

    onPercentageChanged: {
        icon: get_icon(); 
        color: get_color();
    }
}

