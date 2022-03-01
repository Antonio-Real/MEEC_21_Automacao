import QtQuick 2.0

QtObject {
    id: object

    // This is for testing purposes only, in a real situation we'd have a database managing
    // users, roles, logins etc etc
    property var userDatabase: [
        {"name" : "ANTONIO14848", "pw" : "14848", "role" : "OPERATOR"},
        {"name" : "ANIBAL11111", "pw" : "11111", "role" : "DESIGNER"},
        {"name" : "SERGIO14890", "pw" : "14890", "role" : "SUPERVISOR"},
        {"name" : "LUIS14851", "pw" : "14851", "role" : "MANAGER"},
    ]
}
