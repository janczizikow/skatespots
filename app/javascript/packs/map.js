import GMaps from 'gmaps/gmaps.js';
// import throttle from 'lodash.throttle';
import '../components/throttle';
{
  const mapElement = document.getElementById('map');

  if (mapElement) {
    // Set height of the map automatically based on window.innerHeight
    // FIXME: Could improve the way the map is styled on resize: e.g. Only when height changed
    if (!document.querySelector('.js-no-height')) {
      const styleMap = () => {
        mapElement.style.height = `${window.innerHeight - 144}px`;
      }
      mapElement.parentNode.style.backgroundColor = '#fff';
      window.addEventListener("optimizedResize", styleMap);
      styleMap();
    }

    const map = new GMaps({ el: '#map', lat: 0, lng: 0 });
    const markers = JSON.parse(mapElement.dataset.markers);
    map.addMarkers(markers);

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
