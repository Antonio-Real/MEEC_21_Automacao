#include "translationmanager.h"

TranslationManager::TranslationManager(QQmlEngine *engine, QGuiApplication *app, QObject *parent) :
    QObject(parent),
    m_engine(engine),
    m_app(app),
    m_language(EN)
{
    reloadLanguage();
}

TranslationManager::Language TranslationManager::language() const
{
    return m_language;
}

void TranslationManager::setLanguage(Language newLanguage)
{
    if (m_language == newLanguage)
        return;
    m_language = newLanguage;
    emit languageChanged();
    reloadLanguage();
}

void TranslationManager::reloadLanguage()
{
    QString path;
    if(m_language == Language::EN) {
        path = ":/languages/translation_en";
    }
    else if (m_language == Language::PT) {
        path = ":/languages/translation_pt";
    }

    std::unique_ptr<QTranslator> translator(new QTranslator());
    if (!translator->load(path)) return;

    qDebug() << "Loaded translation file";

    m_app->removeTranslator(m_translator.get());
    m_app->installTranslator(translator.get());
    m_translator.swap(translator);

    m_engine->retranslate();
}
