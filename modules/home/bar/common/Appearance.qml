pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell

Singleton {
    id: root

    property QtObject colors: QtObject {
        property color background:      "#1a1b26"
        property color backgroundAlpha: Qt.rgba(0.102, 0.106, 0.149, 0.93)
        property color surface:         "#24283b"
        property color border:          "#414868"
        property color text:            "#c0caf5"
        property color textDim:         "#9aa5ce"
        property color primary:         "#7aa2f7"
        property color secondary:       "#c4a7e7"
        property color accent:          "#7dcfff"
        property color warning:         "#e0af68"
        property color error:           "#f7768e"
        property color success:         "#9ece6a"
    }

    property QtObject font: QtObject {
        property string family: "Anonymous Pro for Powerline"
        property string iconFamily: "FiraCode Nerd Font"
        property int small: 11
        property int normal: 13
        property int large: 15
        property int icon: 16
    }

    property QtObject bar: QtObject {
        property int height: 36
        property int marginH: 4
        property int marginV: 4
        property int radius: 12
        property int padding: 8
        property int spacing: 6
    }
}
