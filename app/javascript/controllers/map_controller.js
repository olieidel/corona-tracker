import { Controller } from "stimulus";
import mapboxgl from 'mapbox-gl';

export default class extends Controller {
  static targets = ['map'];

  connect() {
    // this.renderMap();
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
            'circle-stroke-color': 'hsl(0, 0%, 100%)',
            'circle-stroke-width': 0,
            'circle-opacity': 1,
            'circle-stroke-color': 'white',
            'circle-stroke-width': 1,
            'circle-stroke-opacity': 1
          }
        },
        'waterway-label'
      );

      // map.addLayer({
      //   id: 'clusters',
      //   type: 'circle',
      //   source: 'earthquakes',
      //   filter: ['has', 'point_count'],
      //   paint: {
      //     // Use step expressions (https:docs.mapbox.com/mapbox-gl-js/style-spec/#expressions-step)
      //     // with three steps to implement three types of circles:
      //     //   * Blue, 20px circles when point count is less than 100
      //     //   * Yellow, 30px circles when point count is between 100 and 750
      //     //   * Pink, 40px circles when point count is greater than or equal to 750
      //     'circle-color': [
      //       'step',
      //       ['get', 'point_count'],
      //       '#51bbd6',
      //       100,
      //       '#f1f075',
      //       750,
      //       '#f28cb1'
      //     ],
      //     'circle-radius': [
      //       'step',
      //       ['get', 'point_count'],
      //       20,
      //       100,
      //       30,
      //       750,
      //       40
      //     ]
      //   }
      // });

      // map.addLayer({
      //   id: 'cluster-count',
      //   type: 'symbol',
      //   source: 'earthquakes',
      //   filter: ['has', 'point_count'],
      //   layout: {
      //     'text-field': '{point_count_abbreviated}',
      //     'text-font': ['DIN Offc Pro Medium', 'Arial Unicode MS Bold'],
      //     'text-size': 12
      //   }
      // });

      // map.addLayer({
      //   id: 'unclustered-point',
      //   type: 'circle',
      //   source: 'earthquakes',
      //   filter: ['!', ['has', 'point_count']],
      //   paint: {
      //     'circle-color': '#11b4da',
      //     'circle-radius': 8,
      //     'circle-stroke-width': 1,
      //     'circle-stroke-color': '#fff'
      //   }
      // });

      // // inspect a cluster on click
      // map.on('click', 'clusters', function(e) {
      //   var features = map.queryRenderedFeatures(e.point, {
      //     layers: ['clusters']
      //   });
      //   var clusterId = features[0].properties.cluster_id;
      //   map.getSource('earthquakes').getClusterExpansionZoom(
      //     clusterId,
      //     function(err, zoom) {
      //       if (err) return;

      //       map.easeTo({
      //         center: features[0].geometry.coordinates,
      //         zoom: zoom
      //       });
      //     }
      //   );
      // });

      // // When a click event occurs on a feature in
      // // the unclustered-point layer, open a popup at
      // // the location of the feature, with
      // // description HTML from its properties.
      map.on('click', 'earthquakes-point', function(e) {

        var coordinates = e.features[0].geometry.coordinates.slice();
        var healthyStr = e.features[0].properties.healthy ? 'Gesunde Person' : 'Kranke Person';
        var fever = e.features[0].properties.fever ? 'ja' : 'nein';
        var cough = e.features[0].properties.cough ? 'ja' : 'nein';
        var tested = e.features[0].properties.tested ? 'ja' : 'nein';

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
<li>Fieber: ${fever}</li>
<li>Husten: ${cough}</li>
<li>Getestet: ${tested}</li>
</ul>
<p class="mt-2 text-gray-600 text-xs tracking-wide">Ort auf 2km anonymisiert</p>
</aside>`)
          .addTo(map);
      });

      // map.on('mouseenter', 'clusters', function() {
      //   map.getCanvas().style.cursor = 'pointer';
      // });
      // map.on('mouseleave', 'clusters', function() {
      //   map.getCanvas().style.cursor = '';
      // });
      map.on('mouseenter', 'earthquakes-point', function() {
        map.getCanvas().style.cursor = 'pointer';
      });
      map.on('mouseleave', 'earthquakes-point', function() {
        map.getCanvas().style.cursor = '';
      });
    });
  }
}
