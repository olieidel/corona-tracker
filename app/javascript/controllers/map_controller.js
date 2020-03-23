import { Controller } from "stimulus";
import mapboxgl from 'mapbox-gl';


export default class extends Controller {
  static targets = ['map'];

  connect() {
    this.renderMap();
  }

  renderMap() {
    mapboxgl.accessToken = 'pk.eyJ1Ijoib2xpZWlkZWwiLCJhIjoiY2s3Z2J1bG1lMDlidjNtbzI1MGVlM3czOCJ9.fAXDKOEHx_USnDXah1iENw';
    var map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/dark-v10',
      center: [10.4515, 51.1657], // center of Germany (lat, lon)
      zoom: 5
    });

    map.on('load', function() {
      // Add a new source from our GeoJSON data and
      // set the 'cluster' option to true. GL-JS will
      // add the point_count property to your source data.
      map.addSource('questionnaires', {
        type: 'geojson',
        data: '/questionnaires.json',
        // cluster: true,
        // clusterMaxZoom: 14, // Max zoom to cluster points on
        // clusterRadius: 50 // Radius of each cluster when clustering points (defaults to 50)
      });
      map.addSource('heatmap', {
        type: 'geojson',
        data: '/heatmap.json',
      });

      map.addLayer(
        {
          'id': 'heatmap-percentage-sick',
          'type': 'heatmap',
          'source': 'heatmap',
          'paint': {
            'heatmap-weight': [
              'interpolate',
              ['linear'],
              [
                'get',
                'percentage_sick'
              ],
              0,
              0,
              1,
              1
            ],
            'heatmap-intensity': [
              'interpolate',
              ['linear'],
              ['zoom'],
              0,
              0,
              22,
              1
            ],
            'heatmap-color': [
              'interpolate',
              ['linear'],
              ['heatmap-density'],
              0,
              'rgba(0, 0, 255, 0)',
              0.1,
              'hsl(120, 100%, 50%)',
              0.3,
              'hsl(60, 100%, 50%)',
              1,
              'red'
            ],
            'heatmap-radius': [
              'interpolate',
              ['linear'],
              ['zoom'],
              0,
              1,
              22,
              200
            ],
            'heatmap-opacity': [
              'interpolate',
              ['linear'],
              ['zoom'],
              0,
              0.65,
              13,
              0.65,
              14,
              0
            ],
          }
        },
        'waterway-label'
      );

      map.addLayer(
        {
          'id': 'questionnaire-points',
          'type': 'circle',
          'source': 'questionnaires',
          'paint': {
            'circle-radius': [
              'interpolate',
              ['linear'],
              ['zoom'],
              4,
              2,
              22,
              20
            ],
            'circle-color': [
              'case',
              [
                '==',
                ['get', 'healthy'],
                true
              ],
              'hsl(120, 100%, 50%)',
              [
                '==',
                ['get', 'healthy'],
                false
              ],
              'hsl(0, 100%, 50%)',
              'hsla(0, 0%, 100%, 0)'
            ],
            'circle-stroke-color': 'white',
            // tested people have stroke width 2, otherwise 0
            'circle-stroke-width': [
              "case",
              [
                "==",
                ["get", "tested"],
                true
              ],
              2,
              0
            ],
            'circle-stroke-opacity': 1
          }
        },
        'waterway-label'
      );

      map.on('click', 'questionnaire-points', function(e) {

        var coordinates = e.features[0].geometry.coordinates.slice();
        var healthyStr = e.features[0].properties.healthy ? 'Healthy Person' : 'Sick Person';
        var fever = e.features[0].properties.fever ? 'yes' : 'no';
        var cough = e.features[0].properties.cough ? 'yes' : 'no';
        var tested = e.features[0].properties.tested ? 'yes' : 'no';

        // Ensure that if the map is zoomed out such that
        // multiple copies of the feature are visible, the
        // popup appears over the copy being pointed to.
        while (Math.abs(e.lngLat.lng - coordinates[0]) > 180) {
          coordinates[0] += e.lngLat.lng > coordinates[0] ? 360 : -360;
        }

        new mapboxgl.Popup()
          .setLngLat(coordinates)
          .setHTML(`<aside class="leading-tight">
<h4 class="text-base text-black font-medium tracking-wider uppercase">${healthyStr}</h4>
<ul class="mt-1 text-sm text-gray-800">
<li>Fever: ${fever}</li>
<li>Cough: ${cough}</li>
<li>Tested: ${tested}</li>
</ul>
<p class="mt-2 text-gray-600 text-xs tracking-wide">Location anonymized within 2km</p>
</aside>`)
          .addTo(map);
      });

      map.on('mouseenter', 'questionnaire-points', function() {
        map.getCanvas().style.cursor = 'pointer';
      });
      map.on('mouseleave', 'questionnaire-points', function() {
        map.getCanvas().style.cursor = '';
      });
    });
  }
}
