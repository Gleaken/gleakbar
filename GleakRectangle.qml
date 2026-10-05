import Quickshell
import QtQuick

Rectangle {
    color: GlobalVariables.backgroundColor
    radius: GlobalVariables.cornerRadius
    anchors.verticalCenter: parent.verticalCenter
    implicitWidth: child.implicitWidth + 25
    implicitHeight: child.implicitHeight + 3
    //height: parent.height 
    //anchors.margins: 3

    border.color: '#5e81ac'
}

