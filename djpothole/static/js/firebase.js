var firebaseConfig = {
  apiKey: "AIzaSyDhjN-qSOcfwySiePD4q9b5-wvCrNgluX8",
  authDomain: "pot-hole-494e7.firebaseapp.com",
  databaseURL: "https://pot-hole-494e7.firebaseio.com",
  projectId: "pot-hole-494e7",
  storageBucket: "pot-hole-494e7.appspot.com",
  messagingSenderId: "110675265148",
  appId: "1:110675265148:web:887f00855ebb84d7f26bf9",
  measurementId: "G-K4RTXTSKRG"
};
// Initialize Firebase
firebase.initializeApp(firebaseConfig);
var db = firebase.firestore();
db.collection("reports")
  .get()
  .then(querySnapshot => {
    const documents = [];
    querySnapshot.forEach(doc => {
      const d = doc;
      documents.push(d);
    });
    var a = document.getElementById("test");
    console.log(documents[0]);
    var filteredDocuments = documents.filter(docu => {
      return docu
        .data()
        .region.toLowerCase()
        .includes(user.toLowerCase());
    });
    filteredDocuments.sort((a, b) => {
      return b.data().occurrence - a.data().occurrence;
    });
    console.log(filteredDocuments[0]);
    a.innerHTML = "";
    filteredDocuments.forEach(data => {
      var li = document.createElement("a");
      li.className = "list-group-item list-group-item-action";
      li.innerHTML = `<h1>${data.data().occurrence}</h1>`;
      li.href = "" + data.id;
      a.appendChild(li);
    });
  });
