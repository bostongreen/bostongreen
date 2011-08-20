function pageChange(name) {
  //$.mobile.changePage("neighborhoods/"+ name + "?filter="+ document.getElementById('filter').value);
  changeUrl = "/neighborhoods/" + name + "/"
  $.mobile.changePage({
    url: changeUrl,
    type: "get",
    data: {filter: $(".ui-page-active #filter").val()}
  })
}

// Attach page specific event hanlderss
$("#neighborhoodPage, #nearMePage").live("pageshow", function(event){

  // Handle filter select changes on nearme and neighborhood pages
  $(".ui-page-active #filter").change(function(event){
    // TODO: Can we simply use the existing URL for some of these values instead of the data- attributes?
    var 
    select = $(event.target),
    filter = select.val(),
    nname  = select.attr('data-neighborhood'),
    lat    = select.attr('data-lat'),
    lng    = select.attr('data-lng'),

    // Store selected filter; all translates into no filter param.
    params = (filter === 'all' ? {} : {filter: filter}),

    // Construct URL. Note: The path is determined by the existence of a neighborhood name.
    // TODO: Is is possible to simply resue the existing URL instead of reconstructing one?
    url = nname ? '/neighborhoods/' + nname : '/near_me/';

    // re-use coordinates if we have them.
    lat ? params['lat'] = lat : $.noop();
    lng ? params['lng'] = lng : $.noop();

    // Load new results page with filter applied.
    $.mobile.changePage( { type:'get', url:url, data:params });
  }); // end change handler

}); // end page event binding

// Detach page specific event hanlderss
$("#neighborhoodPage, #nearMePage").live("pagehide", function(event){
  $(".ui-page-active #filter").unbind('change');
});


$("#nearMePage").live("pageshow", function(event) {	
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(getLocation, unknownLocation, {maximumAge: 0, timeout: 30000, enableHighAccuracy: true}); 
  }
  else {
    $(".ui-content h3:first").text("We're sorry, we couldn't determine your location to find green spaces near you.");
  }
  
  
  function getLocation(pos)  {
    var latitude = pos.coords.latitude;
    var longitude = pos.coords.longitude;
    if((window.location.href.indexOf('?') == -1)) {
      var latlngurl = "near/";
      $.mobile.changePage({
        url: latlngurl,
        type: "get",
        data: {lat:latitude,lng:longitude}
      })
    }
  }
  function unknownLocation() {
    // show error message
    $(".ui-content h3:first").text("We're sorry, we couldn't determine your location to find green spaces near you.");
  }
});