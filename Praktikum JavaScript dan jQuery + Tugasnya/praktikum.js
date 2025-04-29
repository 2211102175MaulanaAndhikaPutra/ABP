//Maulana Andhika Putra_2211102175_IF10-02
//Deklarasi Variabel
var nama = "Febrilia"; // Global scope
let umur = 21;          // Block scope
const kota = "Purwokerto"; // Tidak dapat diubah

//percabangan
if (umur > 18) {
    console.log("Dewasa");
  } else {
    console.log("Anak-anak");
  }

//Perulangan
for (let i = 0; i < 5; i++) {
    console.log(i);
  }

  let j = 0;
while (j < 5) {
  console.log(j);
  j++;
}

//Fungsi
function sapa(nama) {
    return "Halo, " + nama;
  }
   
  console.log(sapa("Febrilia"));

  const mahasiswa = {
    nama: "Febrilia",
    umur: 21,
    sapa: function() {
      return "Halo, saya " + this.nama;
    }
  };
   
  console.log(mahasiswa.sapa());

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

$(document).ready(function() {
    $("#judul").text("Belajar jQuery");
    $(".paragraf").css("color", "blue");
  });

  $(document).ready(function() {
    $("#tombol").click(function() {
      alert("Tombol diklik!");
    });
  });

  $("#kotak").fadeOut(); // Menghilangkan elemen dengan efek fade out
  $("#kotak").fadeIn();  // Menampilkan elemen dengan efek fade in

  $("#toggleButton").click(function() {
    $("#panel").slideToggle();
  });

  $("#fadeButton").click(function() {
    $("#box").fadeToggle();
  });

  $.get("https://jsonplaceholder.typicode.com/posts", function(data) {
    console.log(data);
  });


  async function getData() {
    let response = await fetch("https://jsonplaceholder.typicode.com/posts");
    let data = await response.json();
    console.log(data);
  }
   
  getData();


  async function kirimData() {
    let response = await fetch("https://jsonplaceholder.typicode.com/posts", {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        title: "Belajar JavaScript",
        body: "Ini contoh pengiriman data",
        userId: 1
      })
    });
   
    let data = await response.json();
    console.log(data);
  }
   
  kirimData();