import QtQuick
import Quickshell
import Quickshell.Io

ShellRoot {
  Process {
    command: ["cat", "/sys/class/power_supply/BAT0/capacity"]
    running: true
    stdout: StdioCollector {
      waitForEnd: true
      onStreamFinished: {
        console.log("Capacity:", text)
        Quickshell.exit(0)
      }
    }
  }
}
