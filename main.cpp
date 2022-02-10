#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include "translationmanager.h"
#include "plcprogram.h"
#include "connectionwatchdog.h"
int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    QQuickStyle::setStyle("Material");

    TranslationManager manager(&engine, &app, &app);
    ConnectionWatchdog watchdog;

    qmlRegisterSingletonInstance<ConnectionWatchdog>("PlcTags", 1, 0, "ConnectionWatchdog", &watchdog);
    qmlRegisterSingletonInstance<TranslationManager>("Translation", 1, 0, "TranslationManager", &manager);
    qmlRegisterType<PlcProgram>("PlcTags", 1, 0, "PlcProgram");
    qmlRegisterType<Tag>("PlcTags", 1, 0, "Tag");


    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
