  // API key for http://bostongreen.org. Register at
  // http://bingmapsportal.com/
  var apiKey = "AvkQGCHkDMqlU6OsF4bn6TUgoMmlTrwYa5ZWvXSWaYGr5QzedJWO87_HDOG-kEij";
  // initialize map when page ready
  var map;
  var gg = new OpenLayers.Projection("EPSG:4326");
  var sm = new OpenLayers.Projection("EPSG:900913");
    
    $.extend({
      getUrlVars: function(){
        var vars = [], hash;
        var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
        for(var i = 0; i < hashes.length; i++)
        {
          hash = hashes[i].split('=');
          vars.push(hash[0]);
          vars[hash[0]] = hash[1];
        }
        return vars;
      },
      getUrlVar: function(name){
        return $.getUrlVars()[name];
      }
    });
  
  var init = function () {

  	var vector = new OpenLayers.Layer.Vector("My Location", {});

      var geolocate = new OpenLayers.Control.Geolocate({
          id: 'locate-control',
          geolocationOptions: {
              enableHighAccuracy: false,
              maximumAge: 0,
              timeout: 7000
          }
      });
      // create map
      map = new OpenLayers.Map({
          div: "map",
          theme: null,
          projection: sm,
  		    displayProjection: gg,
          units: "m",
          numZoomLevels: 18,
          maxResolution: 156543.0339,
          maxExtent: new OpenLayers.Bounds(
              -20037508.34, -20037508.34, 20037508.34, 20037508.34
          ),
          controls: [
              new OpenLayers.Control.Attribution(),
              new OpenLayers.Control.TouchNavigation({
                  dragPanOptions: {
                      interval: 100,
                      enableKinetic: true
                  }
              }),
              geolocate
          ],
          layers: [
              new OpenLayers.Layer.Bing({
                  key: apiKey,
                  type: "Road",
                  // custom metadata parameter to request the new map style - only useful
                  // before May 1st, 2011
                  metadataParams: {
                      mapVersion: "v1"
                  },
                  name: "Bing Road",
                  transitionEffect: 'resize'
              }),
/*
              new OpenLayers.Layer.Bing({
                  key: apiKey,
                  type: "Aerial",
                  name: "Bing Aerial",
                  transitionEffect: 'resize'
              }),
              new OpenLayers.Layer.Bing({
                  key: apiKey,
                  type: "AerialWithLabels",
                  name: "Bing Aerial + Labels",
                  transitionEffect: 'resize'
              }),
			new OpenLayers.Layer.OSM("OpenStreetMap", null, {
                transitionEffect: 'resize'
            }),*/
  			vector
          ],
          center: new OpenLayers.LonLat(0, 0),
          zoom: 1
      });

      var style = {
          fillOpacity: 0.1,
          fillColor: '#000',
          strokeColor: '#f00',
          strokeOpacity: 0.6
      };
      geolocate.events.register("locationupdated",this,function(e) {

  	  if(!e) { return };

  		lat = e.position.coords.latitude;
  		lng = e.position.coords.longitude;		
  		accuracy = e.position.coords.accuracy;

  		if(lat && lng) {
  	    window.location.href = '/map?lat=' + lat + '&lng=' + lng + '&accuracy=' + accuracy;		  
  		}

          vector.removeAllFeatures();
          vector.addFeatures([
              new OpenLayers.Feature.Vector(
                  e.point,
                  {},
                  {
                      graphicName: 'cross',
                      strokeColor: '#f00',
                      strokeWidth: 2,
                      fillOpacity: 0,
                      pointRadius: 10
                  }
              ),
              new OpenLayers.Feature.Vector(
                  OpenLayers.Geometry.Polygon.createRegularPolygon(
                      new OpenLayers.Geometry.Point(e.point.x, e.point.y),
                      e.position.coords.accuracy/2,
                      50,
                      0
                  ),
                  {},
                  style
              )
          ]);
          map.zoomToExtent(vector.getDataExtent());
      });
  };  