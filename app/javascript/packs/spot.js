import "../components/jquery.fileuploader";
import "@fancyapps/fancybox/dist/jquery.fancybox.css";
import "@fancyapps/fancybox/dist/jquery.fancybox.js";

$(document).ready(function() {
  $('input[name="spots_photo[photo]"]').fileuploader({
    inputNameBrackets: false,
  });
});
