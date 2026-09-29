import QtQuick
import Quickshell
import Quickshell.Services.Notifications
import Quickshell.Wayland
import qs.Commons

Item {
  id: root

  // Timeout policy is local to the host. Quickshell reports seconds.
  readonly property int defaultTimeoutMs: 5000
  readonly property int minimumTimeoutMs: 1000
  readonly property int maxVisible: 3
  readonly property int toastMargin: Math.max(12, Style.gapsOut)

  function timeoutMs(notification) {
    if (!notification || notification.urgency === NotificationUrgency.Critical) return 0
    var seconds = Number(notification.expireTimeout)
    if (seconds === 0) return 0
    if (seconds > 0 && isFinite(seconds)) return Math.max(minimumTimeoutMs, Math.round(seconds * 1000))
    return defaultTimeoutMs
  }

  NotificationServer {
    id: server
    keepOnReload: true
    bodySupported: true
    actionsSupported: true
    imageSupported: false
    bodyImagesSupported: false
    bodyMarkupSupported: false
    bodyHyperlinksSupported: false
    actionIconsSupported: false
    inlineReplySupported: false
    persistenceSupported: false

    onNotification: notification => {
      // Carried notifications may be emitted again after a QML reload. The
      // tracked model, rather than this signal, creates cards exactly once.
      if (!notification.tracked) notification.tracked = true
    }
  }

  // A view of the server's own model. Pending notifications remain tracked
  // and become visible as earlier cards close; there is no separate history.
  ScriptModel {
    id: visibleNotifications
    values: server.trackedNotifications.values.slice(0, root.maxVisible)
    comparisonMode: ObjectComparison.Identity
  }

  PanelWindow {
    id: toastWindow
    screen: Quickshell.screens.length > 0 ? Quickshell.screens[0] : null
    visible: Quickshell.screens.length > 0 && visibleNotifications.values.length > 0
    implicitWidth: Math.max(1, Math.min(360, screen ? screen.width - root.toastMargin * 2 : 360))
    // Keep the layer surface's geometry stable as cards move. A changing
    // transparent layer height leaves compositor artifacts during relayout.
    implicitHeight: Math.max(1, (screen ? screen.height : 1080) - 48 - root.toastMargin)
    anchors { top: true; right: true }
    margins { top: 48; right: root.toastMargin }
    color: "transparent"
    exclusionMode: ExclusionMode.Ignore
    mask: Region {
      width: toastWindow.width
      height: toastColumn.implicitHeight
    }
    WlrLayershell.namespace: "personal-notification-toasts"
    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.None

    Column {
      id: toastColumn
      width: parent.width
      spacing: Style.spacing.sm

      move: Transition {
        NumberAnimation { properties: "y"; duration: 140; easing.type: Easing.OutCubic }
      }

      Repeater {
        model: visibleNotifications

        delegate: Rectangle {
          id: card
          required property var modelData
          readonly property var notification: modelData
          readonly property int inset: Style.spacing.popupPadding

          width: toastColumn.width
          height: content.implicitHeight + inset * 2
          radius: Math.max(6, Style.cornerRadius)
          color: Color.notifications.background
          border.color: notification.urgency === NotificationUrgency.Critical ? Color.urgent : Color.notifications.border
          border.width: 1

          Timer {
            id: expiryTimer
            interval: root.timeoutMs(card.notification)
            running: card.notification && card.notification.tracked && interval > 0
            repeat: false
            onTriggered: {
              if (card.notification && card.notification.tracked) card.notification.expire()
            }
          }

          Connections {
            target: card.notification
            function onSummaryChanged() { if (expiryTimer.interval > 0) expiryTimer.restart() }
            function onBodyChanged() { if (expiryTimer.interval > 0) expiryTimer.restart() }
            function onExpireTimeoutChanged() { if (expiryTimer.interval > 0) expiryTimer.restart() }
          }

          Column {
            id: content
            anchors { left: parent.left; right: parent.right; top: parent.top; margins: card.inset }
            spacing: Style.spacing.xs

            Row {
              width: parent.width
              spacing: Style.spacing.sm

              Text {
                width: parent.width - closeButton.width - parent.spacing
                text: card.notification.appName || "Notification"
                color: Color.notifications.text
                opacity: 0.75
                font.family: Style.font.family
                font.pixelSize: Style.font.bodySmall
                textFormat: Text.PlainText
                elide: Text.ElideRight
                maximumLineCount: 1
              }

              Rectangle {
                id: closeButton
                width: 24
                height: 24
                radius: 4
                color: closeArea.containsMouse ? Color.popups.background : "transparent"

                Text {
                  anchors.centerIn: parent
                  text: "×"
                  color: Color.notifications.text
                  font.pixelSize: Style.font.title
                  textFormat: Text.PlainText
                }

                MouseArea {
                  id: closeArea
                  anchors.fill: parent
                  hoverEnabled: true
                  cursorShape: Qt.PointingHandCursor
                  onClicked: card.notification.dismiss()
                }
              }
            }

            Text {
              width: parent.width
              visible: text.length > 0
              text: card.notification.summary || ""
              color: Color.notifications.text
              font.family: Style.font.family
              font.pixelSize: Style.font.title
              font.bold: true
              textFormat: Text.PlainText
              wrapMode: Text.Wrap
              maximumLineCount: 2
              elide: Text.ElideRight
            }

            Text {
              width: parent.width
              visible: text.length > 0
              text: card.notification.body || ""
              color: Color.notifications.text
              font.family: Style.font.family
              font.pixelSize: Style.font.body
              textFormat: Text.PlainText
              wrapMode: Text.Wrap
              maximumLineCount: 3
              elide: Text.ElideRight
            }

            Flickable {
              id: actionsViewport
              width: parent.width
              height: Math.min(96, actionList.implicitHeight)
              visible: card.notification.actions.length > 0
              contentHeight: actionList.implicitHeight
              clip: true
              interactive: contentHeight > height

              Column {
                id: actionList
                width: actionsViewport.width
                spacing: Style.spacing.xs

                Repeater {
                  model: card.notification.actions

                  delegate: Rectangle {
                    required property var modelData
                    readonly property var action: modelData
                    width: actionList.width
                    height: 28
                    radius: 4
                    color: actionArea.containsMouse
                      ? Style.hoverFillFor(Color.notifications.text, Color.notifications.border)
                      : Color.popups.background

                    Text {
                      anchors { fill: parent; leftMargin: 8; rightMargin: 8 }
                      verticalAlignment: Text.AlignVCenter
                      text: action.text || "Action"
                      color: Color.notifications.text
                      font.family: Style.font.family
                      font.pixelSize: Style.font.bodySmall
                      textFormat: Text.PlainText
                      elide: Text.ElideRight
                    }

                    MouseArea {
                      id: actionArea
                      anchors.fill: parent
                      hoverEnabled: true
                      cursorShape: Qt.PointingHandCursor
                      onClicked: action.invoke()
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
