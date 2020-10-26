import mapboxgl from 'mapbox-gl';

const initMapbox = () => {
  const mapElement = document.getElementById('map');

  if (mapElement) { // only build a map if there's a div#map to inject into
    const latlon_points = JSON.parse(mapElement.dataset.points);
    const points = []
    latlon_points.forEach((point) => {
      points.push([point.lng, point.lat])
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
          'line-join': 'miter',
          'line-cap': 'square'
        },
        'paint': {
          'line-color': '#d11204',
          'line-width': 3
        }
      });
      // fit draw in zoom
      const bounds = points.reduce(function (bounds, coord) {
        return bounds.extend(coord);
        }, new mapboxgl.LngLatBounds(points[0], points[0]));
         
      map.fitBounds(bounds, {
        padding: 20
      });
    });
  }
};

export { initMapbox };