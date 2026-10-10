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

    function getWeatherIcon(w: string): string {
        if (w === "Rain") return ""
        if (w === "Clouds") return "󰖐"
        if (w === "Clear") return "󰖙"
        if (w === "Snow") return "󰼶"
        return w
    }

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
                var d = getWeatherIcon(parts[1])
                child.text = parts[0] + "󰔄   " + d
            }
        }
        Component.onCompleted: running = true
    }

    Timer {
        interval: 6000
        running: true
        repeat: true
        onTriggered: {
            weather.running = true
        }
    }
}
