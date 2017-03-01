import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtMultimedia 5.0
import QtQuick.Dialogs 1.0
import QtQuick.Layouts 1.3
import QtQuick.Window 2.1

Page {
    id: page

    function switchFullScreen()                                 // javascript functions
    {
        if(!mainWindow.fullscreen) {
            if (mainWindow.visibility === Window.FullScreen) {
                mainWindow.showNormal()
            } else {
                mainWindow.showFullScreen()
            }
        }

        mainWindow.header.visible = !mainWindow.header.visible
        footer.visible = !footer.visible
    }

    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        folder: shortcuts.home
        onAccepted: {
            console.log("Open file: " + fileDialog.fileUrls)
            if (mediaplayer.playbackState == MediaPlayer.PlayingState)
                mediaplayer.stop()
            mediaplayer.source = fileDialog.fileUrls[0];
        }
        onRejected: {
            console.log("Canceled")
        }
    }

    MediaPlayer {
        id: mediaplayer
    }

    VideoOutput {
        anchors.fill: parent
        source: mediaplayer
    }

    MouseArea {
        id: playArea
        anchors.fill: parent
        onDoubleClicked: switchFullScreen()
    }

    footer: ToolBar {
        Material.background: "#ffffff"

        RowLayout {
            spacing: 6
            anchors.fill: parent

            RowLayout {
                anchors.left: parent.left;

                ToolButton {
                    contentItem: Image {
                        sourceSize.height: parent.height / 2
                        fillMode: Image.Pad
                        horizontalAlignment: Image.AlignHCenter
                        verticalAlignment: Image.AlignVCenter
                        source: "qrc:/images/play.svg"
                    }

                    onClicked: mediaplayer.play()
                }
                ToolButton {
                    contentItem: Image {
                        sourceSize.height: parent.height / 2
                        fillMode: Image.Pad
                        horizontalAlignment: Image.AlignHCenter
                        verticalAlignment: Image.AlignVCenter
                        source: "qrc:/images/pause.svg"
                    }
                    onClicked: mediaplayer.pause()
                }
                ToolButton {
                    contentItem: Image {
                        sourceSize.height: parent.height / 2
                        fillMode: Image.Pad
                        horizontalAlignment: Image.AlignHCenter
                        verticalAlignment: Image.AlignVCenter
                        source: "qrc:/images/stop.svg"
                    }
                    onClicked: mediaplayer.stop()
                }
            }

            RowLayout {
                anchors.right: parent.right;

                ToolButton {
                    contentItem: Image {
                        sourceSize.height: parent.height / 2
                        fillMode: Image.Pad
                        horizontalAlignment: Image.AlignHCenter
                        verticalAlignment: Image.AlignVCenter
                        source: "qrc:/images/fullscreen.svg"
                    }
                    onClicked: switchFullScreen()
                }

                ToolButton {
                    contentItem: Image {
                        sourceSize.height: parent.height / 2
                        fillMode: Image.Pad
                        horizontalAlignment: Image.AlignHCenter
                        verticalAlignment: Image.AlignVCenter
                        source: "qrc:/images/open.svg"
                    }
                    onClicked: fileDialog.visible = true
                }
            }

        }
    }

}

