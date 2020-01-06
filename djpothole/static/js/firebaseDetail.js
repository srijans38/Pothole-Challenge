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
    currentReport = documents.filter(docu => {
      return docu.id.includes(id);
    });
    if (currentReport.length) {
      var image = document.getElementById("image");
      var landmark = document.getElementById("landmark");
      var location = document.getElementById("location");
      var occurrence = document.getElementById("occurrence");
      var region = document.getElementById("region");
      var status = document.getElementById("status");
      var timestamp = document.getElementById("timestamp");
      var uid = document.getElementById("uid");
      var imagechild = document.createElement("p");
      var landmarkchild = document.createElement("p");
      var locationchild = document.createElement("p");
      var occurrencechild = document.createElement("p");
      var regionchild = document.createElement("p");
      var statuschild = document.createElement("p");
      var timestampchild = document.createElement("p");
      var uidchild = document.createElement("p");
      imagechild.innerHTML = currentReport[0].data().image;
      image.appendChild(imagechild);
      landmarkchild.innerHTML = currentReport[0].data().landmark;
      landmark.appendChild(landmarkchild);
      locationchild.innerHTML = currentReport[0].data().location;
      location.appendChild(locationchild);
      occurrencechild.innerHTML = currentReport[0].data().occurrence;
      occurrence.appendChild(occurrencechild);
      regionchild.innerHTML = currentReport[0].data().region;
      region.appendChild(regionchild);
      statuschild.innerHTML = currentReport[0].data().status;
      status.appendChild(statuschild);
      timestampchild.innerHTML = currentReport[0].data().timestamp;
      timestamp.appendChild(timestampchild);
      uidchild.innerHTML = currentReport[0].data().uid;
      uid.appendChild(uidchild);
    } else {
      window.location.href = "error/pagenotfound";
    }
  });
