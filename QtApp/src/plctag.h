#ifndef PLCTAG_H
#define PLCTAG_H

#include "libplctag.h"
#include <QObject>
#include <QTimer>

template<typename T>
class PlcTag : public QObject
{
public:
    explicit PlcTag(std::string tagName, int readWriteTimeout) :
        m_tagName(tagName),
        timeout(readWriteTimeout) {
        plc_tag_set_debug_level(PLCTAG_DEBUG_ERROR);

        /* create the tag */
        m_tag = plc_tag_create(m_tagName.c_str(), timeout);

        if(m_tag < 0) {
            qDebug("ERROR %s: Could not create tag!\n", plc_tag_decode_error(m_tag));
            return;
        }

        int rc;
        if((rc = plc_tag_status(m_tag)) != PLCTAG_STATUS_OK) {
            qDebug("Error setting up tag internal state. Error %s\n", plc_tag_decode_error(rc));
            return ;
        }

        int tagSize = plc_tag_get_size(m_tag);
        Q_ASSERT(tagSize == sizeof(T));
    }

    ~PlcTag() {
        plc_tag_destroy(m_tag);
    }

    const T &getData() {
        readTag();
        return m_data;
    }
    void setData(const T &newData) {
        m_data = newData;
        writeTag();
    }

private:
    void readTag() {
        int rc = plc_tag_read(m_tag, timeout);
        if(rc != PLCTAG_STATUS_OK) {
            qDebug("ERROR: Unable to read the data! Got error code %d: %s\n",rc, plc_tag_decode_error(rc));
            return;
        }

        rc = plc_tag_get_raw_bytes(m_tag, 0, (uint8_t*)&m_data, sizeof(T));

        if(rc != PLCTAG_STATUS_OK) {
            qDebug("ERROR: Unable to write the data! Got error code %d: %s\n",rc, plc_tag_decode_error(rc));
            return;
        }
    }

    void writeTag() {
        int rc = plc_tag_set_raw_bytes(m_tag, 0, (uint8_t*)&m_data, sizeof(m_data));
        if(rc != PLCTAG_STATUS_OK) {
            qDebug("ERROR: Unable to write the data! Got error code %d: %s\n",rc, plc_tag_decode_error(rc));
        }

        rc = plc_tag_write(m_tag, timeout);
        if(rc != PLCTAG_STATUS_OK) {
            qDebug("ERROR: Unable to write the data! Got error code %d: %s\n",rc, plc_tag_decode_error(rc));
        }
    }

    std::string m_tagName;
    int32_t m_tag;
    const uint16_t timeout;

    T m_data;
};

#endif // PLCTAG_H
