import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts

GleakRectangle {
    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    readonly property var audio: Pipewire.defaultAudioSink?.audio
    readonly property bool muted: audio?.muted ?? true
    readonly property real level: audio?.volume ?? 0
    readonly property int percent: Math.round(level * 100)
    readonly property string volumeIcon: {
        if (muted || percent === 0)
            return ""
        if (percent < 34)
            return ""
        if (percent < 67)
            return ""
        return ""
    }

    implicitWidth: 80

    RowLayout {
        id: child
        anchors.centerIn: parent
        spacing: 6

        Text {
            text: volumeIcon
            color: muted ? GlobalVariables.nord11 : GlobalVariables.fontColor
            font.pixelSize: GlobalVariables.fontSize
        }

        Text {
            text: percent + "%"
            color: muted ? GlobalVariables.nord11 : GlobalVariables.fontColor
            font.pixelSize: GlobalVariables.fontSize
        }
    }

    // Popup to show available sinks - using a proper popup that's not constrained by the bar
    Popup {
        id: sinkPopup
        width: 300
        height: sinkList.height + 40
        modal: true
        dim: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        contentItem: Rectangle {
            color: GlobalVariables.nord0
            border.color: GlobalVariables.nord4
            radius: 8

            ColumnLayout {
                id: sinkList
                anchors.centerIn: parent
                spacing: 5

                Text {
                    text: "Available Audio Sinks"
                    font.pixelSize: GlobalVariables.fontSize + 2
                    color: GlobalVariables.fontColor
                    Layout.alignment: Qt.AlignHCenter
                }

                // List to show all sinks
                Repeater {
                    id: sinkRepeater
                    model: Pipewire.sinkObjects
                    delegate: Rectangle {
                        width: parent.width - 20
                        height: 30
                        color: (Pipewire.defaultAudioSink && Pipewire.defaultAudioSink.id === modelData.id) ? GlobalVariables.nord3 : "transparent"
                        border.color: GlobalVariables.nord4

                        Text {
                            text: modelData.description || modelData.name || "Unknown Sink"
                            anchors.centerIn: parent
                            color: GlobalVariables.fontColor
                            font.pixelSize: GlobalVariables.fontSize
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                // Switch to this sink
                                if (Pipewire.defaultAudioSink && Pipewire.defaultAudioSink.id !== modelData.id) {
                                    Pipewire.defaultAudioSink = modelData;
                                }
                                sinkPopup.close();
                            }
                        }
                    }
                }

                // Mute toggle button for current sink
                Rectangle {
                    width: parent.width - 20
                    height: 30
                    color: "transparent"
                    border.color: GlobalVariables.nord4
                    Text {
                        text: muted ? "Unmute" : "Mute"
                        anchors.centerIn: parent
                        color: GlobalVariables.fontColor
                        font.pixelSize: GlobalVariables.fontSize
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (audio) {
                                audio.muted = !audio.muted;
                            }
                            sinkPopup.close();
                        }
                    }
                }
            }
        }

        // Position the popup near the volume widget
        x: parent.x + (parent.width - width) / 2
        y: parent.y - height - 10
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: mouse => {
            if (mouse.button === Qt.RightButton) {
                Quickshell.execDetached(["pwvucontrol"])
                return
            }

            // Show popup with available sinks
            sinkPopup.open();
        }
        onWheel: wheel => {
            if (!audio)
                return
            const delta = wheel.angleDelta.y > 0 ? 0.05 : -0.05
            audio.volume = Math.max(0, Math.min(1.5, audio.volume + delta))
            if (audio.muted && delta > 0)
                audio.muted = false
            wheel.accepted = true
        }
    }
}