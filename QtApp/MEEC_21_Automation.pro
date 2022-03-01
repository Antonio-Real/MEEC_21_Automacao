QT += quick core quickcontrols2 concurrent

CONFIG += c++17

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

INCLUDEPATH += EIP

# These may or may not be necessary
#-lcli -lws2_32
LIBS += -L$${PWD}/EIP/bin -lplctag

SOURCES += \
        src/connectionwatchdog.cpp \
        src/main.cpp \
        src/mouseeventlistener.cpp \
        src/plcprogram.cpp \
        src/tag.cpp \
        src/translationmanager.cpp

HEADERS += \
    src/connectionwatchdog.h \
    src/mouseeventlistener.h \
    src/plcprogram.h \
    src/plctag.h \
    src/tag.h \
    src/translationmanager.h

INCLUDEPATH += src

RESOURCES += qml.qrc

TRANSLATIONS = languages/translation_en.ts  languages/translation_pt.ts

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target


