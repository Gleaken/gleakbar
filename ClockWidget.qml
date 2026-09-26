import QtQuick
import Quickshell

GleakRectangle {
    color: GlobalVariables.backgroundColor
    anchors.centerIn: parent
    radius: GlobalVariables.cornerRadius
    implicitWidth: child.implicitWidth + 30
    height: parent.height - 5
    anchors.margins: 2

    Text {
        id: child
        anchors.centerIn: parent
        text: Time.time
        color: '#b0b0b0'
        font.pixelSize: GlobalVariables.fontSize
    }
}
