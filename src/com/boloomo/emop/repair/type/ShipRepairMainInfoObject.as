package com.boloomo.emop.repair.type
{
	import com.boloomo.emop.component.process.ProcessObject;
	import com.boloomo.util.TimeUtil;
	
	import mx.controls.DateField;
	import mx.formatters.DateFormatter;
	
	import spark.formatters.DateTimeFormatter;
	
	/**
	 * 右侧 第二行数据
	 * _Appkind:String; //申请类别
	 * _internalKind:String; //内部类别
	 * _port:String; //供货港口
	 * _date:String; //需供货时间
	 * _reason:String; //申请原因
	 */
	public class ShipRepairMainInfoObject extends LeftInfoObject
	{	
		protected var _Appkind:String; //申请类别
		protected var _internalKind:String; //内部类别
		protected var _port:String; //供货港口
		protected var _date:String; //需供货时间
		protected var _reason:String; //申请原因
		
		
		private var _process:Vector.<ProcessObject>;						//流程信息
		public function ShipRepairMainInfoObject()
		{
			
		}
		
		public static function ProcessFunc(arr:Array):Vector.<ProcessObject>
		{
			if (arr==null)
				return null;
			var vec:Vector.<ProcessObject> = new Vector.<ProcessObject>();
			for(var i:int = 0;i < arr.length;i++)
			{
				var obj:ProcessObject = new ProcessObject();
				obj.uname = String(arr[i].nm);
				obj.action = String(arr[i].ac);
				obj.utime =TimeUtil.stringToTime(arr[i].tm);//Number(arr[i].tm);
				obj.remark = String(arr[i].rm);
				obj.state = Boolean(arr[i].st);
				vec.push(obj);
			}
			return vec;
		}
		
		public static function ParseJson(obj:Object):ShipRepairMainInfoObject{
			var ami:ShipRepairMainInfoObject = new ShipRepairMainInfoObject();
			ami._Appkind = obj["Appkind"];
			ami._internalKind = obj["internalKind"];
			ami._port = obj["port"];
			ami._date = obj["date"];
			ami._reason = obj["reason"];
			//			ami.process = ProcessFunc(obj["process"]);		//流程信息；
			return ami;
		}
		
		public function get Appkind():String
		{
			return _Appkind;
		}
		
		public function set Appkind(value:String):void
		{
			_Appkind = value;
		}
		
		public function get internalKind():String
		{
			return _internalKind;
		}
		
		public function set internalKind(value:String):void
		{
			_internalKind = value;
		}
		
		public function get port():String
		{
			return _port;
		}
		
		public function set port(value:String):void
		{
			_port = value;
		}
		
		public function get date():String
		{
			return _date;
		}
		
		public function set date(value:String):void
		{
			_date = value;
		}
		
		public function get reason():String
		{
			return _reason;
		}
		
		public function set reason(value:String):void
		{
			_reason = value;
		}
		
		public function get process():Vector.<ProcessObject>
		{
			return _process;
		}
		
		public function set process(value:Vector.<ProcessObject>):void
		{
			_process = value;
		}
		
		
	}
}