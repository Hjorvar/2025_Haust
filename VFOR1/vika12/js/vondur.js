// Gögn á "global scope"
var initialPictures = [
  {
    title: "Sólsetur",
    url: "https://picsum.photos/id/1018/200",
  },
  {
    title: "Fjöll",
    url: "https://picsum.photos/id/1015/200",
  },
];

// Fall til að hlaða inn fyrstu myndum
function loadInitialPictures() {
  var gallery = document.getElementById("gallery");
  var output = ""; // Byggja upp einn stóran streng

  for (var i = 0; i < initialPictures.length; i++) {
    output += '<div class="gallery-item">';
    output += '<img src="' + initialPictures[i].url + '">'; // Enginn alt texti!
    output += "<p>" + initialPictures[i].title + "</p>";
    output += "</div>";
  }
  gallery.innerHTML = output; // Nota innerHTML til að bæta öllu við
}

// Fall kallað beint úr HTML (onclick)
function addPicture() {
  var gallery = document.getElementById("gallery");
  var titleInput = document.getElementById("img-title");
  var urlInput = document.getElementById("img-url");

  if (titleInput.value == "" || urlInput.value == "") {
    alert("Vinsamlegast fylltu út bæði reitina!");
    return;
  }

  // Búa til nýtt element með því að smíða streng
  var newPicHTML = '<div class="gallery-item">';
  newPicHTML += '<img src="' + urlInput.value + '">'; // Enn enginn alt texti
  newPicHTML += "<p>" + titleInput.value + "</p>";
  newPicHTML += "</div>";

  gallery.innerHTML += newPicHTML; // Bæta við með innerHTML

  // Hreinsa reiti
  titleInput.value = "";
  urlInput.value = "";
}

// Keyra fallið þegar síðan hleðst
loadInitialPictures();