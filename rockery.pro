TEMPLATE = app
TARGET = rockery
QT += quick quickcontrols2

SOURCES += \
    rockery.cpp \
    fpstext.cpp

OTHER_FILES += \
    rockery.qml \
    pages/*.qml \
    subapp_qml/video/*.qml

RESOURCES += \
    rockery.qrc

target.path = $$[QT_INSTALL_EXAMPLES]/quickcontrols2/rockery
INSTALLS += target

DISTFILES += \
    Splash.qml

HEADERS += \
    fpstext.h
