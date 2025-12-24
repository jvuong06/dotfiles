// Volume Service 
pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import "../include/Colors.mjs" as Colors

Singleton {
    id: root
    
    property PwNode sink: Pipewire.defaultAudioSink
    property int volume: Math.round(sink?.audio.volume * 100)
    property bool muted: sink?.audio.muted
    property string icon: muted ? "" : volume < 34 ? "" : volume < 67 ? "" : ""
    property string color: muted ? Colors.color_warn : Colors.color_fg

    PwObjectTracker {
        objects: [ root.sink ]
    }
}
