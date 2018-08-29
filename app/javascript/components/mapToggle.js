const mapToggle = () => {
  const toggle = document.querySelector(".js-map-toggle");
  const map = document.querySelector(".js-map");
  const cardsNode = document.querySelector(".js-spots-cards");
  let cards = null;

  if (cardsNode) {
    cards = document.querySelector(".js-spots-cards").children;
  }

  const toggleCardsClass = () => Array.from(cards).forEach(card => card.classList.toggle("col-lg-4"));
  const toggleMap = e => {
    if (e.currentTarget.checked) {
      map.classList.add("Map--show");
      toggleCardsClass();
    } else {
      map.classList.remove("Map--show");
      toggleCardsClass();
    }
  };


  if (toggle && map && cards) {
    toggle.addEventListener("change", toggleMap);
  }
};

export default mapToggle;
