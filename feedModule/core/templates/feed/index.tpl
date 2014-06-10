 <!------/***************************************************************************************	
 *											*	
 *											*
 * twMerco is licenced Creative Commons:  						*
 * View license.txt in the root, or visit http://creativecommons.org/licenses/by/4.0/	*
 *											*
 * @author Levi Costa									*
 * @copyright Copyright (c) 2014, Mercosul Network Devlopement				*
 * @link http://www.voemercosul.com/network/br						*
 * @license http://creativecommons.org/licenses/by/4.0/					*
 ***************************************************************************************/---->


<table width="600" border="1" align="center">
  <tr>
    <th scope="col">Pilotid</th>
    <th scope="col">Feed Text</th>
    <th scope="col">Date</th>
  </tr>
  <?php
  $feed = FeedData::getFeed();
  foreach($feed as $result)
  {
  ?>
  <tr>
    <td><?php echo $result->pilotid;?></td>
    <td><?php echo $result->message;?></td>
    <td><?php echo $result->submitdate;?></td>
  </tr>
  <?php
  }
  ?>
</table>

	
	
		
		
		
	
	