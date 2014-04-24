package com.boloomo.emop.repair.type
{
	/**
	 * 修理项管理
	 * 添加船舶时，判断船舶的选中状态
	 * @author zhoucd
	 */ 
	
	public class RepairItemShipChooseObject extends Object
	{
		private var _shipId:String="";
		private var _shipName:String="";
		private var _chosenFlag:Boolean=false;
		public function RepairItemShipChooseObject()
		{
			super();
		}

		public function get shipId():String
		{
			return _shipId;
		}

		public function set shipId(value:String):void
		{
			_shipId = value;
		}

		public function get shipName():String
		{
			return _shipName;
		}

		public function set shipName(value:String):void
		{
			_shipName = value;
		}

		public function get chosenFlag():Boolean
		{
			return _chosenFlag;
		}

		public function set chosenFlag(value:Boolean):void
		{
			_chosenFlag = value;
		}


	}
}