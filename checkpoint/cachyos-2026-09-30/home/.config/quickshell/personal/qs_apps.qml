import QtQuick
import Quickshell
import Quickshell.Services.Applications

ShellRoot {
  Component.onCompleted: {
    console.log("Apps:", Applications.applications.length)
    Quickshell.exit(0)
  }
}
