import axios from 'axios';

const getLocation = (input, btn) => {
  const API = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=';
  const loadingClasses = ['Btn', 'Btn--loading'];
  const loadingOff = () => {
      input.disabled = false;
      loadingClasses.forEach(css => {
      btn.classList.remove(css);
    });
  };

  input.disabled = true;
  loadingClasses.forEach(css => {
    btn.classList.add(css);
  });

  const success = position => {

    const coords = { lat: position.coords.latitude, lng: position.coords.longitude };

    axios.get(`${API}${coords.lat},${coords.lng}&key=AIzaSyBEbiQIC9QIzW-LmIHqy9qq_-dgURfx_4Q`)
      .then(response => {

        console.log(response);

        loadingOff();

        if (response.data.results){
          input.value = response.data.results[0].formatted_address;
        }
      })
      .catch(error => {
        // handle error
        loadingOff();
        alert('error');
      });
  };

  const error = () => null;
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(success, error);
  } else {
    console.warn('browser doesnt\' support geolocaiton API');
  }
};

export { getLocation };
