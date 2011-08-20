var selectedFeature = null;

$(document).ready(function() {

    // Start with the map page
    if (window.location.hash && window.location.hash!='#mappage') {
        $.mobile.changePage('mappage');
    }

    // fix height of content
    function fixContentHeight() {
        var footer = $("div[data-role='footer']:visible"),
		header = $("div[data-role='header']:visible"),
        content = $("div[data-role='content']:visible:visible"),
        viewHeight = $(window).height(),
        contentHeight = viewHeight - footer.outerHeight() - header.outerHeight();

        if ((content.outerHeight() + footer.outerHeight() + header.outerHeight()) !== viewHeight) {
            contentHeight -= (content.outerHeight() - content.height());
            content.height(contentHeight);
        }
        if (window.map) {
            map.updateSize();
        } else {
            // initialize map
            init();
            map.updateSize();

        }
    }
    $(window).bind("orientationchange resize pageshow", fixContentHeight);
    fixContentHeight(); 
    //init();

    // Map zoom  
    $("#plus").click(function(){
        map.zoomIn();
    });
    $("#minus").click(function(){
        map.zoomOut();
    });
    $("#locate").click(function(){
        var control = map.getControlsBy("id", "locate-control")[0];
        if (control.active) {
            control.getCurrentLocation();
        } else {
            control.activate();
        }
    });
	
	// Park layer
	var parkLayer = new OpenLayers.Layer.Vector("Green Spaces", {
        styleMap: new OpenLayers.StyleMap({ // green polygon
			fillColor: "rgb(0,150,50)",
			fillOpacity: 0.4,
			strokeColor: "rgb(0,150,50)",
			strokeOpacity: 0,
			strokeWidth: 0
        })
    });
	if (parks.type == "FeatureCollection") {
		var parksFeatures = getFeatures(parks);
	    parkLayer.addFeatures(parksFeatures);
	    map.addLayer(parkLayer);
	
		// zoom map to park
		map.zoomToExtent(parkLayer.getDataExtent());
	};
	
	// Activities layers
	var activitiesLayer = new OpenLayers.Layer.Vector("Activities", {
        styleMap: new OpenLayers.StyleMap({ // marker
            externalGraphic : "img/mobile-loc.png",
            graphicOpacity : 1.0,
            graphicWith:16,
            graphicHeight:26
        })
    });
	if (activities.type == "FeatureCollection") {
	    var activitiesFeatures = getFeatures(activities);
	    activitiesLayer.addFeatures(activitiesFeatures);
	    map.addLayer(activitiesLayer);
	};
	
	// locate me on init
	var control = map.getControlsBy("id", "locate-control")[0];
	if ($.getUrlVar('action') == 'locateme') {
		
		if (control.active) {
            control.getCurrentLocation();
        } else {
            control.activate();
        }
		
	}
	
	/*
    var selectControl = new OpenLayers.Control.SelectFeature([activitiesLayer, parkLayer], {onSelect: function(feature){
        selectedFeature = feature;
        $.mobile.changePage($("#popup"), "pop");
    }});
    
    map.addControl(selectControl);
    selectControl.activate();
    
    $('div#popup').live('pageshow',function(event, ui){
        var li = "";
        for(var attr in selectedFeature.attributes){
            li += "<li><div style='width:25%;float:left'>" + attr + "</div><div style='width:75%;float:right'>" 
            + selectedFeature.attributes[attr] + "</div></li>";
        }
        $("ul#details-list").empty().append(li).listview("refresh");
    });
	*/

});

function getFeatures(features){
	
	var reader = new OpenLayers.Format.GeoJSON({
	  'internalProjection': sm,
	  'externalProjection': gg
	});
    
    return reader.read(features);
}