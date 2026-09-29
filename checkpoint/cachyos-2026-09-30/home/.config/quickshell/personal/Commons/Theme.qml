pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

QtObject {
  id: root

  // These defaults are used only until the first valid generated palette.
  readonly property var defaults: ({
    background: "#101315",
    surface_container: "#1c2023",
    surface_raised: "#252b2e",
    text: "#e6e8e8",
    muted: "#aab0b5",
    accent: "#cacccc",
    on_primary: "#101315",
    accent_soft: "#34383b",
    accent_text: "#e6e8e8",
    outline_variant: "#444b50",
    outline: "#727b80",
    surface_container_highest: "#30383b",
    danger: "#ffb4ab",
    on_error: "#4d0000"
  })
  property var palette: defaults
  property int retriesRemaining: 0

  readonly property color background: palette.background
  readonly property color surface: palette.surface_container
  readonly property color elevatedSurface: palette.surface_raised
  readonly property color textPrimary: palette.text
  readonly property color textSecondary: palette.muted
  readonly property color accent: palette.accent
  readonly property color onAccent: palette.on_primary
  readonly property color accentSoft: palette.accent_soft
  readonly property color onAccentSoft: palette.accent_text
  readonly property color borderSubtle: palette.outline_variant
  readonly property color borderStrong: palette.outline
  readonly property color hover: palette.surface_raised
  readonly property color pressed: palette.surface_container_highest
  readonly property color selected: palette.accent_soft
  readonly property color focus: palette.accent
  readonly property color error: palette.danger
  readonly property color onError: palette.on_error

  function validPalette(candidate) {
    if (!candidate || typeof candidate !== "object") return false
    for (var key in defaults) {
      if (typeof candidate[key] !== "string" || !/^#[0-9a-fA-F]{6}$/.test(candidate[key]))
        return false
    }
    return true
  }

  function accept(raw) {
    try {
      var candidate = JSON.parse(raw)
      if (validPalette(candidate)) {
        palette = candidate
        retriesRemaining = 0
        retryTimer.stop()
        return
      }
    } catch (e) {}
    retryLater()
  }

  function retryLater() {
    if (retriesRemaining > 0) {
      retriesRemaining--
      retryTimer.restart()
    } else {
      console.warn("Theme: palette unavailable or invalid; retaining previous colors")
    }
  }

  property Timer changeTimer: Timer {
    interval: 75
    repeat: false
    onTriggered: paletteFile.reload()
  }

  property Timer retryTimer: Timer {
    interval: 100
    repeat: false
    onTriggered: paletteFile.reload()
  }

  property FileView paletteFile: FileView {
    id: paletteFile
    path: Quickshell.env("HOME") + "/.config/matugen/generated/palette.json"
    watchChanges: true
    printErrors: false
    onFileChanged: {
      root.retriesRemaining = 3
      changeTimer.restart()
    }
    onLoaded: root.accept(text())
    onLoadFailed: root.retryLater()
  }
}
