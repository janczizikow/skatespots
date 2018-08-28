import "../components/jquery.fileuploader";
import "@fancyapps/fancybox/dist/jquery.fancybox.css";
import "@fancyapps/fancybox/dist/jquery.fancybox.js";
import "jquery-bar-rating";
import "jquery-bar-rating/dist/themes/fontawesome-stars-o.css";

import { getLocation } from '../components/getLocation';

$(document).ready(function() {

  $('input[name="spots_photo[photo]"]').fileuploader({
    inputNameBrackets: false,
  });

  const $stars = $('.js-rating');
  if ($stars) {
    $stars.barrating({theme: 'fontawesome-stars-o'});
  }
  const input = document.querySelector('.js-input');
  const getLocationTrigger = document.querySelector('.js-get-location');
  const cordsInput = document.querySelector('input[name=saddr]');


  if (input && getLocationTrigger && cordsInput) {
    getLocationTrigger.addEventListener('click', e => {
      e.preventDefault();
      getLocation(input, cordsInput);
    });

  }
});
