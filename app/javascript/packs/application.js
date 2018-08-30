import 'bootstrap';
import 'lazysizes';
import "lazysizes/plugins/blur-up/ls.blur-up";
import autocomplete from '../components/autocomplete';
// import fadeOutAlerts from '../components/fadeOutAlerts';


$(function () {
  $('[data-toggle="tooltip"]').tooltip();
  autocomplete(document.querySelector('.js-nav-search'));
  autocomplete(document.querySelector('.js-home-search'));
  // fadeOutAlerts();
});
