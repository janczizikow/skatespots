import 'bootstrap';
import 'lazysizes';
import "lazysizes/plugins/blur-up/ls.blur-up";
import autocomplete from '../components/autocomplete';
// import fadeOutAlerts from '../components/fadeOutAlerts';
// fadeOutAlerts();

$(function () {
  $('[data-toggle="tooltip"]').tooltip();
  const searchBar = document.querySelector('.js-nav-search');
  const homeSearch = document.querySelector('.js-home-search');
  autocomplete(searchBar);
  autocomplete(homeSearch);
});
