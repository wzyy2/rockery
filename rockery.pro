TEMPLATE = app
TARGET = rockery
QT += quick quickcontrols2

SOURCES += \
    rockery.cpp

OTHER_FILES += \
    rockery.qml \
    pages/*.qml

RESOURCES += \
    rockery.qrc

target.path = $$[QT_INSTALL_EXAMPLES]/quickcontrols2/rockery
INSTALLS += target

DISTFILES += \
    Splash.qml
