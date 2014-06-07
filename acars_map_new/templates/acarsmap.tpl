<style type="text/css">
	html, body {
  height: 100%;
  margin: 0;
  padding: 0;
}

#acarsmap  {
  height: 100%;
}
 
@media print {
  html, body {
    height: auto;
  }

  #acarsmap, #acarsmap {
    height: 650px;
  }
}

#panel {
  position: absolute;
  top: 5px;
  left: 50%;
  margin-left: -180px;
  z-index: 5;
  background-color: #fff;
  padding: 5px;
  border: 1px solid #999;
}
</style> 
 <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script type="text/javascript"
src="https://maps.googleapis.com/maps/api/js?libraries=weather&sensor=true">
 <script type="text/javascript"   src="https://maps.googleapis.com/maps/api/js?sensor=false&libraries=geometry"></script>

</script>


<?php 
/**
 * These are some options for the ACARS map, you can change here
 * 
 * By default, the zoom level and center are ignored, and the map 
 * will try to fit the all the flights in. If you want to manually set
 * the zoom level and center, set "autozoom" to false.
 * 
 * You can use these MapTypeId's:
 * http://code.google.com/apis/maps/documentation/v3/reference.html#MapTypeId
 * 
 * Change the "TERRAIN" to the "Constant" listed there - they are case-sensitive
 * 
 * Also, how to style the acars pilot list table. You can use these style selectors:
 * 
 * table.acarsmap { }
 * table.acarsmap thead { }
 * table.acarsmap tbody { }
 * table.acarsmap tbody tr.even { }
 * table.acarsmap tbody tr.odd { } 
 */
?>
<script type="text/javascript">
<?php 
/* These are the settings for the Google map. You can see the
	Google API reference if you want to add more options.
	
	There's two options I've added:
	
	autozoom: This will automatically center in on/zoom 
	  so all your current flights are visible. If false,
	  then the zoom and center you specify will be used instead
	  
	refreshTime: Time, in seconds * 1000 to refresh the map.
	  The default is 10000 (10 seconds)
*/
?>

var acars_map_defaults = {
	autozoom: true,
	zoom: 4,
    center: new google.maps.LatLng("<?php echo Config::Get('MAP_CENTER_LAT'); ?>", "<?php echo Config::Get('MAP_CENTER_LNG'); ?>"),
    mapTypeId: google.maps.MapTypeId.TERRAIN,
    refreshTime: 10000
    
};



</script>
<div class="mapcenter" align="center">
	<div id="acarsmap"></div>
</div>
<?php
/* See below for details and columns you can use in this table */
?>

<script type="text/javascript" src="<?php echo fileurl('/lib/js/acarsmap.js');?>"></script>
<?php
/* This is the template which is used in the table above, for each row. 
	Be careful modifying it. You can simply add/remove columns, combine 
	columns too. Keep each "section" (<%=...%>) intact
	
	Variables you can use (what they are is pretty obvious)
	
	Variable:							Notes:
	<%=flight.pilotid%>
	<%=flight.firstname%>
	<%=flight.lastname%>
	<%=flight.pilotname%>				First and last combined
	<%=flight.flightnum%>
	<%=flight.depapt%>					Gives the airport name
	<%=flight.depicao%>
	<%=flight.arrapt%>					Gives the airport name
	<%=flight.arricao%>
	<%=flight.phasedetail%>
	<%=flight.heading%>
	<%=flight.alt%>
	<%=flight.gs%>
	<%=flight.disremaining%>
	<%=flight.timeremaning%>
	<%=flight.aircraft%>				Gives the registration
	<%=flight.aircraftname%>			Gives the full name
	<%=flight.client%>					FSACARS/Xacars/FSFK, etc
	<%=flight.trclass%>					"even" or "odd"
	
	You can also use logic in the templating, if you so choose:
	http://ejohn.org/blog/javascript-micro-templating/
*/
?>

<script type="text/html" id="acars_map_row">
<tr class="<%=flight.trclass%>">
<td><a href="<?php echo url('/profile/view');?>/<%=flight.pilotid%>"><%=flight.pilotid%> - <%=flight.pilotname%></a></td>
<td><%=flight.flightnum%></td>
<td><%=flight.depicao%></td>
<td><%=flight.arricao%></td>
<td><%=flight.phasedetail%></td>
<td><%=flight.alt%></td>
<td><%=flight.gs%></td>
<td><%=flight.distremaining%> <?php echo Config::Get('UNITS');?> / <%=flight.timeremaining%></td>
</tr>
</script>

<?php
/*	This is the template for the little map bubble which pops up when you click on a flight
	Same principle as above, keep the <%=...%> tags intact. The same variables are available
	to use here as are available above.
*/
?>

<script type="text/html" id="acars_map_bubble">

<a href="<?php echo url('/profile/view');?>/<%=flight.pilotid%>"><%=flight.pilotid%> - <%=flight.pilotname%></a><br />
<table width="300" border="0">
  <tr>
    <td>Voo:</td>
    <td><%=flight.flightnum%></td>
  </tr>
  <tr>
    <td>Status:</td>
    <td><%=flight.phasedetail%></td>
  </tr>
  <tr>
    <td>Dist/Tempo Restante:</td>
    <td><%=flight.distremaining%>/<?php echo Config::Get('UNITS');?> / <%=flight.timeremaining%></td>
  </tr>
  <tr>
    <td>Partida:</td>
    <td><%=flight.depicao%></td>
  </tr>
  <tr>
    <td>Destino:</td>
    <td><%=flight.arricao%></td>
  </tr>
  <tr>
    <td>Proa:</td>
    <td><%=flight.heading%></td>
  </tr>
  <tr>
    <td>Altitude:</td>
    <td><%=flight.alt%></td>
  </tr>
  <tr>
    <td>GS:</td>
    <td><%=flight.gs%></td>
  </tr>
    <td>Aeronave:</td>
    <td><%=flight.aircraftname%></td>
  </tr>
  <tr>
    <td>ntwMerco:</td>
    <td>Online</td>
  </tr>  



 
</table>


</span>

</script>

<?php
/*	This is a small template for information about a navpoint popup 
	
	Variables available:
	
	<%=nav.title%>
	<%=nav.name%>
	<%=nav.freq%>
	<%=nav.lat%>
	<%=nav.lng%>
	<%=nav.type%>	2=NDB 3=VOR 4=DME 5=FIX 6=TRACK
 */
?>
<script type="text/html" id="navpoint_bubble">
<span style="font-size: 10px; text-align:left; width: 100%" align="left">
<strong>Name: </strong><%=nav.title%> (<%=nav.name%>)<br />
<strong>Type: </strong>
<?php	/* Show the type of point */ ?>
<% if(nav.type == 2) { %> NDB <% } %>
<% if(nav.type == 3) { %> VOR <% } %>
<% if(nav.type == 4) { %> DME <% } %>
<% if(nav.type == 5) { %> FIX <% } %>
<% if(nav.type == 6) { %> TRACK <% } %>
<br />
<?php	/* Only show frequency if it's not a 0*/ ?>
<% if(nav.freq != 0) { %>
<strong>Frequência: </strong><%=nav.freq%>
<% } %>
</span>
</script>

<script type="text/javascript">
 /**
 * phpVMS - Virtual Airline Administration Software
 * Copyright (c) 2008 Nabeel Shahzad
 * For more information, visit www.phpvms.net
 *	Forums: http://www.phpvms.net/forum
 *	Documentation: http://www.phpvms.net/docs
 *
 * phpVMS is licenced under the following license:
 *   Creative Commons Attribution Non-commercial Share Alike (by-nc-sa)
 *   View license.txt in the root, or visit http://creativecommons.org/licenses/by-nc-sa/3.0/
 *
 * @author Nabeel Shahzad
 * @copyright Copyright (c) 2008, Nabeel Shahzad
 * @link http://www.phpvms.net
 * @license http://creativecommons.org/licenses/by-nc-sa/3.0/
 *
 * Rewritten for Google Maps v3
 */
 
 
 
	
	

var flightMarkers = [];
var routeMarkers = [];
var flightPath = null;
var flightPath2 = null;
var trackflight = null;
var depMarker = null, arrMarker = null;
var info_window= null;
var run_once = false;
  
var defaultOptions = {
	autozoom: true,
	zoom: 4,
	center: new google.maps.LatLng(-25.363882,131.044922),
	mapTypeId: google.maps.MapTypeId.TERRAIN,
	refreshTime: 12000,
	autorefresh: true
};


	
		
	

var options = $.extend({}, defaultOptions, acars_map_defaults);
var map = new google.maps.Map(document.getElementById("acarsmap"), options);

// They clicked the map
google.maps.event.addListener(map, 'click', function()
{
clearPreviousMarkers();
});



liveRefresh();
if(options.autorefresh == true)
{
	setInterval(function () { liveRefresh(); }, options.refreshTime);
}

function liveRefresh()
{
	$.ajax({
		type: "GET",
		url: url + "/action.php/acars/data",
		dataType: "json",
		cache: false,
		success: function(data) 
		{
			populateMap(data);
		}
	});
};


function populateMap(data)
{





	clearMap();
	$("#pilotlist").html("");
	
	if (data.length == 0) {
		return false;
	}

	var lat, lng;
	var details, row, pilotlink;
	var bounds = new google.maps.LatLngBounds();
	
	for (var i = 0; i < data.length; i++) 
	{
		if(data[i] == null || data[i].lat == null || data[i].lng == null
			|| data[i].lat == "" || data[i].lng == "") {
			continue;
		}
			
		lat = data[i].lat;
		lng = data[i].lng;
				
		if(i%2 == 0)
			data[i].trclass = "even";
		else
			data[i].trclass = "odd";
		
		// Pull ze templates!
		var map_row = tmpl("acars_map_row", {flight: data[i]});
		var detailed_bubble = tmpl("acars_map_bubble", {flight: data[i]});
		
		$('#pilotlist').append(map_row);
		
		var pos = new google.maps.LatLng(lat, lng);
		flightMarkers[flightMarkers.length] = new google.maps.Marker({
			position: pos,
			map: map,
			icon: url+"/lib/images/inair/"+data[i].heading+".png",
			flightdetails: data[i],
			infowindow_content: detailed_bubble
		});
		
		bounds.extend(pos);
				
		google.maps.event.addListener(flightMarkers[flightMarkers.length - 1], 'click', function() 
		{
			clearPreviousMarkers();
		
	
			
			
			var pilid = this.flightdetails.pilotid[3] + this.flightdetails.pilotid[4] + this.flightdetails.pilotid[5] + this.flightdetails.pilotid[6];
			
			

				$.getJSON('http://yoururl.com/v2/action.php/acars/getjson?pid='+pilid+'&flgnum='+this.flightdetails.flightnum+'').done(function( data ){
				
				var tracker = new Array();
		$.each( data.bindings, function(i, value){
			tracker.push( 
				new google.maps.LatLng(
					value.latitude, 
					value.longitude
				)
			);
		});
 
	var trackflight = new google.maps.Polyline({
		path: tracker,
		strokeColor: '#003300',
		strokeOpacity: 1,
		strokeWeight: 1.7,
		geodesic: true
	}); 
	
	map.fitBounds(focus_bounds); 
	trackflight.setMap(map);
});



 
			
			var focus_bounds = new google.maps.LatLngBounds();
			// Flight details info window
			info_window = new google.maps.InfoWindow({ 
				content: this.infowindow_content,
				position: this.position
			});
			
			info_window.open(map, this);
			
				
			
			// Add polyline, and start/end points
			var dep_location = new google.maps.LatLng(this.flightdetails.deplat, this.flightdetails.deplng);
			var arr_location = new google.maps.LatLng(this.flightdetails.arrlat, this.flightdetails.arrlng);
			
			
			depMarker = new google.maps.Marker({
				position: dep_location,
				map: map,
				icon: depicon,
				title: this.flightdetails.depname,
				zIndex: 100
			});

			arrMarker = new google.maps.Marker({
				position: arr_location,
				map: map,
				icon: arricon,
				title: this.flightdetails.arrname,
				zIndex: 100
			});
			
			// Now the flight path, if it exists
			var path = new Array();
			path[path.length] = dep_location;
			focus_bounds.extend(dep_location);
			// if(this.flightdetails.route_details.length > 0) {
				$.each(this.flightdetails.route_details, function(i, nav)
				{
					var loc = new google.maps.LatLng(nav.lat, nav.lng);
					
					if(nav.type == 3)
						icon = "icon_vor.png";
					else
						icon = "icon_fix.png";
					
					var navpoint_info = tmpl("navpoint_bubble", {nav: nav});
					routeMarkers[routeMarkers.length] = new google.maps.Marker({
						position: loc,
						map: map,
						icon: url + "/lib/images/"+icon,
						title: nav.title,
						zIndex: 100,
						infowindow_content: navpoint_info
					});
					
					google.maps.event.addListener(routeMarkers[routeMarkers.length - 1], 'click', function() 
					{
						info_window = new google.maps.InfoWindow({ 
							content: this.infowindow_content,
							position: this.position
						});
						
						info_window.open(map, this);
					});
					
					path[path.length] = loc;
					focus_bounds.extend(loc);
				});
			//}
			
			path[path.length] = arr_location;
			focus_bounds.extend(this.position);
			focus_bounds.extend(arr_location);

			flightPath = new google.maps.Polyline({
				path: path,
				strokeColor: "#8B0000", strokeOpacity: 0.9, strokeWeight: 2, geodesic: true
			});
			
			map.fitBounds(focus_bounds); 
			flightPath.setMap(map);

			// SEIWIADDITION

			var path2 = new Array();
	
	
			
			
			
			
 if(this.flightdetails.route_details.length > 0) {
        $.each(this.flightdetails.posreports, function(i, nav)
        {
                var loc2 = new google.maps.LatLng(nav.latitude, nav.longitude);
				
                path2[path2.length] = loc2;
                focus_bounds.extend(loc2);
                });
}
			
                
				 
			flightPath2 = new google.maps.Polyline({
				path: path2,
				strokeColor: "#FFD700", strokeOpacity: 1.0, strokeWeight: 3, geodesic: true
			});
			
		//	map.fitBounds(focus_bounds); 
			flightPath2.setMap(map);
		});
		
		
	
	}
	
	
	
	// If they selected autozoom, only do the zoom first time
	if(options.autozoom == true && run_once == false)
	{
		map.fitBounds(bounds); 
		run_once = true;
	}
}

function clearPreviousMarkers()
{
	if(info_window)
	{
		info_window.close();
		info_window = null;
	}
	
	if(depMarker != null)
	{
		depMarker.setMap(null);
		depMarker = null;
	}
	
	if(arrMarker != null)
	{
		arrMarker.setMap(null);
		arrMarker = null;
	}
	
	if(routeMarkers.length > 0)
	{
		for(var i = 0; i < routeMarkers.length; i++) {
			routeMarkers[i].setMap(null);
		}
	}
	
	routeMarkers.length = 0;
	
	if(flightPath != null)
	{
		flightPath.setMap(null);
		flightPath = null;
	}
	
	if(flightPath2 != null)
	{
		flightPath2.setMap(null);
		flightPath2 = null;
	}
	
	if(trackflight != null)
	{
		trackflight.setMap(null);
		trackflight = null;
	}
	
	
	

}

function clearMap()
{
	if(flightMarkers.length > 0)
	{
		for(var i = 0; i < flightMarkers.length; i++) {
			flightMarkers[i].setMap(null);
		}
	}
	
	flightMarkers.length = 0;
	
	if(routeMarkers.length > 0)
	{
		for(var i = 0; i < routeMarkers.length; i++) {
			routeMarkers[i].setMap(null);
		}
	}
	


	routeMarkers.length = 0;
}
</script>