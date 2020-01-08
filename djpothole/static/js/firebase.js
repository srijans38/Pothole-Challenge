fdb.where("status", "in", ["Reported", "Working"]).onSnapshot(querySnapshot => {
  const documents = [];
  querySnapshot.forEach(doc => {
    const d = doc;
    documents.push(d);
  });
  var a = document.getElementById("test");
  var t = document.getElementById("pending");
  var filteredDocuments = documents.filter(docu => {
    return docu
      .data()
      .region.toLowerCase()
      .includes(user.toLowerCase());
  });
  filteredDocuments.sort((a, b) => {
    return b.data().occurrence - a.data().occurrence;
  });
  t.innerText = "";
  t.innerText = `${filteredDocuments.length}`;
  a.innerHTML = "";
  chart.data.datasets[0].data[1] = filteredDocuments.length.toString();
  chart.update();
  filteredDocuments.forEach(data => {
    var li = document.createElement("a");
    li.className = "list-group-item list-group-item-action";
    li.innerHTML = `<h1>${data.data().occurrence}</h1>`;
    li.href = "" + data.id;
    a.appendChild(li);
  });
});
fdb = db.collection("reports");
fdb.where("status", "in", ["Completed"]).onSnapshot(querySnapshot => {
  const completedDocuments = [];
  querySnapshot.forEach(doc => {
    const d = doc;
    completedDocuments.push(d);
  });
  var b = document.getElementById("completed");
  var filteredCompletedDocuments = completedDocuments.filter(docu => {
    return docu
      .data()
      .region.toLowerCase()
      .includes(user.toLowerCase());
  });
  b.innerText = "";
  b.innerText = `${filteredCompletedDocuments.length}`;
  chart.data.datasets[0].data[0] = filteredCompletedDocuments.length.toString();
  chart.update();
});

fdb = db.collection("reports");
fdb.onSnapshot(querySnapshot => {
  const allDocuments = [];
  querySnapshot.forEach(doc => {
    const d = doc;
    allDocuments.push(d);
  });
  var c = document.getElementById("total");
  var filteredAllDocuments = allDocuments.filter(docu => {
    return docu
      .data()
      .region.toLowerCase()
      .includes(user.toLowerCase());
  });
  c.innerText = "";
  c.innerText = `${filteredAllDocuments.length}`;
});
