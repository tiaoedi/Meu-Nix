pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Hyprland
import "../../common/"

Item {
    implicitWidth: 36
    implicitHeight: parent.height

    Rectangle {
        anchors.centerIn: parent
        width: 28
        height: 28
        radius: 8
        color: hover.hovered ? Qt.rgba(
            Appearance.colors.primary.r,
            Appearance.colors.primary.g,
            Appearance.colors.primary.b,
            0.2
        ) : "transparent"

        Behavior on color { ColorAnimation { duration: 150 } }

        Text {
            anchors.centerIn: parent
            text: ""
            font.family: Appearance.font.iconFamily
            font.pixelSize: Appearance.font.icon
            color: hover.hovered ? Appearance.colors.primary : Appearance.colors.text

            Behavior on color { ColorAnimation { duration: 150 } }
        }

        HoverHandler { id: hover }

        TapHandler {
            onTapped: Hyprland.dispatch("exec noctalia msg panel-toggle launcher")
        }
    }
}
