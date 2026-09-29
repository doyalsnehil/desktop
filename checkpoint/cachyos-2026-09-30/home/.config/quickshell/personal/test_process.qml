import QtQuick
import Quickshell
import Quickshell.Io

ShellRoot {
  Process {
    command: ["cat", "/sys/class/power_supply/BAT0/capacity"]
    running: true
    onExited: {
      console.log("Capacity: '" + stdout + "'")
      Quickshell.exit(0)
    }
  }
}
