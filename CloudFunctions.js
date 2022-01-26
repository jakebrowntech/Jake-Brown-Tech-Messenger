'use strict';

const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp ({
    credential: admin.credential.applicationDefault(),
    databaseURL: 'https://jake-brown-chat-app-default-rtdb.firebaseio.com'
});


exports.fetchContacts = functions.https.onRequest((request, response) => {

    const preparedNumbers = request.body.data.preparedNumbers;
    var users = [];

    Promise.all(preparedNumbers.map(preparedNumber => {
        return admin.database().ref('/users').orderByChild("phoneNumber").equalTo(preparedNumber).once('value').then(snapshot => {
            if (snapshot.exists()) {
                snapshot.forEach((childSnap) => {
                    const uid = childSnap.key;
                    var userData = childSnap.val();
                    userData.id = uid;
                    users.push(userData);
                })
            }
        })
    })).then(() => {
        return Promise.all([response.send({data: users})]);
    });
});

exports.sendGroupMessage = functions.database.ref('/groupChats/{chatID}/userMessages/{messageID}').onCreate((snap, context) => {

    const chatID = context.params.chatID;
    const messageID = context.params.messageID;
    var lastMessageID = "";
    const senderID = snap.val();

    return admin.database().ref(`/groupChats/${chatID}/userMessages`).orderByKey().limitToLast(1).once('child_added').then(snapshot => {

        lastMessageID = snapshot.key;

        admin.database().ref(`/groupChats/${chatID}/metaData/chatParticipantsIDs`).once('value').then(snapshot => {
            let members = Object.keys(snapshot.val());
            members.forEach(function(memberID) {
              if (memberID != senderID) {
                sendMessageToMember(memberID);
                incrementBadge(memberID);
                updateChatLastMessage(memberID);
              }
            });
        });
    });

    function sendMessageToMember(memberID) {
        let userMessagesReference = admin.database().ref(`/user-messages/${memberID}/${chatID}/userMessages`)
        userMessagesReference.update({
           [messageID] : senderID
        });
    }

    function updateChatLastMessage(memberID) {
        let userMessagesReference = admin.database().ref(`/user-messages/${memberID}/${chatID}/metaData`)
        userMessagesReference.update({
            "lastMessageID": lastMessageID
        });
    }

    function incrementBadge(memberID) {
        let badgeReference = admin.database().ref(`/user-messages/${memberID}/${chatID}/metaData/badge`)
        badgeReference.transaction(function (currentValue) {
            return (currentValue || 0) + 1;
        });
    }
});

exports.pushNotification = functions.database.ref('/YourNode/{pushId}').onWrite((change, context) => {
    console.log('Push notification event triggered');

    //  Get the current value of what was written to the Realtime Database.
    const valueObject = change.after.val(); 

    // Create a notification
    const payload = {
        notification: {
            title: senderID,
            body: lastMessageID,
            sound: "default"
        }
    };

    //Create an options object that contains the time to live for the notification and the priority
    const options = {
        priority: "high",
        timeToLive: 60 * 60 * 24
    };

    return admin.messaging().sendToTopic("pushNotifications", payload, options);
});
