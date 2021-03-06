var firebaseConfig = {
  apiKey: "AIzaSyAdyRhmquuWcLqF5F9xFhiwfvRsjvWnEtc",
  authDomain: "sih-test-8c936.firebaseapp.com",
  databaseURL: "https://sih-test-8c936.firebaseio.com",
  projectId: "sih-test-8c936",
  storageBucket: "sih-test-8c936.appspot.com",
  messagingSenderId: "209924411187",
  appId: "1:209924411187:web:2d1279bbd788bd2351f846"
};

var stat = "";

const workingButton = () => {
  var db = firebase.firestore();
  var x = db.collection("reports").doc(id);
  return x.update({
    status: "Working"
  });
};

const completeButton = () => {
  var db = firebase.firestore();
  var x = db.collection("reports").doc(id);
  return x.update({
    status: "Completed"
  });
};

const dis = () => {
  var accept = document.getElementById("accept");
  var complete = document.getElementById("complete");
  var db = firebase.firestore();
  db.collection("reports")
    .doc(id)
    .onSnapshot(querySnapshot => {
      stat = querySnapshot.data().status;
      if (stat == "Working") {
        accept.style.visibility = "hidden";
        complete.style.visibility = "visible";
      } else if (stat == "Completed") {
        complete.style.visibility = "hidden";
        accept.style.visibility = "hidden";
      } else {
        complete.style.visibility = "hidden";
        accept.style.visibility = "visible";
      }
    });
};
