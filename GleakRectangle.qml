import Quickshell
import QtQuick

Rectangle {
    color: GlobalVariables.backgroundColor
    radius: GlobalVariables.cornerRadius
    anchors.verticalCenter: parent.verticalCenter
    implicitWidth: child.implicitWidth + 30
    height: parent.height - 5
    anchors.margins: 2
    border.color: '#5e81ac'
}

