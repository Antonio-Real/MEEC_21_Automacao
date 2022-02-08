#include "tag.h"
#include <QDebug>
#include <QtConcurrent>

Tag::Tag(QObject *parent) : QObject(parent),
    m_data(0),
    m_readInterval(1000),
    m_periodicReads(false),
    m_tagParams("protocol=ab_eip&gateway=192.168.250.10&path=1,0&cpu=omron-njnx&name=")
{
    connect(&m_timer, &QTimer::timeout, this, &Tag::readTag);
}

void Tag::initializeTag()
{
    plc_tag_set_debug_level(PLCTAG_DEBUG_ERROR);

    /* create the tag */
    auto str = m_tagParams + m_tagName;
    m_tag = plc_tag_create(str.toStdString().c_str(), timeout);

    if(m_tag < 0) {
        qDebug("ERROR %s: Could not create tag: %s\n", plc_tag_decode_error(m_tag), m_tagName.toStdString().c_str());
        return;
    }

    int rc;
    if((rc = plc_tag_status(m_tag)) != PLCTAG_STATUS_OK) {
        qDebug("Error setting up tag internal state. Error %s\n", plc_tag_decode_error(rc));
        return ;
    }
    readTag();
}

void Tag::readTag()
{
    QtConcurrent::run([this](){
        int rc = plc_tag_read(m_tag, timeout);
        if(rc != PLCTAG_STATUS_OK) {
            qDebug("ERROR: Unable to read the data! Got error code %d: %s\n",rc, plc_tag_decode_error(rc));
            return;
        }

        switch(m_tagType) {
        case BYTE: {
            auto val = plc_tag_get_uint8(m_tag, 0);
            setData(QVariant(val));
            break;
        }
        case BOOL: {
            auto val = plc_tag_get_uint16(m_tag, 0);
            setData(QVariant(val != 0));
            break;
        }
        case WORD: {
            auto val = plc_tag_get_uint16(m_tag, 0);
            setData(QVariant(val));
            break;
        }
        case DWORD: {
            auto val = plc_tag_get_uint32(m_tag, 0);
            setData(QVariant(val));
            break;
        }
        case LWORD: {
            auto val = plc_tag_get_uint64(m_tag, 0);
            setData(QVariant(val));
            break;
        }
        case INT: {
            auto val = plc_tag_get_int16(m_tag, 0);
            setData(QVariant(val));
            break;
        }
        case UINT: {
            auto val = plc_tag_get_uint32(m_tag, 0);
            setData(QVariant(val));
            break;
        }
        case REAL: {
            auto val = plc_tag_get_float32(m_tag, 0);
            setData(QVariant(val));
            break;
        }
        case LREAL: {
            auto val = plc_tag_get_float64(m_tag, 0);
            setData(QVariant(val));
            break;
        }
        }
    });
}

void Tag::writeTag()
{
    QtConcurrent::run([this](){
        int rc;
        switch(m_tagType) {
        case BYTE: {
            auto val = data().value<uint8_t>();
            rc = plc_tag_set_uint8(m_tag, 0, val);
            break;
        }
        case BOOL: {
            auto val = data().value<uint16_t>();
            rc = plc_tag_set_uint16(m_tag, 0, val);
            break;
        }
        case WORD: {
            auto val = data().value<uint16_t>();
            rc = plc_tag_set_uint16(m_tag, 0, val);
            break;
        }
        case DWORD: {
            auto val = data().value<uint32_t>();
            rc = plc_tag_set_uint32(m_tag, 0, val);
            break;
        }
        case LWORD: {
            auto val = data().value<uint64_t>();
            rc = plc_tag_set_uint64(m_tag, 0, val);
            break;
        }
        case INT: {
            auto val = data().value<int16_t>();
            rc = plc_tag_set_int16(m_tag, 0, val);
            break;
        }
        case UINT: {
            auto val = data().value<uint16_t>();
            rc = plc_tag_set_uint16(m_tag, 0, val);
            break;
        }
        case REAL: {
            auto val = data().value<float>();
            rc = plc_tag_set_float32(m_tag, 0, val);
            break;
        }
        case LREAL: {
            auto val = data().value<double>();
            rc = plc_tag_set_float64(m_tag, 0, val);
            break;
        }
        }

        if(rc != PLCTAG_STATUS_OK) {
            qDebug("ERROR: Unable to write the data! Got error code %d: %s\n",rc, plc_tag_decode_error(rc));
            return;
        }

        rc = plc_tag_write(m_tag, timeout);
        if(rc != PLCTAG_STATUS_OK) {
            qDebug("ERROR: Unable to write the data! Got error code %d: %s\n",rc, plc_tag_decode_error(rc));
        }
    });
}

const QVariant &Tag::data() const
{
    return m_data;
}

void Tag::setData(const QVariant &newData)
{
    if (m_data == newData)
        return;
    m_data = newData;
    emit dataChanged();
}

const QString &Tag::tagName() const
{
    return m_tagName;
}

void Tag::setTagName(const QString &newTagName)
{
    if (m_tagName == newTagName)
        return;
    m_tagName = newTagName;
    emit tagNameChanged();
}

Tag::TagType Tag::tagType() const
{
    return m_tagType;
}

void Tag::setTagType(TagType newTagType)
{
    if (m_tagType == newTagType)
        return;
    m_tagType = newTagType;
    emit tagTypeChanged();
}

bool Tag::periodicReads() const
{
    return m_periodicReads;
}

void Tag::setPeriodicReads(bool newPeriodicReads)
{
    if (m_periodicReads == newPeriodicReads)
        return;
    m_periodicReads = newPeriodicReads;
    emit periodicReadsChanged();

    if(m_periodicReads) {
        m_timer.start(m_readInterval);
    }
    else {
        m_timer.stop();
    }
}

int Tag::readInterval() const
{
    return m_readInterval;
}

void Tag::setReadInterval(int newReadInterval)
{
    if (m_readInterval == newReadInterval)
        return;
    m_readInterval = newReadInterval;
    emit readIntervalChanged();
}
