#ifndef TRANSLATIONMANAGER_H
#define TRANSLATIONMANAGER_H

#include <QObject>
#include <QQmlEngine>
#include <QGuiApplication>
#include <QTranslator>

class TranslationManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(Language language READ language WRITE setLanguage NOTIFY languageChanged)

public:
    enum Language {
        PT,
        EN
    };
    Q_ENUM(Language);

    explicit TranslationManager(QQmlEngine *engine, QGuiApplication *app, QObject *parent = nullptr);

    Language language() const;
    void setLanguage(Language newLanguage);

signals:
    void languageChanged();

private:
    void reloadLanguage();

    QQmlEngine *m_engine;
    QGuiApplication *m_app;

    Language m_language;
    std::unique_ptr<QTranslator> m_translator;
};

#endif // TRANSLATIONMANAGER_H
