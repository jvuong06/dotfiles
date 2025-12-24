import Quickshell
import Quickshell.Io

Process {
    required property string scriptName
    running: false
    environment: ({
        SCRIPT_DIR: `${Quickshell.shellDir}/include/bin`
    })
    command: [ `${Quickshell.shellDir}/include/bin/${scriptName}` ]

    function launch() {
        this.startDetached();
    }
}

