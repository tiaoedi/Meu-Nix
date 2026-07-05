pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import "../../common/"

Item {
    implicitWidth: trayRow.implicitWidth + 8
    implicitHeight: parent.height

    Row {
        id: trayRow
        anchors.centerIn: parent
        spacing: 4

        Repeater {
            model: SystemTray.items

            delegate: Item {
                required property SystemTrayItem modelData
                implicitWidth: 24
                implicitHeight: 24

                anchors.verticalCenter: parent?.verticalCenter

                Image {
                    anchors.centerIn: parent
                    width: 16
                    height: 16
                    source: modelData.icon
                    smooth: true

                    HoverHandler { id: itemHover }

                    TapHandler {
                        acceptedButtons: Qt.LeftButton
                        onTapped: modelData.activate()
                    }

                    TapHandler {
                        acceptedButtons: Qt.RightButton
                        onTapped: point => modelData.menu?.open(parent, point.position)
                    }
                }

                Rectangle {
                    anchors.fill: parent
                    radius: 4
                    color: itemHover.hovered ? Qt.rgba(1, 1, 1, 0.1) : "transparent"
                    Behavior on color { ColorAnimation { duration: 100 } }
                }
            }
        }
    }
}
