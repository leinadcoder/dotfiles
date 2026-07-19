/**
 * Pixie Deep Blue — Horizontal clock
 */
import QtQuick

Item {
    id: clock

    width: 560
    height: 140

    property string backgroundSource: ""
    property color baseAccent: "white"
    property string fontFamily: "Sans"
    property bool use24HourClock: true
    property string timeStr: ""

    function padNumber(value) {
        return value < 10 ? "0" + value : value.toString()
    }

    function updateTime() {
        var now = new Date()
        var hours = now.getHours()
        var minutes = now.getMinutes()

        if (!clock.use24HourClock) {
            hours = hours % 12

            if (hours === 0) {
                hours = 12
            }
        }

        clock.timeStr =
            clock.padNumber(hours)
            + ":"
            + clock.padNumber(minutes)
    }

    Component.onCompleted: updateTime()

    Text {
        anchors.centerIn: parent

        text: clock.timeStr
        color: clock.baseAccent

        font.family: clock.fontFamily
        font.pixelSize: 106
        font.weight: Font.Light

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        style: Text.Raised
        styleColor: "#33000000"
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: clock.updateTime()
    }
}
