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
            implicitHeight: 25
            color: "#405060ff"

            ClockWidget {
                anchors.centerIn: parent
            }
            WorkspaceWidget {}
            PowerWidget {}
        }
    }
}

