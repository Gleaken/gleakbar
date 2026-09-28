import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

GleakRectangle {
    anchors.left: parent.left
    anchors.leftMargin: 10

    RowLayout{
        id: child
        anchors.centerIn: parent
        Repeater {
            model: 6
            Text {
                property var ws: Hyprland.workspaces.values.find(w => w.id ===index + 1)
                property bool isActive: Hyprland.focusedWorkspace?.id === (index +1)
                text: isActive ? "" : ""
                color: isActive ? "#b48ead" : (ws ? "#8fbcbb" : "#444b6a")
                font { pixelSize: GlobalVariables.fontSize; bold: true }

                MouseArea {
                    anchors.fill: parent
                    onClicked: Hyprland.dispatch("hl.dsp.focus({ workspace = " + (index +1) + " })")
                }
            }
        }

        Item { Layout.fillWidth: true}
    }
}


