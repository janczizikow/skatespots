import 'bootstrap';
import 'lazysizes';
import "lazysizes/plugins/blur-up/ls.blur-up";

import mapToggle from '../components/mapToggle';

$(function () {
  $('[data-toggle="tooltip"]').tooltip();
  mapToggle();
});
