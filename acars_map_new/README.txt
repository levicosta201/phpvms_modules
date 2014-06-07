New model ACARSMAP
==================

This module aim to generate the tracking of flights of your virtual airline.

URL
---
The website URL remains the following: SITE_URL/index.php/acars.

Files to be modified
--------------------


	Change the line 378 and enter your url: 
	$.getJSON('http://yoururl.com/v2/action.php/acars/getjson?pid='+pilid+'&flgnum='+this.flightdetails.flightnum+'').done(function( data) {

ACARS.php
acars.tpl
ACARSData.class.php

PS.: Before starting the changes make a backup of the files. 



