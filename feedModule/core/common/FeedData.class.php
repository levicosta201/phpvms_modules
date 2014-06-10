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
 
 	class FeedData extends CodonData
	{
	
		public static function getFeed()
		{
		
		 $query = "SELECT * FROM ".TABLE_PREFIX."activityfeed LIMIT 50";
		 
		 return DB::get_results($query);
		
		}
	
	}