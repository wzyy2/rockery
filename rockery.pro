TEMPLATE = app
TARGET = rockery
QT += quick quickcontrols2

SOURCES += \
    rockery.cpp \
    fpstext.cpp \
    subapp/gles/gles-triangle-renderer.cpp \
    subapp/gles/gles-triangle-view.cpp

OTHER_FILES += \
    rockery.qml

RESOURCES += \
    rockery.qrc

target.path = $$[QT_INSTALL_EXAMPLES]/quickcontrols2/rockery
INSTALLS += target

DISTFILES += \
    subapp_qml/video/*.qml \
    subapp_qml/gles/*.qml

HEADERS += \
    fpstext.h \
    subapp/gles/gles-triangle-renderer.h \
    subapp/gles/gles-triangle-view.h
