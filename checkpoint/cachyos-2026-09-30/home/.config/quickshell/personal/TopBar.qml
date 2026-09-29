import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import "panels/network" as Network
import "panels/bluetooth" as Bluetooth
import "panels/audio" as Audio
import "panels/battery" as Battery

PanelWindow {
    id: root
    property QtObject shell

    anchors { top: true; left: true; right: true }
    implicitHeight: 40
    color: "transparent"
    exclusionMode: ExclusionMode.Normal
    WlrLayershell.layer: WlrLayer.Top

    property var palette: ({
        surface: "#1e100c", glass: "#1e100c", text: "#f9dcd5",
        muted: "#a78b84", accent: "#ffb59f", outline_variant: "#5b4139"
    })

    FileView {
        path: "/home/snehil/.config/matugen/generated/palette.json"
        watchChanges: true
        onLoaded: { try { root.palette = JSON.parse(text()) } catch (e) {} }
        onFileChanged: reload()
    }

    function rgba(hex, alpha) {
        var h = String(hex).replace("#", "")
        if (h.length !== 6) return Qt.rgba(1, 1, 1, alpha)
        return Qt.rgba(parseInt(h.slice(0, 2), 16)/255, parseInt(h.slice(2, 4), 16)/255, parseInt(h.slice(4, 6), 16)/255, alpha)
    }

    Item {
        anchors.fill: parent

        // LEFT
        RowLayout {
            anchors.left: parent.left; anchors.leftMargin: 12
            anchors.verticalCenter: parent.verticalCenter
            height: 34; spacing: 8

            Rectangle {
                width: 34; height: 34; radius: 17
                color: rgba(palette.surface, 0.76)
                border.width: 1; border.color: rgba(palette.outline_variant, 0.58)

                Text {
                    anchors.centerIn: parent; text: "󰣇"; color: palette.accent
                    font.family: "JetBrains Mono Nerd Font"; font.pixelSize: 18
                }
                MouseArea {
                    anchors.fill: parent; cursorShape: Qt.PointingHandCursor
                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    onClicked: (mouse) => {
                        if (mouse.button === Qt.LeftButton) shell.run("rofi -show drun -theme-str 'window {width: 30%;}' || fuzzel || wofi --show drun")
                        else shell.run("wlogout || rofi -show p -modi p:rofi-power-menu")
                    }
                }
            }
            WorkspaceIndicator { Layout.fillHeight: true }
        }

        // CENTER
        Rectangle {
            anchors.centerIn: parent
            width: clockText.implicitWidth + 26; height: 30
            radius: 15; color: "transparent"
            Text {
                id: clockText
                anchors.centerIn: parent
                color: palette.text
                font.family: "JetBrains Mono Nerd Font"; font.pixelSize: 14; font.weight: Font.DemiBold
                property var currentDate: new Date()
                Timer { interval: 1000; running: true; repeat: true; onTriggered: parent.currentDate = new Date() }
                text: Qt.formatTime(currentDate, "hh:mm")
            }
        }

        // RIGHT
        Rectangle {
            anchors.right: parent.right; anchors.rightMargin: 12
            anchors.verticalCenter: parent.verticalCenter
            height: 34; radius: 17
            color: rgba(palette.glass, 0.76)
            border.width: 1; border.color: rgba(palette.outline_variant, 0.58)

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 12; anchors.rightMargin: 12; spacing: 12

                Item {
                    width: 20; height: 20
                    Network.Panel { id: networkPanel; anchors.fill: parent; bar: shell; hideBarButton: true }
                    Text { anchors.centerIn: parent; text: "󰤨"; color: palette.text; font.family: "JetBrains Mono Nerd Font"; font.pixelSize: 16 }
                    MouseArea { anchors.fill: parent; cursorShape: Qt.PointingHandCursor; onClicked: networkPanel.controller.toggle() }
                }

                Item {
                    width: 20; height: 20
                    Bluetooth.Panel { id: bluetoothPanel; anchors.fill: parent; bar: shell; hideBarButton: true }
                    Text { anchors.centerIn: parent; text: "󰂯"; color: palette.text; font.family: "JetBrains Mono Nerd Font"; font.pixelSize: 16 }
                    MouseArea { anchors.fill: parent; cursorShape: Qt.PointingHandCursor; onClicked: bluetoothPanel.controller.toggle() }
                }

                Item {
                    width: 20; height: 20
                    Audio.Panel { id: audioPanel; anchors.fill: parent; bar: shell; hideBarButton: true }
                    Text { anchors.centerIn: parent; text: "󰕾"; color: palette.text; font.family: "JetBrains Mono Nerd Font"; font.pixelSize: 16 }
                    MouseArea { anchors.fill: parent; cursorShape: Qt.PointingHandCursor; onClicked: audioPanel.controller.toggle() }
                }

                Item {
                    width: 50; height: 20
                    Battery.Panel { id: batteryPanel; anchors.fill: parent; bar: shell; hideBarButton: true }
                    Text { anchors.centerIn: parent; text: "󰁹 100%"; color: palette.text; font.family: "JetBrains Mono Nerd Font"; font.pixelSize: 14 }
                    MouseArea { anchors.fill: parent; cursorShape: Qt.PointingHandCursor; onClicked: batteryPanel.controller.toggle() }
                }
            }
        }
    }
}
