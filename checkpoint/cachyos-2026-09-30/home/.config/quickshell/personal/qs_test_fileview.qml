import QtQuick
import Quickshell
import Quickshell.Io

ShellRoot {
  FileView {
    path: "/sys/class/power_supply/BAT0/capacity"
    onLoaded: {
      console.log("Capacity (data):", data)
      console.log("Capacity (content):", content)
      console.log("Capacity (text):", typeof text)
      Quickshell.exit(0)
    }
  }
}
