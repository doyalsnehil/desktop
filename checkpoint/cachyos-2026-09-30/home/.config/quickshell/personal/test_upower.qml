import QtQuick
import Quickshell
import Quickshell.Services.UPower

ShellRoot {
  Component.onCompleted: {
    console.log("UPower present")
    Quickshell.exit(0)
  }
}
