package com.boloomo.emop.repair.type
{
	/**
	 * 厂修管理类中的
	 *   计划内容类
	 *   @author lisicong
	 */
	public class PlannedContentObject
	{
		private var _flag:Boolean;  //标识  判定是否选中
		private var _id:String;
		private var _na:String;
		public function PlannedContentObject()
		{
		}
		public static function parse(val:Object):PlannedContentObject
		{
			var obj:PlannedContentObject=new PlannedContentObject();
			obj.id=val.id;
			obj.na=val.na;
			return obj;
		}

		public function get id():String
		{
			return _id;
		}

		public function set id(value:String):void
		{
			_id = value;
		}

		public function get na():String
		{
			return _na;
		}

		public function set na(value:String):void
		{
			_na = value;
		}
		public function get flag():Boolean
		{
			return _flag;
		}
		public function set flag(value:Boolean):void
		{
			_flag = value;
		}


	}
}