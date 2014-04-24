package com.boloomo.emop.repair.type
{
	import com.boloomo.util.TimeUtil;

	/**
	 * 工程单详情页面
	 *   工程单中的申请单
	 * 和修理单一样 不过为了方便写新的类
	 *   @author lisicong
	 */
	public class ApplyObject
	{
		private var _myadate:String;
		private var _mybdate:String;
		private var _myfdate:String;
		private var _applyid:String;
		private var _itemid:String
		private var _itemn:String
		private var _adate:Date=null;
		private var _bdate:Date=null;
		private var _fdate:Date=null;
		private var _rbdate:Date = null;
		private var _rfdate:Date = null;
		private var _st:int;
		public static function parse(val:Object):ApplyObject{
			var obj:ApplyObject=new ApplyObject();
			obj.applyid=val.applyid;
			obj.itemid=val.itemid;
			obj.itemn=val.itemna;
			obj.adate=new Date(new Number(val.adate));
			obj.bdate=new Date(new Number(val.bdate*1000));
			obj.fdate=new Date(new Number(val.fdate*1000));
			obj.st=val.st;
			return obj;
		}
		public function ApplyObject()
		{
		}

		public function get applyid():String
		{
			return _applyid;
		}

		public function set applyid(value:String):void
		{
			_applyid = value;
		}

		public function get itemid():String
		{
			return _itemid;
		}

		public function set itemid(value:String):void
		{
			_itemid = value;
		}

		public function get itemn():String
		{
			return _itemn;
		}

		public function set itemn(value:String):void
		{
			_itemn = value;
		}
		
		public function get myadate():String
		{
			return TimeUtil.getTimeStr(adate,"YYYY-MM-DD");
		}

		public function get adate():Date
		{
			return _adate;
		}

		public function set adate(value:Date):void
		{
			_adate = value;
		}

		public function get bdate():Date
		{
			return _bdate;
		}
		
		public function get mybdate():String
		{
			return TimeUtil.getTimeStr(bdate,"YYYY-MM-DD");
		}

		public function set bdate(value:Date):void
		{
			_bdate = value;
		}

		public function get fdate():Date
		{
			return _fdate;
		}
		public function get myfdate():String
		{
			return TimeUtil.getTimeStr(fdate,"YYYY-MM-DD");
		}

		public function set fdate(value:Date):void
		{
			_fdate = value;
		}

		public function get st():int
		{
			return _st;
		}

		public function set st(value:int):void
		{
			_st = value;
		}


	}
}