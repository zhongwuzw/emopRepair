package com.boloomo.emop.repair.type
{
	import com.boloomo.emop.component.process.ProcessObject;
	import com.boloomo.util.TimeUtil;
	import com.boloomo.util.maps.HashMap;
	
	import flare.vis.data.Data;
	
	import mx.controls.DateField;

	public class ProjectOrderObject
	{/**
		* 工程单管理页面
		*   工程单类
		*   
		*   @author lisicong
		*/
		private var _myplandate:String;
		private var _myplanahead:String;
		private var _myrealdate:String;
		private var _myrealahead:String;
		private var _mypsday:String;
		private var _mypfday:String;
		private var _myasday:String;
		private var _myafday:String;
		private var _myType:String;
		private var _myState:String;
		private var _checkStatus:String;		//标示checkbox是否选中
		private var _proId:String;
		private var _shipId:String;
		private var _shipName:String;
		private var _type:String;
		private var _state:String;
		private var _location:String;
		private var _psday:Date=null;
		private var _pfday:Date=null;
		private var _asday:Date=null;
		private var _afday:Date=null;
		private var _pdays:Number;
		private var _adays:Number;
		private var _companyId:String;
		private var _company:String;
		private var _facid:String;
		private var _facna:String;
		private var _alert:String
		private var _illuArray:Array=new Array();
		private var _applyMap:HashMap=new HashMap();//存applyObject
		
		public static function parse(val:Object):ProjectOrderObject
		{
			var obj:ProjectOrderObject=new ProjectOrderObject;
			obj.proId=val.proid;
			obj.shipId=val.shipid;
			obj.shipName=val.shipna;
			var tempInt:int = val.tp;
			obj.type = tempInt.toString();
			//obj.type=val.tp;
			var tempInt1:int = val.st;
			obj.state = tempInt1.toString();
		//	obj.state=val.st;
			obj.location=val.loc;
			obj.psday=new Date(new Number(val.psday));
			obj.pfday=new Date(new Number(val.pfday));
			obj.asday=new Date(new Number(val.asday));
			obj.afday=new Date(new Number(val.afday));
			obj.pdays=val.pdays;
			obj.adays=val.adays;
			obj.companyId=val.comid;
			obj.company=val.comna;
			obj.facid=val.facid;
			obj.facna=val.facna;
			obj.alert=val.alert;
			var tempillu:String=val.illu;
			if(tempillu!=null)
			       obj.illuArray=tempillu.split("|");
			return obj;
		}
		
		public static function parse1(val:Object):ProjectOrderObject
		{
			var obj:ProjectOrderObject=new ProjectOrderObject;
			obj.proId=val.proid;
			obj.shipId=val.shipid;
			obj.shipName=val.shipna;
			var tempInt:int = val.type;
			obj.type = tempInt.toString();
			//obj.type=val.tp;
			var tempInt1:int = val.state;
			obj.state = tempInt1.toString();
			//	obj.state=val.st;
			obj.location=val.loc;
			obj.psday=new Date(new Number(val.psday));
			obj.pfday=new Date(new Number(val.pfday));
			obj.asday=new Date(new Number(val.asday));
			obj.afday=new Date(new Number(val.afday));
			obj.pdays=val.pdays;
			obj.adays=val.adays;
			obj.companyId=val.comid;
			obj.company=val.comna;
			obj.facid=val.facid;
			obj.facna=val.facna;
			obj.alert=val.alert;
			var tempillu:String=val.illu;
			if(tempillu!=null)
				obj.illuArray=tempillu.split("|");
			return obj;
		}
		
		public function clear():void
		{
			this.alert="";
			this.shipId="";
			this.shipName="";
			this.state="";
			this.type="";
		}
		/*public function idclear():Boolean
		{
			if(this.alert==""&&this.beginDate==null&&this.company==""&&this.planb==null&&this.planf==null&&this.finishDate==null&&this.location==""&&this.plan==""&&this.proId==""&&this.shipId==""&&this.shipName==""&&this.state==""&&this.type==""&&this.applyIdArray.length==0&&this.illuArray.length==0&&this.availableApplyIdArray.length==0&&this.itemMap.isEmpty())
				return true;
			else
				return false;
		}*/
		
		public function ProjectOrderObject()
		{
		}

		public function get proId():String
		{
			return _proId;
		}

		public function set proId(value:String):void
		{
			_proId = value;
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

		public function get type():String
		{
			return _type;
		}

		public function set type(value:String):void
		{
			_type = value;
		}

		public function get myType():String
		{
			var temp1:String;
			if(type == '0')
				temp1 = '厂修';
			else if(type == '1')
				temp1 = '航修';
			return temp1;
		}
		
		public function set myType(value:String):void
		{
			if(value == '厂修')
				type = '0';
			else if(value == '航修')
				type = '1';
		}

		public function get myState():String
		{
		//	var temp:String;
			if(state == '0')
				_myState = '未开始';
			else if(state == '1')
				_myState = '施工中';
			else if(state == '2')
				_myState = '已完工';
			return _myState;
		}
		
		public function set myState(value:String):void
		{
			if(value == '未开始')
				state = '0';
			else if(value == '施工中')
				state = '1';
			else if(value == '已完工')
				state = '2';
			else
				state = '0';
		}
		
		public function get state():String
		{
			return _state;
			
		}

		public function set state(value:String):void
		{
			_state = value;
			
		}

		public function get location():String
		{
			return _location;
		}

		public function set location(value:String):void
		{
			_location = value;
		}


		public function get company():String
		{
			return _company;
		}

		public function set company(value:String):void
		{
			_company = value;
		}

		public function get alert():String
		{
			return _alert;
		}

		public function set alert(value:String):void
		{
			_alert = value;
		}

		public function get illuArray():Array
		{
			return _illuArray;
		}

		public function set illuArray(value:Array):void
		{
			_illuArray = value;
		}


		
		public function get checkStatus():String
		{
			return _checkStatus;
		}
		public function set checkStatus(value:String):void
		{
			_checkStatus = value;
		}

		public function get psday():Date
		{
			return _psday;
		}

		public function set psday(value:Date):void
		{
			_psday = value;
		}
		
		public function get myplandate():String
		{
			return ((pfday.time - psday.time)/(1000*60*60*24)).toFixed(1);
		}
		
		public function get myplanahead():String
		{
			return ((asday.time - psday.time)/(1000*60*60*24)).toFixed(1);
		}
		
		public function get myrealdate():String
		{
			return ((afday.time - asday.time)/(1000*60*60*24)).toFixed(1);
		}
		
		public function get myrealahead():String
		{
			return (Number(myrealdate) - Number(myplandate)).toFixed(1);
		}
		
		public function get mypsday():String
		{
			return TimeUtil.getTimeStr(psday,"YYYY-MM-DD");
		}

		public function get pfday():Date
		{
			return _pfday;
		}

		public function set pfday(value:Date):void
		{
			_pfday = value;
		}
		
		public function get mypfday():String
		{
			return TimeUtil.getTimeStr(pfday,"YYYY-MM-DD");
		}

		public function get asday():Date
		{
			return _asday;
		}

		public function set asday(value:Date):void
		{
			_asday = value;
		}

		public function get afday():Date
		{
			return _afday;
		}

		public function set afday(value:Date):void
		{
			_afday = value;
		}

		public function get pdays():Number
		{
			return _pdays;
		}

		public function set pdays(value:Number):void
		{
			_pdays = value;
		}

		public function get adays():Number
		{
			return _adays;
		}

		public function set adays(value:Number):void
		{
			_adays = value;
		}

		public function get companyId():String
		{
			return _companyId;
		}

		public function set companyId(value:String):void
		{
			_companyId = value;
		}

		public function get facid():String
		{
			return _facid;
		}

		public function set facid(value:String):void
		{
			_facid = value;
		}

		public function get facna():String
		{
			return _facna;
		}

		public function set facna(value:String):void
		{
			_facna = value;
		}

		public function get applyMap():HashMap
		{
			return _applyMap;
		}

		public function set applyMap(value:HashMap):void
		{
			_applyMap = value;
		}



	}
}