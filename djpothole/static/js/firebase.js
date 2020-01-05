
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
  var db=firebase.firestore();
  db.collection("reports").onSnapshot((querySnapshot) => {
    const reportArray=[]
    querySnapshot.forEach((doc) => {
        const data=doc.data();
        reportArray.push(data);
    });
    var a=document.getElementById('test')
     var filteredArray=reportArray.filter(reports=>{
        return(reports.region.toLowerCase().includes(users.toLowerCase()))

     })
    filteredArray.sort((a,b)=>{
        return a.Occurence-b.Occurence
    })

    a.innerHTML= "";
    filteredArray.forEach((data) => {
        a.innerHTML += `<h1>${data.Occurence}</h1>`
    })
});


