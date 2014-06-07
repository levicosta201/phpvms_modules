<?php
 
class FlightMapData extends CodonData
{
	public static function insertReport($pilotid, $flightnum, $lat, $lng, $alt, $gs)
	{
		
		$sql = "INSERT INTO position_flight (pilotid, flightnum, lat, lng, altitude, groundspeed) 
		VALUES ('$pilotid', '$flightnum', '$lat', '$lng', '$alt', '$gs')";
		DB::query($sql);
		
		return true;
	}
	
	
	public static function clearFLight()
	{
	
		$sql = "DELETE FROM position_flight	
		WHERE DATE_SUB(NOW(), INTERVAL 1 DAY) > positiontime";
		$query = mysql_query($sql);
		
			}
	
	
	
		
	
}