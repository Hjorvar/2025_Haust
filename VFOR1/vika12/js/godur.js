const initialPictures = [
  {
    title: "Sólsetur",
    url: "https://picsum.photos/id/1018/400/250",
    description: "Fallegt sólsetur yfir fjöllum.",
  },
  {
    title: "Fjöll",
    url: "https://picsum.photos/id/1015/400/250",
    description: "Snævi þakin fjöll og stöðuvatn.",
  },
];

const galleryContainer = document.querySelector("#gallery-container");
const form = document.querySelector("#add-picture-form");

const createPictureCard = (picture) => {
  const card = document.createElement("div");
  card.className = "gallery-item";

  const img = document.createElement("img");
  img.src = picture.url;
  img.alt = picture.description || picture.title;

  const title = document.createElement("p");
  title.textContent = picture.title;

  card.appendChild(img);
  card.appendChild(title);
  return card;
};

const renderGallery = () => {
  galleryContainer.innerHTML = "";
  initialPictures.forEach((pic) => {
    const newCard = createPictureCard(pic);
    galleryContainer.appendChild(newCard);
  });
};

const handleSubmit = (event) => {
  event.preventDefault();

  const titleInput = event.currentTarget.elements["img-title"];
  const urlInput = event.currentTarget.elements["img-url"];

  if (titleInput.value.trim() === "" || urlInput.value.trim() === "") {
    alert("Vinsamlegast fylltu út bæði reitina!");
    return;
  }

  const newPicture = {
    title: titleInput.value,
    url: urlInput.value,
    description: `Ný mynd: ${titleInput.value}`,
  };

  const newCard = createPictureCard(newPicture);
  galleryContainer.appendChild(newCard);

  form.reset();
};

form.addEventListener("submit", handleSubmit);

renderGallery();