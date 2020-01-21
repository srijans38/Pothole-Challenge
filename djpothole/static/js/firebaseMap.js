
//firebase
var fdb=db.collection("reports");
fdb.where("status","in",['Reported','Working'])
.onSnapshot(querySnapshot => {
const documents = [];
querySnapshot.forEach(doc => {
  const d = doc;
  documents.push(d);
});
var filteredDocuments = documents.filter(docu => {
  return docu
    .data()
    .region.toLowerCase()
    .includes(user.toLowerCase());
});
filteredDocuments.sort((a, b) => {
  return b.data().occurrence - a.data().occurrence;
});

var mymap = L.map('mapid').setView([filteredDocuments[0].data().location[0], filteredDocuments[0].data().location[1]], 13);
L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}', {
    attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
    maxZoom: 18,
    id: 'mapbox.dark',
    accessToken: 'pk.eyJ1Ijoic3JpamFuczM4IiwiYSI6ImNqemN3cHRodzAyb2ozZG94YXZwN3VkMWYifQ.pszoH4JN8jktAkXtDl40wQ'
}).addTo(mymap);


const lat=filteredDocuments.map((doc)=>{
    return doc.data().location[0]
})
const long=filteredDocuments.map((doc)=>{
    return doc.data().location[1]
})
for(i=0;i<lat.length;i++){
   var marker = L.marker([lat[i],long[i]], {icon : potholeMarker}).addTo(mymap);
}
});
