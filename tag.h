#ifndef TAG_H
#define TAG_H

#include <QObject>
#include <QVariant>

#include <plctag.h>

class Tag : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVariant data READ data WRITE setData NOTIFY dataChanged)
    Q_PROPERTY(QString tagName READ tagName WRITE setTagName NOTIFY tagNameChanged REQUIRED)
    Q_PROPERTY(TagType tagType READ tagType WRITE setTagType NOTIFY tagTypeChanged REQUIRED)
    Q_PROPERTY(bool periodicReads READ periodicReads WRITE setPeriodicReads NOTIFY periodicReadsChanged)
    Q_PROPERTY(int readInterval READ readInterval WRITE setReadInterval NOTIFY readIntervalChanged)

public:
    enum TagType {
        BOOL,
        BYTE,
        WORD,
        DWORD,
        LWORD,
        INT,
        UINT,
        REAL,
        LREAL
    };
    Q_ENUM(TagType)

    explicit Tag(QObject *parent = nullptr);

    const QVariant &data() const;
    void setData(const QVariant &newData);

    const QString &tagName() const;
    void setTagName(const QString &newTagName);

    TagType tagType() const;
    void setTagType(TagType newTagType);

    bool periodicReads() const;
    void setPeriodicReads(bool newPeriodicReads);

    int readInterval() const;
    void setReadInterval(int newReadInterval);

public slots:
    void initializeTag();
    void readTag();
    void writeTag();

signals:
    void dataChanged();
    void tagNameChanged();
    void tagTypeChanged();
    void periodicReadsChanged();

    void readIntervalChanged();

private:
    QVariant m_data;
    QString m_tagName;
    TagType m_tagType;
    int m_readInterval;
    bool m_periodicReads;

    QString m_tagParams;
    int32_t m_tag;
    QTimer m_timer;

    const int timeout = 1000;
};

#endif // TAG_H
