pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import "../../common/"

Item {
    implicitWidth: volRow.implicitWidth + 12
    implicitHeight: parent.height

    property int volume: 0
    property bool muted: false

    Timer {
        interval: 2000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: volReader.running = true
    }

    Process {
        id: volReader
        command: ["bash", "-c", "wpctl get-volume @DEFAULT_AUDIO_SINK@"]
        stdout: SplitParser {
            onRead: line => {
                const match = line.match(/Volume:\s+([\d.]+)(\s+\[MUTED\])?/)
                if (match) {
                    volume = Math.round(parseFloat(match[1]) * 100)
                    muted = match[2] !== undefined
                }
            }
        }
    }

    function volIcon(): string {
        if (muted || volume === 0) return "󰖁"
        if (volume < 33) return "󰕿"
        if (volume < 66) return "󰖀"
        return "󰕾"
    }

    RowLayout {
        id: volRow
        anchors.centerIn: parent
        spacing: 4

        Text {
            text: volIcon()
            font.family: Appearance.font.iconFamily
            font.pixelSize: Appearance.font.icon
            color: muted ? Appearance.colors.textDim : Appearance.colors.text
        }

        Text {
            text: volume + "%"
            font.family: Appearance.font.family
            font.pixelSize: Appearance.font.normal
            color: muted ? Appearance.colors.textDim : Appearance.colors.text
            visible: !muted
        }
    }

    HoverHandler { id: hover }

    WheelHandler {
        onWheel: event => {
            const delta = event.angleDelta.y > 0 ? 5 : -5
            Quickshell.execDetached(["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", Math.max(0, Math.min(150, volume + delta)) + "%"])
            volReader.running = true
        }
    }

    TapHandler {
        onTapped: Quickshell.execDetached(["wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle"])
    }
}
