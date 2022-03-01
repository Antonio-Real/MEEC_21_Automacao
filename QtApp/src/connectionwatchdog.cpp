#include "connectionwatchdog.h"
#include "libplctag.h"

#include <QtConcurrent>

ConnectionWatchdog::ConnectionWatchdog(QObject *parent) : QObject(parent), m_isOnline(false)
{
    // The specific tag doesn't matter, we choose any tag to periodically read, if the read doesn't
    // work then the communication is not working


    m_tag = plc_tag_create("protocol=ab_eip&gateway=192.168.250.10&path=1,0&cpu=omron-njnx&name=Al_Emergency", 1000);

    if(m_tag < 0) {
        qDebug("ERROR %s: Could not create tag: %s\n", plc_tag_decode_error(m_tag), "Al_Emergency");
        return;
    }

    int rc;
    if((rc = plc_tag_status(m_tag)) != PLCTAG_STATUS_OK) {
        qDebug("Error setting up tag internal state. Error %s\n", plc_tag_decode_error(rc));
        return ;
    }

    connect(&m_timer, &QTimer::timeout, this, &ConnectionWatchdog::checkConnection);
    m_timer.start(1000);
}

bool ConnectionWatchdog::isOnline() const
{
    return m_isOnline;
}

void ConnectionWatchdog::setIsOnline(bool newIsOnline)
{
    if (m_isOnline == newIsOnline)
        return;
    m_isOnline = newIsOnline;
    emit isOnlineChanged();
}

void ConnectionWatchdog::checkConnection()
{
    QtConcurrent::run([this](){
        int rc = plc_tag_read(m_tag, 1000);
        if(rc != PLCTAG_STATUS_OK) {
            qDebug("ERROR: Unable to read the data! Got error code %d: %s\n",rc, plc_tag_decode_error(rc));

            setIsOnline(false);
            return;
        }
        setIsOnline(true);
    });
}
