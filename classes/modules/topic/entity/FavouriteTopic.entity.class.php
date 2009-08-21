<?php
/*-------------------------------------------------------
*
*   LiveStreet Engine Social Networking
*   Copyright © 2008 Mzhelskiy Maxim
*
*--------------------------------------------------------
*
*   Official site: www.livestreet.ru
*   Contact e-mail: rus.engine@gmail.com
*
*   GNU General Public License, version 2:
*   http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
*
---------------------------------------------------------
*/

class TopicEntity_FavouriteTopic extends FavouriteEntity_Favourite 
{   
	public function __construct($aParam = false)
	{ 
		parent::__construct($aParam);
		$this->_aData['target_type'] = 'topic';
	}
	
    public function getTopicId() {
        return $this->_aData['target_id'];
    }  
    public function getTopicPublish() {
        return $this->_aData['target_publish'];
    }
    
    
	public function setTopicId($data) {
        $this->_aData['target_id']=$data;
    }
    public function setTopicPublish($data) {
        $this->_aData['target_publish']=$data;
    }
}
?>