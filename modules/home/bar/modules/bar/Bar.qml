pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "../../common/"
import "../../services/"
import "./"

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: barWindow
            required property var modelData
            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: Appearance.bar.height + (Appearance.bar.marginV * 2)
            color: "transparent"
            
            // Configurações explícitas de Layer Shell para habilitar cliques de mouse
            WlrLayershell.layer: WlrLayer.Top
            WlrLayershell.exclusiveZone: implicitHeight
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.None

            Rectangle {
                id: barBg
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    left: parent.left
                    right: parent.right
                    topMargin: Appearance.bar.marginV
                    bottomMargin: Appearance.bar.marginV
                    leftMargin: Appearance.bar.marginH
                    rightMargin: Appearance.bar.marginH
                }
                
                height: Appearance.bar.height
                radius: Appearance.bar.radius
                color: Appearance.colors.backgroundAlpha

                // Garante que o container de fundo receba e processe cliques de mouse
                MouseArea {
                    anchors.fill: parent
                    propagateComposedEvents: true
                    onClicked: (mouse) => mouse.accepted = false
                    onPressed: (mouse) => mouse.accepted = false
                }

                Rectangle {
                    anchors.fill: parent
                    radius: parent.radius
                    color: "transparent"
                    border.color: Qt.rgba(
                        Appearance.colors.border.r,
                        Appearance.colors.border.g,
                        Appearance.colors.border.b,
                        0.4
                    )
                    border.width: 1
                }

                // ── BLOCO DA ESQUERDA ─────────────────────────
                RowLayout {
                    id: leftContent
                    anchors {
                        left: parent.left
                        top: parent.top
                        bottom: parent.bottom
                        leftMargin: Appearance.bar.padding
                    }
                    spacing: Appearance.bar.spacing

                    Launcher {}
                    SystemMonitor {}
                    ActiveWindow {}
                }

                // ── BLOCO DO CENTRO (WORKSPACES) ──────────────
                RowLayout {
                    id: centerContent
                    anchors.centerIn: parent

                    Workspaces { screen: barWindow.screen }
                }

                // ── BLOCO DA DIREITA ──────────────────────────
                RowLayout {
                    id: rightContent
                    anchors {
                        right: parent.right
                        top: parent.top
                        bottom: parent.bottom
                        rightMargin: Appearance.bar.padding
                    }
                    spacing: Appearance.bar.spacing

                    Clock {}
                    Volume {}
                    SystemTray {}
                }
            }
        }
    }
}
