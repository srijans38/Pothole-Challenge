const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });

exports.createLeaderboardEntry = functions.auth.user().onCreate((user) => {

    var data = {
        points : 0, 
    }
    
    return admin.firestore().doc('leaderboard/'+user.uid).set(data);
})