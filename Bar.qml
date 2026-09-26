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
                //        left: true
                //       right: true
            }
            implicitHeight: 25
            implicitWidth: 300

            ClockWidget {
                anchors.centerIn: parent
            }
        }
    }
}

