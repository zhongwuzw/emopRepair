package com.boloomo.emop.repair.model
{
	import com.boloomo.common.Network;
	import com.boloomo.util.StringUtils;

	public class ShipRepairIDManageModel
	{
		private static var _Instance:ShipRepairIDManageModel;
		
		public function ShipRepairIDManageModel()
		{
		}
		
		public static function get Instance():ShipRepairIDManageModel
		{
			if(_Instance == null)
				_Instance = new ShipRepairIDManageModel();
			return _Instance;
		}
		
		public function reqLeftListInfo(shipId:String,depart:String,status:int = 0,uid:String = ""):void
		{
			var taskid:String;
			var stepid:String;
			if(status == 1)
			{
				taskid = "31";
				stepid = "1";
			}
			else if(status == 2)
			{
				taskid = "31";
				stepid = "2";
			}
			else if(status == 3)
			{
				taskid = "31";
				stepid = "3";
			}
			else if(status == 4)
			{
				taskid = "31";
				stepid = "4";
			}
			var requestStr:String = StringUtils.sprintf("{seq:\"%s\",uid:\"%s\",shipId:\"%s\",depart:\"%s\",taskid:\"%s\",stepid:\"%s\"}",1,uid,shipId,depart,taskid,stepid);

			Network.Instance.SendPacket(0x6020,requestStr);
		}
		
		public function reqShipRepairProcess(appID:String):void
		{
			var requestStr:String = StringUtils.sprintf("{seq:\"%s\",appID:\"%s\"}",1,appID);
			Network.Instance.SendPacket(0x6026,requestStr);
		}
		
	}
}