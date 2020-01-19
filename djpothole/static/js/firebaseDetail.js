var storage = firebase.storage();
db.collection("reports").onSnapshot(querySnapshot => {
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
    var img = document.getElementById("image");
    var pathReference = storage.ref(currentReport[0].data().image);
    pathReference.getDownloadURL().then(function(url) {
      img.src = url;
    });
    img.alt = "Image Not Found.";
    landmark.innerHTML = currentReport[0].data().landmark;
    location.innerHTML =
      currentReport[0].data().location.latitude +
      "  " +
      currentReport[0].data().location.longitude;
    occurrence.innerHTML = currentReport[0].data().occurrence;
    region.innerHTML = currentReport[0].data().region;
    status.innerHTML = currentReport[0].data().status;
    timestamp.innerHTML = currentReport[0]
      .data()
      .timestamp.toDate()
      .toString();
    uid.innerHTML = currentReport[0].data().uid;
  } else {
    window.location.href = "error/pagenotfound";
  }
});
