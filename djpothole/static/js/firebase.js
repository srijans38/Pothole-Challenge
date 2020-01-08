//"{&quot;type&quot;:&quot;doughnut&quot;,
//  &quot;data&quot;:{&quot;labels&quot;:[&quot;resolved&quot;,&quot;pending&quot;],&quot;datasets&quot;:[{&quot;label&quot;:&quot;&quot;,&quot;backgroundColor&quot;:[&quot;#1cc88a&quot;,&quot;#f6c23e&quot;],&quot;borderColor&quot;:[&quot;#ffffff&quot;,&quot;#ffffff&quot;],&quot;data&quot;:[&quot;50&quot;,&quot;30&quot;]}]},&quot;options&quot;:{&quot;maintainAspectRatio&quot;:false,&quot;legend&quot;:{&quot;display&quot;:false},&quot;title&quot;:{}}}

fdb=db.collection("reports");
var chartdata = {"type":"doughnut","data":{"labels":["resolved","pending"],"datasets":[{"label":"","backgroundColor":["#1cc88a","#f6c23e"],"borderColor":["#ffffff","#ffffff"],"data":["50","30"]}]},"options":{"maintainAspectRatio":false,"legend":{"display":false},"title":{}}}
var chart = document.getElementById('chartcanvas');

fdb.where("status","in",['Reported','Working'])
  .onSnapshot(querySnapshot => {
    const documents = [];
    querySnapshot.forEach(doc => {
      const d = doc;
      documents.push(d);
    });
    var a = document.getElementById("test");
    var t = document.getElementById("pending")
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
    chartdata.data.datasets[0].data[0] = filteredDocuments.length.toString();
    console.log(chartdata.data.datasets[0].data);
    var str = JSON.stringify(chartdata);
    console.log(str);
    chart.setAttribute("data-bs-chart", str);
    a.innerHTML = "";
    filteredDocuments.forEach(data => {
      var li = document.createElement("a");
      li.className = "list-group-item list-group-item-action";
      li.innerHTML = `<h1>${data.data().occurrence}</h1>`;
      li.href = "" + data.id;
      a.appendChild(li);
    })
  })
  fdb=db.collection("reports");
  fdb.where("status","in",['Completed'])
    .onSnapshot(querySnapshot => {
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
      chartdata.data.datasets[0].data[1] = filteredCompletedDocuments.length.toString();
      chart.setAttribute("data-bs-chart", JSON.stringify(chartdata));
      console.log(chart.attributes[1])
      })

      fdb=db.collection("reports");
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
          })
