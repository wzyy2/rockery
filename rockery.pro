TEMPLATE = app
TARGET = rockery
QT += quickcontrols2 webengine

SOURCES += \
    rockery.cpp \
    fpstext.cpp

OTHER_FILES += \
    rockery.qml

RESOURCES += \
    rockery.qrc

target.path = $$[QT_INSTALL_EXAMPLES]/quickcontrols2/rockery
INSTALLS += target

DISTFILES += \
    subapp_qml/video/*.qml \
    subapp_qml/gles/*.qml \
    subapp_qml/browser/*.qml

HEADERS += \
    fpstext.h
