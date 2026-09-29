import QtQuick
import Quickshell.Io
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland

PanelWindow {
    id: root

    anchors {
        top: true
        left: true
    }

    margins {
        top: 5
        left: 12
    }

    implicitWidth: 250
    implicitHeight: 34

    color: "transparent"
    exclusionMode: ExclusionMode.Ignore

    /*
     * Waybar already reserves the top 40px.
     * Keep this indicator below application windows so it
     * cannot visually sit on top of a fullscreen/tiled window.
     */
    WlrLayershell.layer: WlrLayer.Bottom

    property int slotWidth: 25
    property int firstSlotX: 12
    property int pillWidth: 44

    property int activeWorkspaceId:
        Hyprland.focusedWorkspace
            ? Hyprland.focusedWorkspace.id
            : 1

    property int activeIndex:
        activeWorkspaceId >= 1 && activeWorkspaceId <= 9
            ? activeWorkspaceId - 1
            : 0

    property int hoveredIndex: -1

    property var palette: ({
        surface: "#1e100c",
        surface_raised: "#372621",
        text: "#f9dcd5",
        muted: "#a78b84",
        accent: "#ffb59f",
        outline_variant: "#5b4139"
    })

    function rgba(hex, alpha) {
        var h = String(hex).replace("#", "")

        if (h.length !== 6)
            return Qt.rgba(1, 1, 1, alpha)

        return Qt.rgba(
            parseInt(h.slice(0, 2), 16) / 255,
            parseInt(h.slice(2, 4), 16) / 255,
            parseInt(h.slice(4, 6), 16) / 255,
            alpha
        )
    }

    FileView {
        id: themeFile

        path: "/home/snehil/.config/matugen/generated/palette.json"
        watchChanges: true
        blockLoading: false

        onLoaded: {
            try {
                root.palette = JSON.parse(text())
            } catch (e) {
                console.log("Workspace theme parse failed:", e)
            }
        }

        onFileChanged: reload()
    }

    Rectangle {
        id: surface

        anchors.fill: parent

        radius: 17
        color: root.rgba(root.palette.surface, 0.76)

        border.width: 1
        border.color:
            root.rgba(root.palette.outline_variant, 0.58)

        antialiasing: true
    }

    /*
     * One moving capsule.
     * We animate only x, so GTK/Waybar layout is never involved.
     */
    Rectangle {
        id: activePill

        width: root.pillWidth
        height: 26
        radius: 13

        y: 4

        x: root.firstSlotX
           + (root.activeIndex * root.slotWidth)
           - ((root.pillWidth - root.slotWidth) / 2)

        color: root.rgba(root.palette.accent, 0.20)

        border.width: 1
        border.color: root.rgba(root.palette.accent, 0.52)

        antialiasing: true

        Behavior on x {
            NumberAnimation {
                duration: 260
                easing.type: Easing.OutCubic
            }
        }

        Behavior on color {
            ColorAnimation {
                duration: 220
            }
        }
    }

    Repeater {
        model: 9

        delegate: Item {
            required property int index

            x: root.firstSlotX
               + (index * root.slotWidth)
               - (root.slotWidth / 2)

            y: 2

            width: root.slotWidth
            height: 30

            Rectangle {
                anchors.centerIn: parent

                width: 23
                height: 23
                radius: 11.5

                color:
                    root.hoveredIndex === index &&
                    root.activeIndex !== index
                        ? root.rgba(root.palette.surface_raised, 0.78)
                        : "transparent"

                visible:
                    root.hoveredIndex === index &&
                    root.activeIndex !== index

                Behavior on color {
                    ColorAnimation {
                        duration: 120
                    }
                }
            }

            Text {
                anchors.fill: parent

                text: String(index + 1)

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                font.family: "JetBrains Mono Nerd Font"

                font.pixelSize:
                    root.activeIndex === index
                        ? 14
                        : 11

                font.weight:
                    root.activeIndex === index
                        ? Font.DemiBold
                        : Font.Normal

                color:
                    root.activeIndex === index
                        ? root.palette.accent
                        : root.hoveredIndex === index
                            ? root.palette.text
                            : root.palette.muted

                renderType: Text.NativeRendering

                Behavior on color {
                    ColorAnimation {
                        duration: 140
                    }
                }

                Behavior on font.pixelSize {
                    NumberAnimation {
                        duration: 160
                        easing.type: Easing.OutCubic
                    }
                }
            }

            MouseArea {
                anchors.fill: parent

                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor

                onEntered:
                    root.hoveredIndex = index

                onExited:
                    if (root.hoveredIndex === index)
                        root.hoveredIndex = -1

                onClicked:
                    Hyprland.dispatch("workspace " + (index + 1))
            }
        }
    }
}
