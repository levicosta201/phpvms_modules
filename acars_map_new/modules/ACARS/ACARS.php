<?php
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
 */

class ACARS extends CodonModule
{
	public $title = 'ACARS';
	public $acarsflights;
	
	public function index()
	{
		$this->viewmap();
	}
	
	public function viewmap()
	{
		$this->title = 'ACARS Map';
		$this->set('acarsdata', ACARSData::GetACARSData());
		$this->render('acarsmap.tpl');
	}
	
	/**
	 *  We didn't list a function for each ACARS client,
	 *	so call this, which will include the acars peice in
	 */
	public function __call($name, $args)
	{
		$acars_action = $args[0];
	
		// clean the name...
		$name = preg_replace("/[^a-z0-9-]/", "", strtolower($name));
		if(dirname(__FILE__).DS.$name.'.php')
		{
			include_once dirname(__FILE__).DS.$name.'.php';
			return;
		}
	}
	
	public function data()
	{
		$flights = ACARSData::GetACARSData();
		
		if(!$flights) 
			$flights = array();
		
		$this->acarsflights = array();
		foreach($flights as $flight)
		{	
			if($flight->route == '')
			{
				$flight->route_details = array();
			}
			else
			{
				
				$flight->route_details = NavData::parseRouteACARS($flight);
			}
			
			$c = (array) $flight; // Convert the object to an array
			
			$c['pilotid'] = PilotData::GetPilotCode($c['code'], $c['pilotid']);
			
			$positionreports = TrackFlightData::GetFlightPositions($flight->pilotid, $flight->flightnum);
			$c['posreports'] = $positionreports;
			
			
			
			// Normalize the data
			if($c['timeremaining'] == '')
			{
				$c['timeremaining'] ==  '-';
			}
			
			if(trim($c['phasedetail']) == '')
			{
				$c['phasedetail'] = 'Enroute';
			}
			
			/* If no heading was passed via ACARS app then calculate it
				This should probably move to inside the ACARSData function, so then
				 the heading is always there for no matter what the calcuation is
				*/
			if($flight->heading == '')
			{
				/* Calculate an angle based on current coords and the
					destination coordinates */
				
				$flight->heading = intval(atan2(($flight->lat - $flight->arrlat), ($flight->lng - $flight->arrlng)) * 180 / 3.14);
				//$flight->heading *= intval(180/3.14159);
				
				if(($flight->lng - $flight->arrlng) < 0)
				{
					$flight->heading += 180;
				}
				
				if($flight->heading < 0)
				{
					$flight->heading += 360;
				}
			}
			
			// Little one-off fixes to normalize data
			$c['distremaining'] = $c['distremain'];
			$c['pilotname'] = $c['firstname'] . ' ' . $c['lastname'] ;
			
			unset($c['messagelog']);
			
			$this->acarsflights[] = $c;
			

			
			continue;
		}
	
		CodonEvent::Dispatch('refresh_acars', 'ACARS');
		
		echo json_encode($this->acarsflights);
		
		
	}
	
	
	public function getJson()
	{
	
	FlightMapData::DeleteOlderThanDay();
	
	$pilotid = $_GET['pid'];
	$flightnum = $_GET['flgnum'];
	
	
	
	
	//$sql = "SELECT * FROM `acars_position` WHERE `pilotid` = '$pilotid' AND `flightnum` = '$flightnum' ORDER BY id DESC";
	$SQL = "SELECT * FROM `position_flight` WHERE `pilotid` = ".$pilotid." AND `flightnum` = '$flightnum' ORDER BY id DESC";
	
	 
$table = mysql_query($SQL) or die(mysql_error());
 
while ($row = mysql_fetch_array($table))  
{
 
    $i=0;
                 
    foreach($row as $key => $value)    
    {
 
        if (is_string($key)) 
        {
         $fields[mysql_field_name($table,$i++)] = $value;
        }
 
    }
 
    $json_result["bindings"] [ ] =  $fields;
 
}
 
$JSON = json_encode($json_result);
 
print_r($JSON);
	}
		
	
	public function routeinfo()
	{		
		if($this->get->depicao == '' || $this->get->arricao == '')
			return;
		
		$depinfo = OperationsData::GetAirportInfo($this->get->depicao);
		if(!$depinfo)
		{
			$depinfo = OperationsData::RetrieveAirportInfo($this->get->depicao);
		}
		
		$arrinfo = OperationsData::GetAirportInfo($this->get->arricao);
		if(!$arrinfo)
		{
			$arrinfo = OperationsData::RetrieveAirportInfo($this->get->arricao);
		}
		
		// Convert to json format
		$c = array();
		$c['depapt'] = (array) $depinfo;
		$c['arrapt'] = (array) $arrinfo;
		
		echo json_encode($c);
	}
	
	
	
	public function geraXML()
	{
	header('Content-Type: application/xml');
$output = "<root><name>sample_name</name></root>";
print ($output);
	
	}
		
	public function fsacarsconfig()
	{
		$this->write_config('fsacars_config.tpl', Auth::$userinfo->code.'.ini');
	}
	
	public function fspaxconfig()
	{
		$this->write_config('fspax_config.tpl', Auth::$userinfo->code.'_config.cfg');
	}
	
	public function xacarsconfig()
	{
		$this->write_config('xacars_config.tpl', 'xacars.ini');
	}
	
	/**
	 * Write out a config file to the user, give the template name and
	 *	the filename to save the template as to the user
	 *
	 * @param mixed $template_name Template to use for config (fspax_config.tpl)
	 * @param mixed $save_as File to save as (xacars.ini)
	 * @return mixed Nothing, sends the file to the user
	 *
	 */
	public function write_config($template_name, $save_as)
	{
		if(!Auth::LoggedIn())
		{
			echo 'You are not logged in!';
			break;
		}
		
		$this->set('pilotcode', PilotData::GetPilotCode(Auth::$userinfo->code, Auth::$userinfo->pilotid));
		$this->set('userinfo', Auth::$userinfo);
		
		$acars_config = Template::GetTemplate($template_name, true);
		$acars_config = str_replace("\n", "\r\n", $acars_config);
		
		Util::downloadFile($acars_config, $save_as);
	}
}