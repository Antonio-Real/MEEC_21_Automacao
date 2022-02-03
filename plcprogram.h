#ifndef PLCPROGRAM_H
#define PLCPROGRAM_H

#include <QObject>
#include <string>

#include "plctag.h"

struct sProgram {
    char name[20];
    int16_t quantity; // 192 bytes regardless
    int16_t sfill_exec;
    double sfill_axisPosition;
    uint16_t sfill_timer;
    int16_t spol_exec;
    int16_t spol_brushType;
    uint16_t spol_timer;
    int16_t sclean_exec;
    float sclean_air_pressure;
    uint16_t sclean_timer;
    int16_t spaint_exec;
    double spaint_axisPosition;
    uint16_t spaint_timer;
    int16_t sdry_exec;
    int16_t sdry_UV_exec;
    int16_t sdry_Heat_exec;
    int16_t sdry_Fan_exec;
    uint16_t sdry_UV_timer;
    uint16_t sdry_Heat_timer;
    uint16_t sdry_Fan_timer;
    uint16_t reserved[53];
};


class PlcProgram : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name MEMBER name)
    Q_PROPERTY(int sfill_exec MEMBER sfill_exec NOTIFY newTagData)
    Q_PROPERTY(double sfill_axisPosition MEMBER sfill_axisPosition NOTIFY newTagData)
    Q_PROPERTY(int sfill_timer MEMBER sfill_timer NOTIFY newTagData)
    Q_PROPERTY(int spol_exec MEMBER spol_exec NOTIFY newTagData)
    Q_PROPERTY(int spol_brushType MEMBER spol_brushType NOTIFY newTagData)
    Q_PROPERTY(int spol_timer MEMBER spol_timer NOTIFY newTagData)
    Q_PROPERTY(int sclean_exec MEMBER sclean_exec NOTIFY newTagData)
    Q_PROPERTY(float sclean_air_pressure MEMBER sclean_air_pressure NOTIFY newTagData)
    Q_PROPERTY(int sclean_timer MEMBER sclean_timer NOTIFY newTagData)
    Q_PROPERTY(int spaint_exec MEMBER spaint_exec NOTIFY newTagData)
    Q_PROPERTY(double spaint_axisPosition MEMBER spaint_axisPosition NOTIFY newTagData)
    Q_PROPERTY(int spaint_timer MEMBER spaint_timer NOTIFY newTagData)
    Q_PROPERTY(int sdry_exec MEMBER sdry_exec NOTIFY newTagData)
    Q_PROPERTY(int sdry_UV_exec MEMBER sdry_UV_exec NOTIFY newTagData)
    Q_PROPERTY(int sdry_Heat_exec MEMBER sdry_Heat_exec NOTIFY newTagData)
    Q_PROPERTY(int sdry_Fan_exec MEMBER sdry_Fan_exec NOTIFY newTagData)
    Q_PROPERTY(int sdry_UV_timer MEMBER sdry_UV_timer NOTIFY newTagData)
    Q_PROPERTY(int sdry_Heat_timer MEMBER sdry_Heat_timer NOTIFY newTagData)
    Q_PROPERTY(int sdry_Fan_timer MEMBER sdry_Fan_timer NOTIFY newTagData)

public:
    explicit PlcProgram(QObject *parent = nullptr);

public slots:
    void readData();
    void writeData();

signals:
    void newTagData();


private:
    PlcTag<sProgram> m_tag;

    // For exposing to QML
    QString name;
    int16_t sfill_exec;
    double sfill_axisPosition;
    uint16_t sfill_timer;
    int16_t spol_exec;
    int16_t spol_brushType;
    uint16_t spol_timer;
    int16_t sclean_exec;
    float sclean_air_pressure;
    uint16_t sclean_timer;
    int16_t spaint_exec;
    double spaint_axisPosition;
    uint16_t spaint_timer;
    int16_t sdry_exec;
    int16_t sdry_UV_exec;
    int16_t sdry_Heat_exec;
    int16_t sdry_Fan_exec;
    uint16_t sdry_UV_timer;
    uint16_t sdry_Heat_timer;
    uint16_t sdry_Fan_timer;
};

#endif // PLCPROGRAM_H
