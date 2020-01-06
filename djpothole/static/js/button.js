const butt = () => {
  var firebaseConfig = {
    apiKey: "AIzaSyAdyRhmquuWcLqF5F9xFhiwfvRsjvWnEtc",
    authDomain: "sih-test-8c936.firebaseapp.com",
    databaseURL: "https://sih-test-8c936.firebaseio.com",
    projectId: "sih-test-8c936",
    storageBucket: "sih-test-8c936.appspot.com",
    messagingSenderId: "209924411187",
    appId: "1:209924411187:web:2d1279bbd788bd2351f846"
  };
  // Initialize Firebase
  var db = firebase.firestore();
  var x = db.collection("reports").doc(id);
  return x.update({
    status: "Working"
  });
  console.log("a");
};
