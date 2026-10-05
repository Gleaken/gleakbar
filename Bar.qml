import Quickshell
import Quickshell.Io
import QtQuick

Scope {
    Variants {
        model: Quickshell.screens
        PanelWindow {
            required property var modelData
            screen: modelData
            anchors {
                top: true
                left: true
                right: true
            }
            margins{
                top: 3
                bottom: 0 
            }
            implicitHeight: 26
            color: "#000000ff"

            ClockWidget {
                anchors.centerIn: parent
            }
            WorkspaceWidget {}
            SystemTrayWidget {
                anchors.right: volume.left
                anchors.rightMargin: 8
            }
            VolumeWidget {
                id: volume
                anchors.right: power.left
                anchors.rightMargin: 8
            }
            PowerWidget {
                id: power
            }
        }
    }
}

