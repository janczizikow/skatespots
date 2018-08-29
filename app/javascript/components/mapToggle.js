import "./throttle";

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
    if (toggle.checked && window.innerWidth > 992) {
      map.style.display = 'block';
      toggleCardsClass();
    } else {
      map.style.display = 'none';
      toggleCardsClass();
    }
  };

  if (toggle && map && cards) {
    toggle.addEventListener("change", toggleMap);
    // window.addEventListener("optimizedResize", toggleMap);
  }
};

export default mapToggle;
