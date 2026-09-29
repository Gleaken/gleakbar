import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

GleakRectangle {
    visible: SystemTray.items.values.length > 0

    RowLayout {
        id: child
        anchors.centerIn: parent
        spacing: 6

        Repeater {
            model: SystemTray.items

            MouseArea {
                id: trayItem
                required property SystemTrayItem modelData

                Layout.preferredWidth: 16
                Layout.preferredHeight: 16
                implicitWidth: 16
                implicitHeight: 16
                acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                hoverEnabled: true

                onClicked: event => {
                    if (event.button === Qt.LeftButton)
                        modelData.activate()
                    else if (event.button === Qt.MiddleButton)
                        modelData.secondaryActivate()
                    else if (modelData.hasMenu)
                        menu.open()
                    else
                        modelData.secondaryActivate()
                }

                onWheel: event => {
                    event.accepted = true
                    modelData.scroll(event.angleDelta.y, false)
                }

                IconImage {
                    anchors.fill: parent
                    source: trayItem.modelData.icon
                    implicitSize: 16
                    asynchronous: true
                }

                QsMenuAnchor {
                    id: menu
                    menu: trayItem.modelData.menu
                    anchor.window: trayItem.QsWindow.window
                    anchor.item: trayItem
                    anchor.edges: Edges.Bottom | Edges.Left
                    anchor.gravity: Edges.Bottom | Edges.Right
                }
            }
        }
    }
}
