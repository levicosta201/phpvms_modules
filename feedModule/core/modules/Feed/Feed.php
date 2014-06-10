<?php

 /***************************************************************************************	
 *											*	
 *											*
 * twMerco is licenced Creative Commons:  						*
 * View license.txt in the root, or visit http://creativecommons.org/licenses/by/4.0/	*
 *											*
 * @author Levi Costa									*
 * @copyright Copyright (c) 2014, Mercosul Network Devlopement				*
 * @link http://www.voemercosul.com/network/br						*
 * @license http://creativecommons.org/licenses/by/4.0/					*
 ***************************************************************************************/
 
	class Feed extends CodonModule
	{
	
		public function index()
		{
		
			$this->show('feed/index.tpl');
			$this->set('feed', FeedData::getFeed());
		
		}
		
		public function getJson()
		{
		
		//$sql = "SELECT * FROM `acars_position` WHERE `pilotid` = '$pilotid' AND `flightnum` = '$flightnum' ORDER BY id DESC";
		$SQL = "SELECT * FROM ".TABLE_PREFIX."activityfeed LIMIT 50";
	
	 
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
	
	}