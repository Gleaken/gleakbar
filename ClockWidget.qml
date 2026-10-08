import QtQuick
import Quickshell

GleakRectangle {
    anchors.centerIn: parent
    anchors.margins: 2
    implicitWidth: 160

    Text {
        id: child
        anchors.centerIn: parent
        text: Time.time
        color: GlobalVariables.fontColor
        font.pixelSize: GlobalVariables.fontSize
    }
}
