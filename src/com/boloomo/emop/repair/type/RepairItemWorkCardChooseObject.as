package com.boloomo.emop.repair.type
{	/**
	* 修理项管理
	* 添加工作卡时，判断工作卡的选中状态
	* @author zhoucd
	*/ 
	public class RepairItemWorkCardChooseObject extends Object
	{	
		private var _workcardId:String="";
		private var _workcardName:String="";
		private var _chosenFlag:Boolean=false;
		public function RepairItemWorkCardChooseObject()
		{
			super();
		}

		public function get chosenFlag():Boolean
		{
			return _chosenFlag;
		}

		public function set chosenFlag(value:Boolean):void
		{
			_chosenFlag = value;
		}

		public function get workcardName():String
		{
			return _workcardName;
		}

		public function set workcardName(value:String):void
		{
			_workcardName = value;
		}

		public function get workcardId():String
		{
			return _workcardId;
		}

		public function set workcardId(value:String):void
		{
			_workcardId = value;
		}

	}
}