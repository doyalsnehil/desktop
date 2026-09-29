import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.Ui
import qs.Commons

Panel {
    id: root
    property bool hideBarButton: false
    moduleName: "personal.calendar"
    ipcTarget: "personal.calendar"

    KeyboardPanel {
        id: popup
        bar: root.bar
        owner: root
        open: root.opened
        anchorItem: root
        useThemeSurface: true

        width: 320
        height: 340

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 16
            spacing: 12

            Text {
                id: monthYearText
                color: Theme.textPrimary
                font.family: "MesloLGS Nerd Font"
                font.pixelSize: 18
                font.bold: true
                Layout.alignment: Qt.AlignHCenter
                text: Qt.formatDateTime(new Date(), "MMMM yyyy")
            }

            GridLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                columns: 7
                columnSpacing: 8
                rowSpacing: 8

                Repeater {
                    model: ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]
                    Text {
                        text: modelData
                        color: Theme.textSecondary
                        font.family: "MesloLGS Nerd Font"
                        font.pixelSize: 14
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        Layout.fillWidth: true
                    }
                }

                Repeater {
                    model: {
                        let date = new Date();
                        let firstDay = new Date(date.getFullYear(), date.getMonth(), 1).getDay();
                        let daysInMonth = new Date(date.getFullYear(), date.getMonth() + 1, 0).getDate();
                        let totalSlots = 42;
                        let days = [];
                        for (let i = 0; i < firstDay; i++) days.push("");
                        for (let i = 1; i <= daysInMonth; i++) days.push(i);
                        while (days.length < totalSlots) days.push("");
                        return days;
                    }
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.preferredHeight: 30
                        color: modelData === new Date().getDate() ? Theme.selected : "transparent"
                        radius: 8

                        Text {
                            anchors.centerIn: parent
                            text: modelData
                            color: modelData === new Date().getDate() ? Theme.onAccentSoft : Theme.textPrimary
                            font.family: "MesloLGS Nerd Font"
                            font.pixelSize: 14
                        }
                    }
                }
            }
        }
    }
}
