pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import "../../common/"

Item {
    implicitWidth: sysRow.implicitWidth + 12
    implicitHeight: parent.height

    property real cpuUsage: 0
    property real memUsage: 0
    property real memTotal: 0
    property real memUsed: 0
    property real cpuTemp: 0

    // CPU usage via /proc/stat
    property var prevIdle: 0
    property var prevTotal: 0

    Timer {
        interval: 3000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            cpuReader.running = true
            memReader.running = true
            tempReader.running = true
        }
    }

    Process {
        id: cpuReader
        command: ["bash", "-c", "cat /proc/stat | head -1"]
        stdout: SplitParser {
            onRead: line => {
                const parts = line.trim().split(/\s+/)
                const user = parseInt(parts[1])
                const nice = parseInt(parts[2])
                const system = parseInt(parts[3])
                const idle = parseInt(parts[4])
                const iowait = parseInt(parts[5])
                const irq = parseInt(parts[6])
                const softirq = parseInt(parts[7])

                const total = user + nice + system + idle + iowait + irq + softirq
                const idleTime = idle + iowait

                if (prevTotal > 0) {
                    const deltaTotal = total - prevTotal
                    const deltaIdle = idleTime - prevIdle
                    cpuUsage = Math.round((1 - deltaIdle / deltaTotal) * 100)
                }
                prevTotal = total
                prevIdle = idleTime
            }
        }
    }

    Process {
        id: memReader
        command: ["bash", "-c", "free -m | awk '/^Mem:/{print $2,$3}'"]
        stdout: SplitParser {
            onRead: line => {
                const parts = line.trim().split(/\s+/)
                memTotal = parseFloat(parts[0])
                memUsed = parseFloat(parts[1])
                memUsage = Math.round((memUsed / memTotal) * 100)
            }
        }
    }

    Process {
        id: tempReader
        command: ["bash", "-c", "cat /sys/class/hwmon/hwmon*/temp1_input 2>/dev/null | head -1"]
        stdout: SplitParser {
            onRead: line => {
                const val = parseInt(line.trim())
                if (!isNaN(val)) cpuTemp = Math.round(val / 1000)
            }
        }
    }

    function cpuColor(): color {
        if (cpuUsage > 80) return Appearance.colors.error
        if (cpuUsage > 60) return Appearance.colors.warning
        return Appearance.colors.textDim
    }

    function memColor(): color {
        if (memUsage > 85) return Appearance.colors.error
        if (memUsage > 70) return Appearance.colors.warning
        return Appearance.colors.textDim
    }

    RowLayout {
        id: sysRow
        anchors.centerIn: parent
        spacing: 8

        // CPU
        RowLayout {
            spacing: 3
            Text {
                text: ""
                font.family: Appearance.font.iconFamily
                font.pixelSize: Appearance.font.normal
                color: cpuColor()
            }
            Text {
                text: cpuUsage + "%"
                font.family: Appearance.font.family
                font.pixelSize: Appearance.font.normal
                color: cpuColor()
            }
        }

        // Temp
        RowLayout {
            spacing: 3
            visible: cpuTemp > 0
            Text {
                text: ""
                font.family: Appearance.font.iconFamily
                font.pixelSize: Appearance.font.normal
                color: cpuTemp > 80 ? Appearance.colors.error : Appearance.colors.textDim
            }
            Text {
                text: cpuTemp + "°"
                font.family: Appearance.font.family
                font.pixelSize: Appearance.font.normal
                color: cpuTemp > 80 ? Appearance.colors.error : Appearance.colors.textDim
            }
        }

        // RAM
        RowLayout {
            spacing: 3
            Text {
                text: ""
                font.family: Appearance.font.iconFamily
                font.pixelSize: Appearance.font.normal
                color: memColor()
            }
            Text {
                text: memUsed.toFixed(1) + "G"
                font.family: Appearance.font.family
                font.pixelSize: Appearance.font.normal
                color: memColor()
            }
        }
    }
}
