import axios from 'axios';

const getLocation = (input, posOutput) => {
  const API = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=';

  const success = position => {

    const coords = { lat: position.coords.latitude, lng: position.coords.longitude };
    const coordsToString = `${coords.lat},${coords.lng}`;
    posOutput.value = coordsToString;

    axios.get(`${API}${coords.lat},${coords.lng}&key=${process.env.GOOGLE_API_CLIENT_GEO}`)
      .then(response => {
        // handle success
        console.log(response);
        if (response.data.results){
          input.value = response.data.results[0].formatted_address;
        }
      })
      .catch(error => {
        // handle error
        console.log(error);
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
