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

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (audio)
                audio.muted = !audio.muted
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
