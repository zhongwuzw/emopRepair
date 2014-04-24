package com.boloomo.emop.repair.view.type
{
	public class RepairCardInfoObject
	{
		protected var _repairShipId:String;//船舶ID
		protected var _repairShipName:String;//船舶名称
		protected var _repairShipPlan:String;//计划内容
		protected var _repairDock:String;//承修单位
		
		protected var _repairPlanStartTime:String;//计划修理开始时间
		protected var _repairPlanEndTime:String;//计划修理结束时间
		protected var _repairPlanCostTime:String;//计划修理耗时
		protected var _repairPlanSaveTime:String;//计划节省时间
		
		protected var _repairRealStartTime:String;//实际修理开始时间
		protected var _repairRealEndTime:String;//实际修理结束时间
		protected var _repairRealCostTime:String;//实际修理花费时间
		protected var _repairRealSaveTime:String;//实际修理节省时间

		
		public function RepairCardInfoObject()
		{
		}

		public function get repairShipId():String
		{
			return _repairShipId;
		}

		public function set repairShipId(value:String):void
		{
			_repairShipId = value;
		}

		public function get repairShipName():String
		{
			return _repairShipName;
		}

		public function set repairShipName(value:String):void
		{
			_repairShipName = value;
		}

		public function get repairShipPlan():String
		{
			return _repairShipPlan;
		}

		public function set repairShipPlan(value:String):void
		{
			_repairShipPlan = value;
		}

		public function get repairDock():String
		{
			return _repairDock;
		}

		public function set repairDock(value:String):void
		{
			_repairDock = value;
		}

		public function get repairPlanStartTime():String
		{
			return _repairPlanStartTime;
		}

		public function set repairPlanStartTime(value:String):void
		{
			_repairPlanStartTime = value;
		}

		public function get repairPlanEndTime():String
		{
			return _repairPlanEndTime;
		}

		public function set repairPlanEndTime(value:String):void
		{
			_repairPlanEndTime = value;
		}

		public function get repairPlanCostTime():String
		{
			return _repairPlanCostTime;
		}

		public function set repairPlanCostTime(value:String):void
		{
			_repairPlanCostTime = value;
		}

		public function get repairPlanSaveTime():String
		{
			return _repairPlanSaveTime;
		}

		public function set repairPlanSaveTime(value:String):void
		{
			_repairPlanSaveTime = value;
		}

		public function get repairRealStartTime():String
		{
			return _repairRealStartTime;
		}

		public function set repairRealStartTime(value:String):void
		{
			_repairRealStartTime = value;
		}

		public function get repairRealEndTime():String
		{
			return _repairRealEndTime;
		}

		public function set repairRealEndTime(value:String):void
		{
			_repairRealEndTime = value;
		}

		public function get repairRealCostTime():String
		{
			return _repairRealCostTime;
		}

		public function set repairRealCostTime(value:String):void
		{
			_repairRealCostTime = value;
		}

		public function get repairRealSaveTime():String
		{
			return _repairRealSaveTime;
		}

		public function set repairRealSaveTime(value:String):void
		{
			_repairRealSaveTime = value;
		}


	}
}