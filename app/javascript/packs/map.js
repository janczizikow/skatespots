import GMaps from 'gmaps/gmaps.js';

{
  const mapElement = document.getElementById('map');

  if (mapElement) {

    mapElement.style.height = `${window.innerHeight - 94}px`;

    const map = new GMaps({ el: '#map', lat: 0, lng: 0 });
    const markers = JSON.parse(mapElement.dataset.markers);
    console.log(markers[0]);
    markers.forEach(place => {
      map.addMarker({

        ...place,
        infoWindow: {
          content: `
            <a href="/spots/${place.id}" class="map-marker-info" style="color: #484848;text-decoration: none;">
              <div style="overflow:hidden;">
                <div role="img" style="transform: scale(2);width: 100%;height: 150px; background-image: url(${place.photo.url});background-repeat: no-repeat;background-size: cover;background-position: 50% 50%;"></div>
              </div>
              <h4 style="margin-top: 0;margin-bottom: 0;padding-top: 0;font-size: 14px;font-weight: 700;">
                <div style="margin: 8px 0;">
                  ${place.title}
                </div>
              </h4>
              <div class="d-flex">
                <i class="fas fa-star text-warning"></i>
                <i class="fas fa-star text-warning"></i>
                <i class="fas fa-star text-warning"></i>
                <i class="fas fa-star text-warning"></i>
                <i class="fas fa-star text-warning"></i>
              </div>
              <div style="margin:8px 0;font-size:11px;">
                  ${place.address}
              </div>
            </a>
          `,
          maxWidth: 280
        }
      });
    })

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
