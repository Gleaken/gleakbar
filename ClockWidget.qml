import QtQuick
import Quickshell

GleakRectangle {
    anchors.centerIn: parent
    anchors.margins: 2

    Text {
        id: child
        anchors.centerIn: parent
        text: Time.time
        color: '#b0b0b0'
        font.pixelSize: GlobalVariables.fontSize
    }
}
