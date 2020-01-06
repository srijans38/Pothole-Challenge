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
firebase.initializeApp(firebaseConfig);
var db = firebase.firestore();
db.collection("reports").onSnapshot(querySnapshot => {
  const documents = [];
  querySnapshot.forEach(doc => {
    const d = doc;
    documents.push(d);
  });
  var a = document.getElementById("test");
  var filteredDocuments = documents.filter(docu => {
    return docu
      .data()
      .region.toLowerCase()
      .includes(user.toLowerCase());
  });
  filteredDocuments.sort((a, b) => {
    return b.data().occurrence - a.data().occurrence;
  });
  a.innerHTML = "";
  filteredDocuments.forEach(data => {
    var li = document.createElement("a");
    li.className = "list-group-item list-group-item-action";
    li.innerHTML = `<h1>${data.data().occurrence}</h1>`;
    li.href = "" + data.id;
    a.appendChild(li);
  });
});
