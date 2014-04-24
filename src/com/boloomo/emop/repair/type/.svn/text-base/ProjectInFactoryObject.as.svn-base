package com.boloomo.emop.repair.type
{
	/**
	 * 厂修管理中的
	 *工程单类
	 * 为了方便新建的类
	 *   @author lisicong
	 */
	public class ProjectInFactoryObject
	{
		private var _checkStatus:String;
		private var _proid:String;
		private var _state:String;
		private var _sday:Date;
		private var _fday:Date;
		public static function parse(val:Object):ProjectInFactoryObject
		{
			var obj:ProjectInFactoryObject=new ProjectInFactoryObject();
			obj.proid=val.proid;
			obj.state=val.state;
			obj.sday=new Date(new Number(val.psday));
			obj.fday=new Date(new Number(val.pfday));
			return obj;
		}

		
		public function get proid():String
		{
			return _proid;
		}

		public function set proid(value:String):void
		{
			_proid = value;
		}
		public function get checkStatus():String
		{
			return _checkStatus;
		}
		
		public function set checkStatus(value:String):void
		{
			_checkStatus = value;
		}
		public function get state():String
		{
			return _state;
		}

		public function set state(value:String):void
		{
			_state = value;
		}

		public function get sday():Date
		{
			return _sday;
		}

		public function set sday(value:Date):void
		{
			_sday = value;
		}

		public function get fday():Date
		{
			return _fday;
		}

		public function set fday(value:Date):void
		{
			_fday = value;
		}


		public function ProjectInFactoryObject()
		{
		}
	}
}