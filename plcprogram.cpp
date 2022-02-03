#include "plcprogram.h"
#include "libplctag.h"

#include <QDebug>

PlcProgram::PlcProgram(QObject *parent) : QObject(parent),
    m_tag("protocol=ab_eip&gateway=192.168.250.10&path=1,0&cpu=omron-njnx&name=VarEdition", 2000)
{    
}

void PlcProgram::readData()
{
    sProgram prog = m_tag.getData();

    name = QString(prog.name);
    sfill_exec = prog.sfill_exec;
    sfill_axisPosition = prog.sfill_axisPosition;
    sfill_timer = prog.sfill_timer;
    spol_exec = prog.spol_exec;
    spol_brushType = prog.spol_brushType;
    spol_timer = prog.spol_timer;
    sclean_exec = prog.sclean_exec;
    sclean_air_pressure = prog.sclean_air_pressure;
    sclean_timer = prog.sclean_timer;
    spaint_exec = prog.spaint_exec;
    spaint_axisPosition = prog.spaint_axisPosition;
    spaint_timer = prog.spaint_timer;
    sdry_exec = prog.sdry_exec;
    sdry_UV_exec = prog.sdry_UV_exec;
    sdry_Heat_exec = prog.sdry_Heat_exec;
    sdry_Fan_exec = prog.sdry_Fan_exec;
    sdry_UV_timer = prog.sdry_UV_timer;
    sdry_Heat_timer = prog.sdry_Heat_timer;
    sdry_Fan_timer = prog.sdry_Fan_timer;

    emit newTagData();
}

void PlcProgram::writeData()
{
    sProgram prog;

    qstrncpy(prog.name, name.toStdString().c_str(), 18);
    prog.sfill_exec = sfill_exec;
    prog.sfill_axisPosition = sfill_axisPosition;
    prog.sfill_timer = sfill_timer;
    prog.spol_exec = spol_exec;
    prog.spol_brushType = spol_brushType;
    prog.spol_timer = spol_timer;
    prog.sclean_exec = sclean_exec;
    prog.sclean_air_pressure = sclean_air_pressure;
    prog.sclean_timer = sclean_timer;
    prog.spaint_exec = spaint_exec;
    prog.spaint_axisPosition = spaint_axisPosition;
    prog.spaint_timer = spaint_timer;
    prog.sdry_exec = sdry_exec;
    prog.sdry_UV_exec = sdry_UV_exec;
    prog.sdry_Heat_exec = sdry_Heat_exec;
    prog.sdry_Fan_exec = sdry_Fan_exec;
    prog.sdry_UV_timer = sdry_UV_timer;
    prog.sdry_Heat_timer = sdry_Heat_timer;
    prog.sdry_Fan_timer = sdry_Fan_timer;

    m_tag.setData(prog);
}
