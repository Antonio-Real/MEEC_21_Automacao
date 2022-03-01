#include "mouseeventlistener.h"
#include <QQmlEngine>
#include <QJSEngine>
#include <QEvent>
#include <QGuiApplication>

MouseEventListener::MouseEventListener(QObject *parent) : QObject(parent)
{
}

// This implements the SINGLETON PATTERN (*usually evil*)
// so you can get the instance in C++
MouseEventListener* MouseEventListener::instance()
{
    static MouseEventListener* inst;
    if (inst == nullptr)
    {
        // If no instance has been created yet, creat a new and install it as event filter.
        // Uppon first use of the instance, it will automatically
        // install itself in the QGuiApplication
        inst = new MouseEventListener();
        QGuiApplication* app = qGuiApp;
        app->installEventFilter(inst);
    }
    return inst;
}

// This is the method to fullfill the signature required by
// qmlRegisterSingletonType.
QObject* MouseEventListener::singletonProvider(QQmlEngine *, QJSEngine *)
{
    return MouseEventListener::instance();
}

// This MouseEventListener the method is necessary for 'installEventFilter'
bool MouseEventListener::eventFilter(QObject* watched, QEvent* event)
{
    QEvent::Type t = event->type();
    if ((t == QEvent::MouseButtonDblClick
         || t == QEvent::MouseButtonPress
         || t == QEvent::MouseButtonRelease
         || t == QEvent::MouseMove
         || t == QEvent::TouchBegin
         || t == QEvent::TouchUpdate)
            && event->spontaneous() // Take only mouse events from outside of Qt
            )
        emit mouseEventDetected();
    return QObject::eventFilter(watched, event);
}
