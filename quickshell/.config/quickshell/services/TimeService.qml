// Time.qml
pragma Singleton

import Quickshell
import QtQuick

// your singletons should always have Singleton as the type
Singleton {
    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    property string time: Qt.formatDateTime(clock.date, "dddd hh:mm AP")
}
