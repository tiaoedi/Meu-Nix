pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Hyprland
import "../../common/"
import "../../services/"

Item {
    implicitWidth: Math.min(windowText.implicitWidth + 16, 200)
    implicitHeight: parent.height

    property string title: HyprlandData.focusedClient?.title ?? ""
    property string appClass: HyprlandData.focusedClient?.className ?? ""

    Row {
        anchors.centerIn: parent
        spacing: 6

        Text {
            id: windowText
            text: title.length > 30 ? title.substring(0, 28) + "…" : title
            font.family: Appearance.font.family
            font.pixelSize: Appearance.font.normal
            color: Appearance.colors.textDim
            visible: title.length > 0
            elide: Text.ElideRight
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
