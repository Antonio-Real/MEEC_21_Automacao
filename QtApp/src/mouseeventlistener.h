#ifndef MOUSEEVENTLISTENER_H
#define MOUSEEVENTLISTENER_H

#include <QObject>
#include <QtQml>
#include <QQmlEngine>
#include <QJSEngine>

/*!
 * \brief The MouseEventSpy class is responsible to pay attention to all the mouse and touch events.
 * This class is used to detect when a user clicked, pressed, make a drag movement using the mouse or touch device meanwhile the application
 * is with the screensaver/screenlocker up and running.
 */

class MouseEventListener : public QObject
{
    Q_OBJECT
public:
    explicit MouseEventListener(QObject *parent = 0);

    /// \brief instance of the mouse/touch spy
    static MouseEventListener* instance();
    /// \brief provided singleton access to the class
    static QObject* singletonProvider(QQmlEngine* engine, QJSEngine* script);

protected:
    bool eventFilter(QObject* watched, QEvent* event);

signals:
    /// \brief signal emitted when a event is detected
    void mouseEventDetected(/*Pass meaningfull information to QML?*/);

};

#endif // MOUSEEVENTLISTENER_H
