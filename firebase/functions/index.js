const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });

const db = admin.firestore();

exports.createLeaderboardEntry = functions.auth.user().onCreate((user) => {

    var data = {
        displayName: user.displayName,
        points : 0, 
    }
    
    return db.doc('leaderboard/'+user.uid).set(data);
})

const docRef = functions.firestore.document('reports/{reportId}');

exports.incrementPointForCreation = docRef.onCreate((snapshot, context) => {
    const data = snapshot.data();
    const userId = data.uid[0];

    return db.doc('leaderboard/'+userId).update({points : admin.firestore.FieldValue.increment(50)});
});

exports.incrementPointForApproval = docRef.onUpdate((change, context) => {
    const oldValue = change.before.data();
    const newValue = change.after.data();
    const userId = change.after.data().uid[0];

    if(oldValue.status === 'Reported' && newValue.status === 'Working') {
        return db.doc('leaderboard/'+userId).update({points : admin.firestore.FieldValue.increment(15)});
    }
});

exports.incrementPointForCompletion = docRef.onUpdate((change, context) => {
    const oldValue = change.before.data();
    const newValue = change.after.data();
    const userId = change.after.data().uid[0];

    if(oldValue.status === 'Working' && newValue.status === 'Completed') {
        return db.doc('leaderboard/'+userId).update({points : admin.firestore.FieldValue.increment(35)});
    }
});

exports.deleteReportImage = docRef.onDelete((snapshot, context) => {
    const data = snapshot.data();
    
    return admin.storage().bucket().file(data.image).delete();
});

exports.decrementPointForReportRemoval = docRef.onDelete((snapshot, context) => {
    const data = snapshot.data();
    const userId = data.uid[0];
    let pointsDeducted = -50;

    if(data.status === 'Working') {
        pointsDeducted -= 15
    } else if (data.status === 'Completed') {
        pointsDeducted -= 50
    }

    return db.doc('leaderboard/'+userId).update({points: admin.firestore.FieldValue.increment(pointsDeducted)});
});