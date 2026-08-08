import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import Quickshell.Io

PanelWindow {
    id: bar

    anchors {
        top: true
        left: true
        right: true
    }

    // readonly property color barBg: "#141414"
    // readonly property color barFgActive: "#ffffff"
    // readonly property color barFgEmpty: "#888888"
    // readonly property color barHoverBg: "#202020"
    // readonly property color barAccent: "#ffffff"
    // readonly property color barMagicDot: "#ff0000"

    readonly property color barBg: "#2D353B"
    readonly property color barFgActive: "#D3C6AA"
    readonly property color barFgEmpty: "#7A8478"
    readonly property color barHoverBg: "#232A2E"
    readonly property color barAccent: "#D3C6AA"
    readonly property color barMagicDot: "#ff0000"

    readonly property font barFont: Qt.font({ family: "Inter", pixelSize: 9 })
    readonly property font iconFont: Qt.font({ family: "Inter", pixelSize: 12 })

    readonly property bool inMagicSpace: {
        const ws = Hyprland.focusedWorkspace;
        return ws != null && ws.name.startsWith("special:");
    }

    property string currentSubmap: ""

    Connections {
        target: Hyprland

        function onRawEvent(event) {
            if (event.name === "submap") {
                currentSubmap = event.data;
            }
        }
    }

    SystemClock {
        id: sysClock
        precision: SystemClock.Minutes
    }

    property string clockText: Qt.formatDateTime(sysClock.date, "ddd dd MMM • hh:mm AP")

    implicitHeight: 28
    color: barBg

    Rectangle {
        anchors.fill: parent
        color: barBg
        opacity: 0.85

        Row {
            anchors {
                left: parent.left
                leftMargin: 8
                verticalCenter: parent.verticalCenter
            }

            spacing: 2

            Rectangle {
                width: 8
                height: 8
                radius: 4
                color: barMagicDot
                anchors.verticalCenter: parent.verticalCenter
                visible: inMagicSpace
            }

            Rectangle {
                width: 6
                height: 1
                color: "transparent"
                visible: inMagicSpace
            }

            Repeater {
                model: {
                    const wsList = [];
                    const seen = new Set();

                    for (const ws of Hyprland.workspaces.values) {
                        if (ws.id >= 1) {
                            wsList.push(ws);
                            seen.add(ws.id);
                        }
                    }

                    for (let i = 1; i <= 5; i++) {
                        if (!seen.has(i)) wsList.push(i);
                    }

                    wsList.sort((a, b) => (a.id || a) - (b.id || b));
                    return wsList;
                }

                delegate: MouseArea {
                    required property var modelData

                    readonly property var ws: typeof modelData === "number"
                        ? Hyprland.workspaces.values.find(w => w.id === modelData)
                        : modelData

                    readonly property int wsId: typeof modelData === "number" ? modelData : modelData.id

                    readonly property int toplevelCount: {
                        let count = 0;
                        for (const t of Hyprland.toplevels.values) {
                            if (t.workspace && t.workspace.id === wsId) count++;
                        }
                        return count;
                    }

                    width: 28
                    height: 28

                    hoverEnabled: true

                    onClicked: ws ? ws.activate() : Hyprland.dispatch(`workspace ${wsId}`)

                    Rectangle {
                        anchors.fill: parent
                        color: parent.containsMouse ? barHoverBg : "transparent"

                        Text {
                            anchors.centerIn: parent

                            text: wsId
                            color: ws?.focused || toplevelCount > 0 ? barFgActive : barFgEmpty
                            font: barFont
                        }

                        Rectangle {
                            visible: ws?.focused ?? false

                            anchors {
                                left: parent.left
                                right: parent.right
                                bottom: parent.bottom
                            }

                            height: 2
                            color: barAccent
                        }
                    }
                }
            }
        }

        Row {
            anchors.centerIn: parent
            spacing: 6

            Rectangle {
                width: 6
                height: 6
                radius: 3
                color: "#ff0000"
                anchors.verticalCenter: parent.verticalCenter
                visible: currentSubmap === "wallpaper"
            }

            Text {
                id: clockLabel
                text: clockText
                font.family: barFont.family
                font.pixelSize: barFont.pixelSize
                font.letterSpacing: 1
                color: barFgActive
            }
        }

        Row {
            anchors {
                right: parent.right
                rightMargin: 8
                verticalCenter: parent.verticalCenter
            }

            spacing: 2

            BluetoothWidget {
                anchors.verticalCenter: parent.verticalCenter
            }

            AudioWidget {
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    component AudioWidget: MouseArea {
        id: audioRoot
        width: contentRow.width + 8
        height: 28
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        acceptedButtons: Qt.LeftButton | Qt.RightButton

        property real volume: Pipewire.defaultAudioSink ? Pipewire.defaultAudioSink.audio.volume : 0
        property bool muted: Pipewire.defaultAudioSink ? Pipewire.defaultAudioSink.audio.muted : false
        readonly property int volumePercent: Math.round(volume * 100)
        readonly property var volIcons: ["▁", "▂", "▄", "▆", "█"]
        readonly property string volIcon: volIcons[Math.min(4, Math.floor(volumePercent / 20))]

        PwObjectTracker {
            objects: [Pipewire.defaultAudioSink]
        }

        Rectangle {
            anchors.fill: parent
            color: "transparent"

            Row {
                id: contentRow
                anchors.centerIn: parent
                spacing: 6

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: muted ? "0%" : volumePercent + "%"
                    font: barFont
                    color: barFgActive
                }

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: muted ? "✕" : volIcon
                    font: iconFont
                    color: barFgActive
                }
            }
        }

        onClicked: (mouse) => {
            if (mouse.button === Qt.RightButton) {
                Quickshell.execDetached({ command: ["pavucontrol"] })
            } else if (mouse.button === Qt.LeftButton) {
                if (Pipewire.defaultAudioSink) {
                    Pipewire.defaultAudioSink.audio.muted = !Pipewire.defaultAudioSink.audio.muted
                }
            }
        }

        onWheel: (wheel) => {
            if (!Pipewire.defaultAudioSink) return
            const step = 0.05
            let newVol = Pipewire.defaultAudioSink.audio.volume
            if (wheel.angleDelta.y > 0) {
                newVol = Math.min(1.0, newVol + step)
            } else {
                newVol = Math.max(0.0, newVol - step)
            }
            Pipewire.defaultAudioSink.audio.volume = newVol
        }
    }

    component BluetoothWidget: MouseArea {
        id: btRoot
        width: contentRow.width + 8
        height: 28
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        acceptedButtons: Qt.LeftButton

        property string btDeviceName: ""
        property bool btConnected: false

        Process {
            id: btProc
            command: ["sh", "-c", "bluetoothctl devices Connected | head -1 | sed 's/Device [^ ]* //'"]
            running: true

            stdout: StdioCollector {
                onStreamFinished: {
                    var name = this.text.trim()
                    if (name !== "") {
                        btDeviceName = name
                        btConnected = true
                    } else {
                        btDeviceName = ""
                        btConnected = false
                    }
                }
            }
        }

        Timer {
            interval: 5000
            running: true
            repeat: true
            onTriggered: btProc.running = true
        }

        Rectangle {
            anchors.fill: parent
            color: "transparent"

            Row {
                id: contentRow
                anchors.centerIn: parent
                spacing: 6

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: btConnected ? btDeviceName : "BT"
                    font.family: barFont.family
                    font.pixelSize: 9
                    font.letterSpacing: 1
                    color: btConnected ? barFgActive : barFgEmpty
                }
            }
        }

        onClicked: (mouse) => {
            Quickshell.execDetached({
                command: [
                    "hyprctl",
                    "eval",
                    'hl.dispatch(hl.dsp.exec_cmd("kitty -e bluetui", { float = true, center = true, size = {900, 500} }))',
                ],
            })
        }
    }
}
