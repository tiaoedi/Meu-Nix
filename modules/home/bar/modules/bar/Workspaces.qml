pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import "../../common/"
import "../../services/"

Item {
    id: wsRoot
    required property var screen

    implicitWidth: 180
    implicitHeight: Appearance.bar.height

    property int focusedId: HyprlandData.focusedWorkspace?.id ?? 1

    function checkHasWindows(wsId) {
        if (!HyprlandData.workspaces) return false;
        for (let i = 0; i < HyprlandData.workspaces.length; i++) {
            if (HyprlandData.workspaces[i].id === wsId) {
                return HyprlandData.workspaces[i].clientCount > 0;
            }
        }
        return false;
    }

    RowLayout {
        id: wsRow
        anchors.centerIn: parent
        spacing: 6
        height: parent.height

        Repeater {
            model: 5

            delegate: Item {
                property int wsId: parseInt(modelData) + 1
                property bool isFocused: wsId === focusedId
                property bool hasWindows: checkHasWindows(wsId)

                Layout.preferredWidth: 28
                Layout.preferredHeight: parent.height

                // Criando um processo isolado para cada bolinha para garantir execução instantânea
                Process {
                    id: singleProcess
                    command: ["hyprctl", "dispatch", "workspace", String(wsId)]
                }

                Rectangle {
                    id: wsRect
                    anchors.centerIn: parent
                    
                    width: isFocused ? 24 : (hasWindows ? 16 : 10)
                    height: isFocused ? 24 : (hasWindows ? 16 : 10)
                    radius: height / 2

                    color: isFocused
                        ? Appearance.colors.primary
                        : hasWindows
                            ? Qt.rgba(
                                Appearance.colors.primary.r,
                                Appearance.colors.primary.g,
                                Appearance.colors.primary.b,
                                0.4
                            )
                            : Qt.rgba(
                                Appearance.colors.border.r,
                                Appearance.colors.border.g,
                                Appearance.colors.border.b,
                                0.6
                            )

                    Behavior on width { NumberAnimation { duration: 200; easing.type: Easing.OutQuart } }
                    Behavior on height { NumberAnimation { duration: 200; easing.type: Easing.OutQuart } }
                    Behavior on color { ColorAnimation { duration: 150 } }

                    Text {
                        anchors.centerIn: parent
                        text: wsId
                        font.family: Appearance.font.family
                        font.pixelSize: 10
                        font.bold: true
                        color: isFocused ? Appearance.colors.background : "transparent"
                        visible: isFocused

                        Behavior on color { ColorAnimation { duration: 150 } }
                    }

                    HoverHandler { id: wsHover }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            // Executa o hyprctl direto do sistema
                            singleProcess.running = true;
                        }
                    }

                    Rectangle {
                        anchors.fill: parent
                        radius: parent.radius
                        color: wsHover.hovered ? Qt.rgba(1, 1, 1, 0.1) : "transparent"
                        Behavior on color { ColorAnimation { duration: 100 } }
                    }
                }
            }
        }
    }
}
