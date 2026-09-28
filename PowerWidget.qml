import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

GleakRectangle {
    anchors.right: parent.right
    anchors.rightMargin: 10

    Text {
        id: child
        anchors.centerIn: parent
        font.pixelSize: GlobalVariables.fontSize
        color: GlobalVariables.fontColor
        text: ""

        MouseArea {
            anchors.fill : parent
            onClicked: Hyprland.dispatch("hl.dsp.exec_cmd(POWERMENU)")
        }
    }
}
