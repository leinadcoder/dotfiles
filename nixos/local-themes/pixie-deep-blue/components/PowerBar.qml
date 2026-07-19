/**
 * Pixie Deep Blue — Bottom power actions
 */
import QtQuick

Row {
    id: powerBarRoot

    spacing: 24

    property color textColor: "white"

    FontLoader {
        id: iconFont
        source: "../assets/fonts/MaterialDesignIcons.ttf"
    }

    Repeater {
        model: [
            {
                icon: "󰤄",
                label: "Sleep",
                action: "suspend"
            },
            {
                icon: "󰑐",
                label: "Restart",
                action: "reboot"
            },
            {
                icon: "󰐥",
                label: "Shut Down",
                action: "powerOff"
            }
        ]

        delegate: Item {
            id: powerAction

            required property var modelData

            width: 110
            height: 54

            Column {
                anchors.centerIn: parent
                spacing: 4

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter

                    text: powerAction.modelData.icon
                    color: actionMouse.containsMouse
                        ? Qt.lighter(powerBarRoot.textColor, 1.2)
                        : powerBarRoot.textColor

                    font.pixelSize: 20
                    font.family: iconFont.name

                    Behavior on color {
                        ColorAnimation { duration: 120 }
                    }
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter

                    text: powerAction.modelData.label
                    color: powerBarRoot.textColor

                    font.pixelSize: 12
                    opacity: actionMouse.containsMouse ? 0.95 : 0.62

                    Behavior on opacity {
                        NumberAnimation { duration: 120 }
                    }
                }
            }

            MouseArea {
                id: actionMouse

                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    switch (powerAction.modelData.action) {
                    case "suspend":
                        sddm.suspend()
                        break
                    case "reboot":
                        sddm.reboot()
                        break
                    case "powerOff":
                        sddm.powerOff()
                        break
                    }
                }
            }

            scale: actionMouse.pressed ? 0.92 : 1

            Behavior on scale {
                NumberAnimation {
                    duration: 100
                    easing.type: Easing.OutQuad
                }
            }
        }
    }
}
