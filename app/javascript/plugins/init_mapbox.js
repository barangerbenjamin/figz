import mapboxgl from 'mapbox-gl';

const initMapbox = () => {
  const mapElement = document.getElementById('map');

  if (mapElement) { // only build a map if there's a div#map to inject into
    const markers = JSON.parse(mapElement.dataset.markers);
    const points = []
    markers.forEach((marker) => {
      points.push([marker.lng, marker.lat])
    })
    
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      center: [points[0][0], points[0][1]],
      style: 'mapbox://styles/mapbox/streets-v11',
      zoom: 12
    });
    
    map.on('load', function () {
      map.addSource('route', {
        'type': 'geojson',
        'data': {
          'type': 'Feature',
          'properties': {},
          'geometry': {
            'type': 'LineString',
            'coordinates': points
          }
        }
      });
      map.addLayer({
        'id': 'route',
        'type': 'line',
        'source': 'route',
        'layout': {
          'line-join': 'bevel',
          'line-cap': 'butt'
        },
        'paint': {
          'line-color': '#d11204',
          'line-width': 5
        }
      });
    });
  }
};

export { initMapbox };