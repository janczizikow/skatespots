import 'velocity-animate/velocity.js';

const fadeOutAlerts = () => {
  const alertToFadeOut = document.querySelector('.js-fade-out-alert');
  if (alertToFadeOut) {
    setTimeout(() => {
      Velocity(alertToFadeOut, {
        opacity: 0,
        duration: 450,
        easing: "ease-out"
      }, {
        complete: function() {
          alertToFadeOut.remove();
        }
      });
    }, 2000)
  }
}

export default fadeOutAlerts;
