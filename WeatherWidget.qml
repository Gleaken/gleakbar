import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

GleakRectangle {

    anchors.leftMargin: 30
    visible: true
    implicitWidth: 100
    property string temp: "--"
    property string weather: "-"

    Text {
        id: child
        anchors.centerIn: parent
        font.pixelSize: GlobalVariables.fontSize
        color: GlobalVariables.fontColor
        text: "--󰔄-"

        MouseArea {
            anchors.fill : parent
            onClicked: Hyprland.dispatch("hl.dsp.exec_cmd(POWERMENU)")
        }
    }

    Process {
        id: weather
        command: ["sh","-c","~/projects/quickshell/gleakbar/scripts/weather.sh"]
        stdout: SplitParser {
            onRead: data => {
                if (!data) return
                var parts = data.trim().split(/\s+/)
                child.text = parts[0] + "󰔄   " + parts[1]
            }
        }
        Component.onCompleted: running = true
    }

    Timer {
        interval: 60000
        running: true
        repeat: true
        onTriggered: {
            weather.running = true
        }
    }
}
