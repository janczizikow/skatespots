import GMaps from 'gmaps/gmaps.js';

{
  const mapElement = document.getElementById('map');

  if (mapElement) {
    if (!document.querySelector('.js-no-height')) {
      mapElement.style.height = `${window.innerHeight - 94}px`;
    }

    const map = new GMaps({ el: '#map', lat: 0, lng: 0 });
    const markers = JSON.parse(mapElement.dataset.markers);
    map.addMarkers(markers);
    // markers.forEach(place => {
    //   map.addMarker({

    //     ...place,
    //   });
    // })

    if (markers.length === 0) {
      map.setZoom(2);

    } else if (markers.length === 1) {
      map.setCenter(markers[0].lat, markers[0].lng);
      map.setZoom(14);
    } else {
      map.fitLatLngBounds(markers);
    }
  }
}
