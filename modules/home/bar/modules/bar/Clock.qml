pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import "../../common/"

Item {
    implicitWidth: clockCol.implicitWidth + 16
    implicitHeight: parent.height

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    Rectangle {
        anchors.fill: parent
        radius: 8
        color: "transparent"

        HoverHandler { id: hover }
    }

    ColumnLayout {
        id: clockCol
        anchors.centerIn: parent
        spacing: -2

        Text {
            // Se clock.now ainda não estiver pronto, usa a hora do JS nativo como fallback
            text: clock.now ? clock.now.toLocaleTimeString(Qt.locale(), "HH:mm") : new Date().toLocaleTimeString(Qt.locale(), "HH:mm")
            font.family: Appearance.font.family
            font.pixelSize: Appearance.font.large
            font.bold: true
            color: Appearance.colors.text
            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            // Se clock.now ainda não estiver pronto, usa a data do JS nativo como fallback
            text: clock.now ? clock.now.toLocaleDateString(Qt.locale(), "ddd, dd MMM") : new Date().toLocaleDateString(Qt.locale(), "ddd, dd MMM")
            font.family: Appearance.font.family
            font.pixelSize: Appearance.font.small
            color: Appearance.colors.textDim
            Layout.alignment: Qt.AlignHCenter
        }
    }
}
