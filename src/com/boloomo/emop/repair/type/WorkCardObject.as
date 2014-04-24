package com.boloomo.emop.repair.type
{
	/**
	 * 修理项管理页面
	 *   修理项中的工作卡
	 * 储存在equipOb中
	 *   @author lisicong
	 */
	public class WorkCardObject
	{
		private var _workCardId:String="";
		private var _level:String="";
		private var _owner:String="";
		public function WorkCardObject()
		{
		}
		public static function parse(val:Object):WorkCardObject
		{
			var obj:WorkCardObject=new WorkCardObject();
			obj.workCardId=val.id;
			obj.level=val.level;
			obj.owner=val.owner;
			return obj;
		}
		public static function parseInit(val:Object):WorkCardObject
		{
			var obj:WorkCardObject=new WorkCardObject();
			obj.workCardId=val.id;
			obj.level=val.evel;
			obj.owner=val.owner;
			return obj;
		}
		public function clear():void{
			this.level="";
			this.workCardId="";
			this.owner="";
		}
		public function isClear():Boolean{
			if(this.level==""&&this.workCardId==""&&this.owner=="")
				return true;
			else
				return false;
		}

		public function get workCardId():String
		{
			return _workCardId;
		}

		public function set workCardId(value:String):void
		{
			_workCardId = value;
		}

		public function get level():String
		{
			return _level;
		}

		public function set level(value:String):void
		{
			_level = value;
		}

		public function get owner():String
		{
			return _owner;
		}

		public function set owner(value:String):void
		{
			_owner = value;
		}


	}
}