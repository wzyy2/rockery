
/****************************************************************************
**
** Copyright (C) 2015 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/
import QtQuick 2.5
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Universal 2.0
import Qt.labs.settings 1.0
import com.rk.fpstext 1.0

ApplicationWindow {
    id: mainWindow
    width: 960
    height: 540
    visible: true
    title: "Rockery"

    property bool fullscreen: false

    function updateFPS() {
        fps_text.recalculateFPS()
    }

    FPSText {
        id: fps_text
        anchors.right: parent.right
    }

    onFullscreenChanged: {
        if (fullscreen) {
            mainWindow.showFullScreen()
        }
    }

    Shortcut {
        sequence: "Esc"
        enabled: stackView.depth > 1
        onActivated: {
            stackView.pop()
            listView.currentIndex = -1
        }
    }

    header: ToolBar {
        Material.foreground: "white"

        RowLayout {
            spacing: 20
            anchors.fill: parent

            ToolButton {
                contentItem: Image {
                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    source: stackView.depth > 1 ? "images/back.png" : "images/drawer.png"
                }
                onClicked: {
                    if (stackView.depth > 1) {
                        stackView.pop()
                        listView.currentIndex = -1
                    } else {
                        drawer.open()
                    }
                }
            }

            ToolButton {
                anchors.right: parent.right

                contentItem: Image {
                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    source: "qrc:/images/menu.png"
                }
                onClicked: optionsMenu.open()

                Menu {
                    id: optionsMenu
                    x: parent.width - width
                    transformOrigin: Menu.TopRight

                    MenuItem {
                        text: "About"
                        onTriggered: aboutDialog.open()
                    }
                }
            }

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.centerIn: parent.Center
                text: fps_text.fps.toFixed(2)
            }
        }
    }

    Drawer {
        id: drawer
        width: Math.min(mainWindow.width, mainWindow.height) / 3 * 2
        height: mainWindow.height
        dragMargin: stackView.depth > 1 ? 0 : undefined

        ListView {
            id: listView

            focus: true
            currentIndex: -1
            anchors.fill: parent

            delegate: ItemDelegate {
                width: parent.width
                text: model.title
                highlighted: ListView.isCurrentItem
                onClicked: {
                    listView.currentIndex = index
                    stackView.push(model.source)
                    drawer.close()
                }
            }

            model: ListModel {
                ListElement {
                    title: "Video"
                    source: "qrc:/subapp_qml/video/video.qml"
                }
                ListElement {
                    title: "GLES"
                    source: "qrc:/subapp_qml/gles/gles.qml"
                }
            }

            ScrollIndicator.vertical: ScrollIndicator {
            }
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent

        initialItem: Pane {
            id: pane

            SwipeView {
                id: view
                currentIndex: 1
                anchors.fill: parent

                Pane {
                    width: view.width
                    height: view.height

                    Column {
                        spacing: 40
                        width: parent.width

                        Label {
                            width: parent.width
                            wrapMode: Label.Wrap
                            horizontalAlignment: Qt.AlignHCenter
                            text: "GLES subapp will help you test on-screen graphics rendering performance.\n"
                                  + "To test off-screen performance, glmark2-es2 is a better choose. \n"
                                  + "\n Under construction.\n"

                        }
                    }
                    Image {
                        sourceSize.height: parent.height / 3

                        source: "qrc:/images/gpu.svg"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        opacity: gpubtn.pressed? 0.5 : 1

                        MouseArea {
                            id: gpubtn
                            anchors.fill: parent
                            onClicked: {
                                listView.currentIndex = 2
                                stackView.push(
                                            "qrc:/subapp_qml/gles/gles.qml")
                                drawer.close()
                            }
                        }
                    }
                }

                Pane {
                    width: view.width
                    height: view.height

                    Column {
                        spacing: 40
                        width: parent.width

                        Label {
                            width: parent.width
                            wrapMode: Label.Wrap
                            horizontalAlignment: Qt.AlignHCenter
                            text: "Video subapp use qml-video, Video decoding will be done using gstreamer-rockchip.\n"
                                  + "Video Rendering is done by qtsink which use GLESv2 by default.\n\n"
                                  + "If QT_GSTREAMER_WINDOW_VIDEOSINK was set, the other sink will be used.\n"
                        }
                    }
                    Image {
                        sourceSize.height: parent.height / 3

                        source: "qrc:/images/video.svg"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        opacity: videobtn.pressed? 0.5 : 1

                        MouseArea {
                            id: videobtn
                            anchors.fill: parent

                            onClicked: {
                                listView.currentIndex = 2
                                stackView.push(
                                            "qrc:/subapp_qml/video/video.qml")
                                drawer.close()
                            }
                        }
                    }
                }

                Pane {
                    width: view.width
                    height: view.height

                    Column {
                        spacing: 40
                        width: parent.width

                        Label {
                            width: parent.width
                            wrapMode: Label.Wrap
                            horizontalAlignment: Qt.AlignHCenter
                            text: "Camera subapp can show camera preview with rockchip isp driver.\n"
                                  + "\n Under construction.\n"
                        }
                    }
                    Image {
                        sourceSize.height: parent.height / 3

                        source: "qrc:/images/camera.svg"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        opacity: camerabtn.pressed? 0.5 : 1
                        MouseArea {
                            id: camerabtn
                            anchors.fill: parent

                            onClicked: {
                            }
                        }
                    }
                }

                Pane {
                    width: view.width
                    height: view.height

                    Column {
                        spacing: 40
                        width: parent.width

                        Label {
                            width: parent.width
                            wrapMode: Label.Wrap
                            horizontalAlignment: Qt.AlignHCenter
                            text: "Brower subapp provides an integrated Web browser component based on WebKit.\n"
                                  + "\n Under construction.\n"
                        }
                    }
                    Image {
                        sourceSize.height: parent.height / 3

                        source: "qrc:/images/brower.svg"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        opacity: browerbtn.pressed? 0.5 : 1

                        MouseArea {
                            id: browerbtn
                            anchors.fill: parent

                            onClicked: {
                            }
                        }
                    }
                }

            }

            PageIndicator {
                count: view.count
                currentIndex: view.currentIndex
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }

    Popup {
        id: aboutDialog
        modal: true
        focus: true
        x: (mainWindow.width - width) / 2
        y: mainWindow.height / 6
        width: Math.min(mainWindow.width, mainWindow.height) / 3 * 2
        contentHeight: aboutColumn.height

        Column {
            id: aboutColumn
            spacing: 20

            Label {
                text: "About"
                font.bold: true
            }

            Label {
                width: aboutDialog.availableWidth
                text: "Rockery is a simple demonstration application that help you do evaluations on rockchip opensource linux."
                wrapMode: Label.Wrap
                font.pixelSize: 12
            }

            Label {
                width: aboutDialog.availableWidth
                text: "Author: Jacob Chen (jacob2.chen@rock-chips.com)"
                wrapMode: Label.Wrap
                font.pixelSize: 12
            }
        }
    }
}
