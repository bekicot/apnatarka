# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/.

markerHTML = (marker) ->
  '<div class="marker-tooltip">' + marker + '</div>'

$.initializeMap = (location) ->
  map = new (google.maps.Map)(document.getElementById('map-canvas'),
    zoom: 16
    center: new (google.maps.LatLng)(location.lat, location.lng)
    mapTypeId: google.maps.MapTypeId.ROADMAP)
  infowindow = new (google.maps.InfoWindow)
  newMarker = new (google.maps.Marker)(
    position: new (google.maps.LatLng)(location.lat, location.lng)
    map: map
    title: location.address
    icon: 'images/map-marker.png')
  google.maps.event.addListener newMarker, 'click', do (newMarker) ->
    ->
      infowindow.setContent markerHTML(location.address)
      infowindow.open map, newMarker
      $('#map-canvas').css 'pointer-events', 'none'
      $('#map-canvas').find('img[draggable="false"]').css 'pointer-events', 'auto'
      $('img[draggable="false"]').on 'click', ->
        $('#map-canvas').css 'pointer-events', 'auto'
        return
      return
