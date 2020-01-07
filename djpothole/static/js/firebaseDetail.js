var firebaseConfig ={
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
var storage = firebase.app().storage("gs://sih-test-8c936.appspot.com");
var pathReference = storage.ref();
db.collection("reports")
  .onSnapshot(querySnapshot => {
    const documents = [];
    querySnapshot.forEach(doc => {
      const d = doc;
      documents.push(d);
    });
    currentReport = documents.filter(docu => {
      return docu.id.includes(id);
    });
    if (currentReport.length) {
    // var image = document.getElementById("image");
    var landmark = document.getElementById("landmark");
    var location = document.getElementById("location");
    var occurrence = document.getElementById("occurrence");
    var region = document.getElementById("region");
    var status = document.getElementById("status");
    var timestamp = document.getElementById("timestamp");
    var uid = document.getElementById("uid");
    var landmarkchild = document.createElement("p");
    var locationchild = document.createElement("p");
    var occurrencechild = document.createElement("p");
    var regionchild = document.createElement("p");
    var statuschild = document.createElement("p");
    var timestampchild = document.createElement("p");
    var uidchild = document.createElement("p");
    var pathReference = storage.ref(currentReport[0].data().image);
    storageRef.child(currentReport[0].data().image).getDownloadURL().then(function(url) {
    var img = document.getElementById('image');
    img.src = url;})
    landmarkchild.innerHTML = currentReport[0].data().landmark;
    landmark.appendChild(landmarkchild);
    locationchild.innerHTML = currentReport[0].data().location.latitude+"  "+currentReport[0].data().location.longitude;
    location.appendChild(locationchild);
    occurrencechild.innerHTML = currentReport[0].data().occurrence;
    occurrence.appendChild(occurrencechild);
    regionchild.innerHTML = currentReport[0].data().region;
    region.appendChild(regionchild);
    statuschild.innerHTML = currentReport[0].data().status;
    status.appendChild(statuschild);
    timestampchild.innerHTML = currentReport[0].data().timestamp.toDate().toString();
    timestamp.appendChild(timestampchild);
    uidchild.innerHTML = currentReport[0].data().uid;
    uid.appendChild(uidchild);
    } else {
      window.location.href = "error/pagenotfound";
    }
  });
