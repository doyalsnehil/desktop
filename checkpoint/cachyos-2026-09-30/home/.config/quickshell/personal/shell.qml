import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.Commons
import "panels/network" as Network
import "panels/bluetooth" as Bluetooth
import "panels/audio" as Audio
import "panels/battery" as Battery
import "panels/calendar" as Calendar
import "panels/wifiqr" as WifiQr
import "panels/speedtest" as Speedtest
import "panels/polkit" as Polkit
import "panels/notifications" as Notifications

ShellRoot {
    QtObject {
        id: bar
        property QtObject shell: bar
        property color foreground: "#ffffff"
        property color barForeground: "#ffffff"
        property string fontFamily: "JetBrains Mono"
        property string position: "top"
        property bool vertical: false
        property int barSize: 35
        property int barH: 35
        property int barW: 1920
        property var activePopout: null
        property var clickTargets: []
        function requestPopout(owner) {
            if (activePopout && activePopout !== owner && activePopout.close) activePopout.close()
            activePopout = owner
        }
        function releasePopout(owner) {
            if (activePopout === owner) activePopout = null
        }
        function switchPanelFrom(owner, direction) { return false }
        function targetBelongsToWindow(target, window) { return true }
        function showTooltip(target, text) {}
        function hideTooltip(target) {}
        function registerClickTarget(target) {}
        function unregisterClickTarget(target) {}
        function run(command) { Quickshell.execDetached(["bash", "-lc", command]) }
        function summon(name, payload) {
            networkPanel.close()
            bluetoothPanel.close()
            audioPanel.close()
            if (typeof batteryPanel !== "undefined") batteryPanel.close()
            if (typeof calendarPanel !== "undefined") calendarPanel.close()
            if (name === "omarchy.wifiqr") wifiQr.open(payload || "{}")
            else if (name === "omarchy.speedtest") speedTest.open(payload || "{}")
        }
        function hide(name) {
            if (name === "omarchy.wifiqr") wifiQr.close()
            else if (name === "omarchy.speedtest") speedTest.close()
        }
    }

    PanelWindow {
        id: hostBar
        anchors { top: true; left: true; right: true }
        implicitHeight: 40
        color: "transparent"
        exclusionMode: ExclusionMode.Ignore
        WlrLayershell.layer: WlrLayer.Bottom

        Item {
            id: calendarAnchor
            anchors.horizontalCenter: parent.horizontalCenter
            width: 80; height: 40
            Calendar.Panel { id: calendarPanel; anchors.fill: parent; bar: bar; hideBarButton: true }
        }
        Item {
            id: networkAnchor
            anchors.right: parent.right; anchors.rightMargin: 190
            width: 40; height: 40
            Network.Panel { id: networkPanel; anchors.fill: parent; bar: bar; hideBarButton: true }
        }
        Item {
            id: bluetoothAnchor
            anchors.right: parent.right; anchors.rightMargin: 150
            width: 40; height: 40
            Bluetooth.Panel { id: bluetoothPanel; anchors.fill: parent; bar: bar; hideBarButton: true }
        }
        Item {
            id: audioAnchor
            anchors.right: parent.right; anchors.rightMargin: 110
            width: 40; height: 40
            Audio.Panel { id: audioPanel; anchors.fill: parent; bar: bar; hideBarButton: true }
        }
        Item {
            id: batteryAnchor
            anchors.right: parent.right; anchors.rightMargin: 40
            width: 70; height: 40
            Battery.Panel { id: batteryPanel; anchors.fill: parent; bar: bar; hideBarButton: true }
        }
    }

    WifiQr.Panel { id: wifiQr; shell: bar }
    Speedtest.Panel { id: speedTest; shell: bar }
    Polkit.PolkitAgent { id: polkitAgent }
    Notifications.ToastHost { id: notificationToasts }
}
