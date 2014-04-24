package com.boloomo.emop.repair.type
{
	public class LeftInfoObject
	{
		protected var _shipId:String;
		protected var _shipName:String;
		protected var _AppDate:String;
		protected var _Appid:String;
		protected var _status:int;
		protected var _department:String;
		
		public function LeftInfoObject()
		{
		}
		
		public static function ParseJson(obj:Object):LeftInfoObject
		{
			var lio:LeftInfoObject = new LeftInfoObject();
			lio._shipName = obj["shipName"];
			lio._AppDate = obj["AppDate"];
			lio._Appid = obj["Appid"];
			lio._status = obj["status"];
			lio._department = obj["department"];
			return lio;
		}
		
		public function get shipName():String
		{
			return _shipName;
		}
		
		public function set shipName(value:String):void
		{
			_shipName = value;
		}
		
		public function get AppDate():String
		{
			return _AppDate;
		}
		
		public function set AppDate(value:String):void
		{
			_AppDate = value;
		}
		
		public function get Appid():String
		{
			return _Appid;
		}
		
		public function set Appid(value:String):void
		{
			_Appid = value;
		}
		
		public function get status():int
		{
			return _status;
		}
		
		public function set status(value:int):void
		{
			_status = value;
		}
		
		public function get department():String
		{
			return _department;
		}
		
		public function set department(value:String):void
		{
			_department = value;
		}
		
		public function get shipId():String
		{
			return _shipId;
		}
		
		public function set shipId(value:String):void
		{
			_shipId = value;
		}

	}
}