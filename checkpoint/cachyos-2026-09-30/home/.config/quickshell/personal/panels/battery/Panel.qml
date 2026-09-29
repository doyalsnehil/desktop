import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower
import qs.Ui
import qs.Commons

Panel {
  id: root
  property bool hideBarButton: false
  moduleName: "personal.battery"
  ipcTarget: "personal.battery"

  property string currentProfile: "balanced"
  readonly property var batteryDevice: UPower.displayDevice
  readonly property bool batteryReady: batteryDevice && batteryDevice.ready
  readonly property bool batteryPresent: batteryReady && batteryDevice.type === UPowerDeviceType.Battery && batteryDevice.isPresent
  readonly property var batteryFraction: {
    if (!batteryPresent) return null
    const value = batteryDevice.percentage
    return typeof value === "number" && isFinite(value) && value >= 0 && value <= 1 ? value : null
  }
  readonly property var displayPercentage: batteryFraction === null ? null : Math.round(batteryFraction * 100)
  readonly property string batteryStatus: {
    if (!batteryReady) return "UNKNOWN"
    if (!batteryPresent) return "UNAVAILABLE"

    switch (batteryDevice.state) {
      case UPowerDeviceState.Charging: return "CHARGING"
      case UPowerDeviceState.Discharging: return "DISCHARGING"
      case UPowerDeviceState.Empty: return "EMPTY"
      case UPowerDeviceState.FullyCharged: return "FULL"
      case UPowerDeviceState.PendingCharge: return "PENDING CHARGE"
      case UPowerDeviceState.PendingDischarge: return "PENDING DISCHARGE"
      case UPowerDeviceState.Unknown:
      default: return "UNKNOWN"
    }
  }
  readonly property bool activelyCharging: batteryPresent && batteryDevice.state === UPowerDeviceState.Charging

  Process {
    command: ["powerprofilesctl", "get"]
    running: true
    stdout: StdioCollector {
      waitForEnd: true
      onStreamFinished: root.currentProfile = String(text || "").trim()
    }
  }

  function setProfile(profile) {
    Quickshell.execDetached(["powerprofilesctl", "set", profile])
    root.currentProfile = profile
  }

  function batteryIcon() {
    if (batteryFraction === null) return "?"
    if (activelyCharging) return "󰂄"
    if (batteryFraction > 0.9) return "󰁹"
    if (batteryFraction > 0.8) return "󰂂"
    if (batteryFraction > 0.6) return "󰂀"
    if (batteryFraction > 0.4) return "󰁾"
    if (batteryFraction > 0.2) return "󰁼"
    return "󰁺"
  }

  function profileIcon(name) {
    if (name === "power-saver") return "󰌪"
    if (name === "balanced") return "󰊚"
    if (name === "performance") return "󰓅"
    return "󰂄"
  }

  KeyboardPanel {
    id: popup
    bar: root.bar
    owner: root
    open: root.opened
    anchorItem: root
    useThemeSurface: true

    width: 320
    implicitHeight: column.implicitHeight + Style.space(32)

    Item {
      anchors.fill: parent
      anchors.margins: Style.space(16)

      Column {
        id: column
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        spacing: Style.space(14)

        // ---------- Hero ----------
        Item {
          width: parent.width
          implicitHeight: Math.max(heroIcon.implicitHeight, heroLabels.implicitHeight, heroPercent.implicitHeight)

          Text {
            id: heroIcon
            textFormat: Text.PlainText
            text: root.batteryIcon()
            color: Theme.textPrimary
            font.family: "MesloLGS Nerd Font"
            font.pixelSize: Style.font.displayLarge || 28
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
          }

          Column {
            id: heroLabels
            anchors.left: heroIcon.right
            anchors.leftMargin: Style.space(14)
            anchors.right: heroPercent.left
            anchors.rightMargin: Style.space(10)
            anchors.verticalCenter: parent.verticalCenter
            spacing: Style.space(2)

            Text {
              text: "Battery"
              color: Theme.textPrimary
              font.family: root.bar.fontFamily
              font.pixelSize: Style.font.title || 16
              font.bold: true
              elide: Text.ElideRight
              width: parent.width
            }

            Text {
              id: heroStatus
              textFormat: Text.PlainText
              text: root.batteryStatus
              color: Theme.textSecondary
              font.family: root.bar.fontFamily
              font.pixelSize: Style.font.caption || 12
              font.bold: true
              font.letterSpacing: 1.2
              elide: Text.ElideRight
              width: parent.width
            }
          }

          Text {
            id: heroPercent
            textFormat: Text.PlainText
            text: root.displayPercentage === null ? "--" : String(root.displayPercentage)
            color: Theme.textPrimary
            font.family: root.bar.fontFamily
            font.pixelSize: Style.font.displayLarge || 28
            font.bold: true
            anchors.right: percentSymbol.left
            anchors.verticalCenter: parent.verticalCenter
          }
          
          Text {
            id: percentSymbol
            textFormat: Text.PlainText
            text: "%"
            visible: root.displayPercentage !== null
            color: Theme.textPrimary
            font.family: root.bar.fontFamily
            font.pixelSize: Style.font.title || 16
            font.bold: true
            anchors.right: parent.right
            anchors.baseline: heroPercent.baseline
          }
        }

        // ---------- Battery progress bar ----------
        Item {
          width: parent.width
          implicitHeight: Style.space(8)

          Rectangle {
            id: barTrack
            anchors.fill: parent
            radius: height / 2
            color: Theme.elevatedSurface
          }

          Rectangle {
            id: barFill
            anchors.left: barTrack.left
            anchors.verticalCenter: barTrack.verticalCenter
            height: barTrack.height
            radius: barTrack.radius
            visible: root.batteryFraction !== null && root.batteryFraction > 0
            color: root.activelyCharging ? "#ffb59f" : (root.batteryFraction !== null && root.batteryFraction <= 0.2 ? Theme.error : Theme.accent)
            width: root.batteryFraction !== null && root.batteryFraction > 0 ? Math.max(barTrack.height, barTrack.width * root.batteryFraction) : 0

            SequentialAnimation on opacity {
              running: root.activelyCharging && root.batteryFraction !== null && root.opened
              loops: Animation.Infinite
              alwaysRunToEnd: true
              NumberAnimation { from: 1.0; to: 0.55; duration: 950; easing.type: Easing.InOutSine }
              NumberAnimation { from: 0.55; to: 1.0; duration: 950; easing.type: Easing.InOutSine }
            }
          }
        }

        // ---------- Power profile picker ----------
        PanelSeparator {
          foreground: Theme.textPrimary
        }

        Column {
          width: parent.width
          spacing: Style.space(10)

          PanelSectionHeader {
            text: "POWER PROFILE"
            foreground: Theme.textPrimary
            fontFamily: root.bar.fontFamily
          }

          Row {
            id: profileRow
            width: parent.width
            spacing: Style.space(6)

            readonly property real cellWidth: (width - spacing * 2) / 3

            Repeater {
              model: ["power-saver", "balanced", "performance"]
              Button {
                required property var modelData
                required property int index
                width: profileRow.cellWidth
                iconText: root.profileIcon(modelData)
                iconSize: Style.font.title || 16
                text: modelData === "power-saver" ? "Saver" : (modelData === "balanced" ? "Balanced" : "Perf")
                fontSize: Style.font.bodySmall || 11
                useThemeColors: true
                fontFamily: root.bar.fontFamily
                bordered: true
                active: root.currentProfile === modelData
                onClicked: root.setProfile(modelData)
              }
            }
          }
        }
      }
    }
  }
}
