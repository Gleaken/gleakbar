import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

GleakRectangle {

    anchors.leftMargin: 30
    visible: true
    implicitWidth: 80
    property string temp: "--"
    property string weather: "-"

    function getWeatherIcon(w: string): string {
        if (w === "Rain") return ""
        if (w === "Clouds") return "󰖐"
        if (w === "clear sky") return "󰖙"
        if (w === "Snow") return "󰼶"
        if (w === "few clouds") return "󰖕"
        if (w === "broken clouds") return ""
        if (w === "overcast clouds") return "󰖐"
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
                var parts = data.trim().split(/,/)
                var d = getWeatherIcon(parts[2])
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
