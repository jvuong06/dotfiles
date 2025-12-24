import Quickshell
import QtQuick
import qs.bar

ShellRoot {
    Loader  {
        active: true
        sourceComponent: Bar {}
    }
}
