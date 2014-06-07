<?php
////////////////////////////////////////////////////////////////////////////
//Crazycreatives Track Flight module for phpVMS virtual airline system    //
//@author Manuel Seiwald                                                  //
//@copyright Copyright (c) 2013, Manuel Seiwald, All Rights Reserved      //
////////////////////////////////////////////////////////////////////////////
 
class FlightMapData extends CodonData
{
	public static function AddPositionReport($pilotid, $flightnum, $lat, $lng, $alt, $gs)
	{
		
		$sql = "INSERT INTO position_flight (pilotid, flightnum, lat, lng, altitude, groundspeed) 
		VALUES ('$pilotid', '$flightnum', '$lat', '$lng', '$alt', '$gs')";
		DB::query($sql);
		
		return true;
	}
	
	
	public static function DeleteOlderThanDay()
	{
	
		$sql = "DELETE FROM position_flight	
		WHERE DATE_SUB(NOW(), INTERVAL 1 DAY) > positiontime";
		$query = mysql_query($sql);
		
			}
	


   public function GetFlightPositions($pilotid, $flightnum)
	{
		$sql = "SELECT * FROM position_flight 
WHERE pilotid = '$pilotid' AND flightnum = '$flightnum'
ORDER BY id DESC";
		$query = DB::get_results($sql);
		return $query;
	}
	
	
		public static function searchAirportICAO($icao)
	{
		$sql = "SELECT * FROM ".TABLE_PREFIX."airports
				WHERE icao='$icao'";
		
		return DB::get_row($sql);
	}
	
	
	
}