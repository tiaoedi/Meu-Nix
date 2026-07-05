pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Hyprland

Singleton {
    id: root

    property var workspaces: Hyprland.workspaces
    property var focusedWorkspace: Hyprland.focusedWorkspace
    property var focusedClient: Hyprland.focusedClient

    function focusWorkspace(id: int) {
        Hyprland.dispatch("workspace " + id)
    }
}
