package com.boloomo.emop.repair.type
{
	/**
	 * 厂修管理中的
	 *   厂修管理类
	 *   @author lisicong
	 */
	import com.boloomo.util.TimeUtil;
	import com.boloomo.util.maps.HashMap;

	public class FactoryRepairObject
	{
		private var _status:String="";
		private var _factoryId:String="";
		private var _shipId:String="";
		private var _shipName:String="";
		private var _state:String="";
		private var _planIn:Date=new Date();
		private var _planOut:Date=new Date();
		private var _realIn:Date=new Date();
		private var _realOut:Date=new Date();
		private var _companyId:String="";
		private var _company:String="";
		private var _planTime:String="";
		private var _realTime:String="";
		private var _planSaveTime:String="";
		private var _realSaveTime:String="";
		private var _port:String="";
		private var _ccs:String="";
		private var _certdt:Date=new Date();
		private var _projectOrder:HashMap=new HashMap();
		private var _contOrder:HashMap = new HashMap();
		public static function parse(val:Object):FactoryRepairObject
		{
			var obj:FactoryRepairObject=new FactoryRepairObject();
			obj.status=val.status;
			obj.factoryId=val.facid;
			obj.shipId=val.shipid;
			obj.shipName=val.shipna;
			obj.state=val.state;
			obj.planIn=new Date(new Number(val.pin*1000));
			obj.planOut=new Date(new Number(val.pout*1000));
			obj.realIn=new Date(new Number(val.rin*1000));
			obj.realOut=new Date(new Number(val.rout*1000));
			obj.company=val.comna;
			obj.companyId=val.comid;
			obj.planTime=val.ptime;
			obj.realTime=val.rtime;
			obj.ccs=val.ccs;
			obj.certdt=new Date(new Number(val.certdt*1000));
			obj.port=val.port;
			return obj;
		}
		public function clear():void
		{
			this.company="";
			this.factoryId="";
			this.shipName="";
			this.planIn=null;
			this.planOut=null;
			this.planTime="";
			this.port="";
			this.projectOrder.clear();
			this.realIn=null;
			this.realOut=null;
			this.realTime="";
			this.shipId="";
			this.shipName="";
			this.state="";
			this.ccs="";
			this.certdt=null;
			this.contOrder.clear();
				
		}
		public function isclear():Boolean
		{
			if(this.company==""&&this.factoryId==""&&this.planIn==null&&this.planOut==null&&this.planTime==""&&this.port==""&&this.realIn==null&&this.realOut==null&&this.realTime==""&&this.shipId==""&&this.shipName==""&&this.state==""&&this.projectOrder.isEmpty())
				return true;
			else
				return false;
		}

		public function get ccs():String
		{
			return _ccs;
		}
		public function set ccs(value:String):void
		{
			_ccs=value;
		}
		public function get status():String
		{
			return _status;
		}
		
		public function set status(value:String):void
		{
			_status = value;
		}
		public function get certdt():Date
		{
			return _certdt;
		}
		public function set certdt(value:Date):void
		{
			_certdt = value;
		}
			
		public function get certdtName():String
		{
			return(TimeUtil.getTimeStr(certdt,"YYYY-MM-DD"));
		}
		public function get planInName():String
		{
			return(TimeUtil.getTimeStr(planIn,"YYYY-MM-DD hh:mm:ss"));
		}
		
		public function get planOutName():String
		{
			return(TimeUtil.getTimeStr(planOut,"YYYY-MM-DD hh:mm:ss"));
		}
		
		public function get realInName():String
		{
			return(TimeUtil.getTimeStr(realIn,"YYYY-MM-DD hh:mm:ss"));
		}
		
		public function get realOutName():String
		{
			return(TimeUtil.getTimeStr(realOut,"YYYY-MM-DD hh:mm:ss"));
		}
		
		public function get factoryId():String
		{
			return _factoryId;
		}

		public function set factoryId(value:String):void
		{
			_factoryId = value;
		}
		
		public function get shipName():String
		{
			return _shipName;
		}
		
		public function set shipName(value:String):void
		{
			_shipName = value;
		}
		
		public function get planSaveTime():String
		{
			var tmp:Number=(planIn.time-realIn.time)/1000/3600/24;
			return tmp.toFixed(2);
		}
		
		public function set planSaveTime(value:String):void
		{
			_planSaveTime = value;
		}
		
		public function get realSaveTime():String
		{
			var tmp:Number=(realOut.time-realIn.time-planOut.time+planIn.time)/1000/3600/24;
			
			return tmp.toFixed(2);
		}
		
		public function set realSaveTime(value:String):void
		{
			_realSaveTime = value;
		}
		

		
		public function get shipId():String
		{
			return _shipId;
		}

		public function set shipId(value:String):void
		{
			_shipId = value;
		}


		public function get state():String
		{
			return _state;
		}

		public function set state(value:String):void
		{
			_state = value;
		}

		public function get planIn():Date
		{
			return _planIn;
		}

		public function set planIn(value:Date):void
		{
			_planIn = value;
		}

		public function get planOut():Date
		{
			return _planOut;
		}

		public function set planOut(value:Date):void
		{
			_planOut = value;
		}

		public function get realIn():Date
		{
			return _realIn;
		}

		public function set realIn(value:Date):void
		{
			_realIn = value;
		}

		public function get realOut():Date
		{
			return _realOut;
		}

		public function set realOut(value:Date):void
		{
			_realOut = value;
		}



		public function get company():String
		{
			return _company;
		}

		public function set company(value:String):void
		{
			_company = value;
		}

		public function get planTime():String
		{
			if(planOut!=null&&planIn!=null)
			{
			var tmp:Number=(planOut.time-planIn.time)/1000/3600/24;
			return tmp.toFixed(2);
			}
			return "";
		}

		public function set planTime(value:String):void
		{
			_planTime = value;
		}

		public function get realTime():String
		{
			if(realOut!=null&&realIn!=null)
			{
			var tmp:Number=(realOut.time-realIn.time)/1000/3600/24;
			return tmp.toFixed(2);
			}
			return "";
		}

		public function set realTime(value:String):void
		{
			_realTime = value;
		}

		public function get port():String
		{
			return _port;
		}

		public function set port(value:String):void
		{
			_port = value;
		}

		public function get projectOrder():HashMap
		{
			return _projectOrder;
		}

		public function set projectOrder(value:HashMap):void
		{
			_projectOrder = value;
		}
		
		public function get contOrder():HashMap
		{
			return _contOrder
		}
		public function set contOrder(value:HashMap):void
		{
			_contOrder = value;
		}
		
		public function get companyId():String
		{
			return _companyId;
		}

		public function set companyId(value:String):void
		{
			_companyId = value;
		}


		public function FactoryRepairObject()
		{
		}
	}
}