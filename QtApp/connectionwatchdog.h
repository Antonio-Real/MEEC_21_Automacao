#ifndef CONNECTIONWATCHDOG_H
#define CONNECTIONWATCHDOG_H

#include <QObject>

#include "tag.h"

class ConnectionWatchdog : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isOnline READ isOnline NOTIFY isOnlineChanged)

public:
    explicit ConnectionWatchdog(QObject *parent = nullptr);

    bool isOnline() const;

signals:
    void isOnlineChanged();

private:
    void setIsOnline(bool newIsOnline);
    void checkConnection();

    int32_t m_tag;
    QTimer m_timer;
    bool m_isOnline;
};

#endif // CONNECTIONWATCHDOG_H
