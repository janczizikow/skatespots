import GMaps from 'gmaps/gmaps.js';
import mapStyle from '../components/mapStyle';
import '../components/throttle';

{
  const mapElement = document.getElementById('map');

  if (mapElement) {
    // Set height of the map automatically based on window.innerHeight
    // Applies only to map on spots#index
    let prevInnerHeight = window.innerHeight;
    if (!document.querySelector('.js-no-height')) {
      const styleMap = () => {
        console.log('styleMap triggered');
        mapElement.style.height = `${window.innerHeight - 144}px`;
      }

      window.addEventListener("optimizedResize", e => {
        if (prevInnerHeight !== window.innerHeight) {
          styleMap();
        }
      });
      styleMap();
    }

    const map = new GMaps({ el: '#map', lat: 0, lng: 0 });
    const markers = JSON.parse(mapElement.dataset.markers);
    map.addStyle({
      styles: mapStyle,
      mapTypeId: 'map_style'
    });
    map.setStyle('map_style');
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
