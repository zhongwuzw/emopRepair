package com.boloomo.emop.repair.type
{
	/**
	 * 修理单管理页面
	 *   修理单类
	 *   @author lisicong
	 */
	import com.boloomo.emop.component.process.ProcessObject;
	import com.boloomo.util.TimeUtil;
	import com.boloomo.util.maps.HashMap;
	
	import flare.vis.data.Data;
	

	public class RepairOrderObject
	{
		private var _applyId:String;
		private var _shipId:String;
		private var _shipName:String;
		private var _departId:String;
		private var _department:String;
		private var _type:String;
		private var _typeName:String;
		private var _proc:String;
		private var _procName:String;
		private var _link:String;
		private var _linkName:String;
		private var _state:String;
		private var _stateName:String;
		private var _self:int;
		private var _companyId:String;
		private var _company:String;
		private var _adate:String;
		private var _bdate:String;
		private var _fdate:String;
		private var _location:String;
		private var _projectId:String;
		private var _rbdate:String;
		private var _rfdate:String;
		private var _maded:String;
		private var _pland:String;
		private var _pstate:String;
		private var _ldate:String;
		private var _lname:String;
		private var _itemObj:ItemObj=new ItemObj();
		private var _eTime:String;
	

		public static function parse(val:Object):RepairOrderObject
		{
//			{seq：““，info：[{applyid：“”，shipid：“”，shipn：““，deparid：“”，deparn：““，type：“”，proc：““，link：”“，st：“”，com：“”，adate：，bdate：，fdate：，loc：“”，proid：““，
//			rbdate:，rfdate:，maded：，pland：，pstate：““}，{}，{}]}
			var obj:RepairOrderObject=new RepairOrderObject();
			obj.applyId=val.applyid;
			obj.shipId=val.shipid;
			obj.shipName= val.shipn;
			obj.departId= val.deparid;
			obj.department=val.deparn;
			obj.type=val.type;
			obj.typeName = val.type == "0"?"厂修":"自修";
			obj.state=val.st == ""?"0":val.st;
			obj.proc=val.proc == ""?"1":val.proc;
			obj.link=val.link == ""?"1":val.link;
			obj.company=val.comna;
			obj.companyId=val.comid;
			obj.eTime = String(((val.fdate-val.bdate)/86400000+1).toFixed(0))+ "天";
			obj.adate=TimeUtil.getTimeStr(new Date(new Number(val.adate)),"YYYY-MM-DD");
			obj.bdate=TimeUtil.getTimeStr(new Date(new Number(val.bdate)),"YYYY-MM-DD");
			obj.fdate=TimeUtil.getTimeStr(new Date(new Number(val.fdate)),"YYYY-MM-DD");
			obj.location=val.loc;
			obj.projectId=val.proid;
			obj.rbdate=TimeUtil.getTimeStr(new Date(new Number(val.rbdate)),"YYYY-MM-DD");
			obj.rfdate=TimeUtil.getTimeStr(new Date(new Number(val.rfdate)),"YYYY-MM-DD");
			obj.maded=TimeUtil.getTimeStr(new Date(new Number(val.maded)),"YYYY-MM-DD");
			obj.pland=TimeUtil.getTimeStr(new Date(new Number(val.pland)),"YYYY-MM-DD");
			obj.pstate=val.pstate;
			obj.ldate=TimeUtil.getTimeStr(new Date(new Number(val.ldate)),"YYYY-MM-DD");
			obj.lname=val.lname;
			obj.self=val.self;
			if(obj.proc == "1"){
				obj.procName="申请";
				if(obj.link == "1"){
					obj.linkName="编制";
					if(obj.state == "0"){
						obj.stateName = "未提交";
					}
					if(obj.state == "1"){
						obj.stateName = "提交";
					}
				}
				if(obj.link == "2"){
					obj.linkName="船长确认";
					if(obj.state == "0"){
						obj.stateName = "待船长确认";
					}
					if(obj.state == "1"){
						obj.stateName = "船长确认";
					}
				}
			}
			if(obj.proc == "2"){
				obj.procName="批复";
				if(obj.link == "1"){
					obj.linkName="批复";
					if(obj.state == "0"){
						obj.stateName = "待批复";
					}
					if(obj.state == "1"){
						obj.stateName = "已批复";
					}
					if(obj.state == "2"){
						obj.stateName = "已退回";
					}
					if(obj.state == "3"){
						obj.stateName = "已作废";
					}
				}
			}
			if(obj.proc == "3"){
				obj.procName="审核";
				if(obj.link == "1"){
					obj.linkName="审核";
				}
				if(obj.state == "0"){
					obj.stateName = "待审核";
				}
				if(obj.state == "1"){
					obj.stateName = "已审核";
				}
				if(obj.state == "2"){
					obj.stateName = "带派单";
				}
				if(obj.state == "3"){
					obj.stateName = "已退回";
				}
				if(obj.state == "4"){
					obj.stateName = "已作废";
				}
			}
			return obj;
		}
		public function RepairOrderObject()
		{
		}


		public function get applyId():String
		{
			return _applyId;
		}

		public function set applyId(value:String):void
		{
			_applyId = value;
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

		public function get departId():String
		{
			return _departId;
		}

		public function set departId(value:String):void
		{
			_departId = value;
		}

		public function get department():String
		{
			return _department;
		}

		public function set department(value:String):void
		{
			_department = value;
		}

		public function get type():String
		{
			return _type;
		}

		public function set type(value:String):void
		{
			_type = value;
		}

		public function get proc():String
		{
			return _proc;
		}

		public function set proc(value:String):void
		{
			_proc = value;
		}

		public function get link():String
		{
			return _link;
		}

		public function set link(value:String):void
		{
			_link = value;
		}

		public function get state():String
		{
			return _state;
		}

		public function set state(value:String):void
		{
			_state = value;
		}

		public function get company():String
		{
			return _company;
		}

		public function set company(value:String):void
		{
			_company = value;
		}

		public function get adate():String
		{
			return _adate;
		}

		public function set adate(value:String):void
		{
			_adate = value;
		}

		public function get bdate():String
		{
			return _bdate;
		}

		public function set bdate(value:String):void
		{
			_bdate = value;
		}

		public function get fdate():String
		{
			return _fdate;
		}

		public function set fdate(value:String):void
		{
			_fdate = value;
		}

		public function get location():String
		{
			return _location;
		}

		public function set location(value:String):void
		{
			_location = value;
		}

		public function get projectId():String
		{
			return _projectId;
		}

		public function set projectId(value:String):void
		{
			_projectId = value;
		}

		public function get rbdate():String
		{
			return _rbdate;
		}

		public function set rbdate(value:String):void
		{
			_rbdate = value;
		}

		public function get rfdate():String
		{
			return _rfdate;
		}

		public function set rfdate(value:String):void
		{
			_rfdate = value;
		}

		public function get maded():String
		{
			return _maded;
		}

		public function set maded(value:String):void
		{
			_maded = value;
		}

		public function get pland():String
		{
			return _pland;
		}

		public function set pland(value:String):void
		{
			_pland = value;
		}

		public function get pstate():String
		{
			return _pstate;
		}

		public function set pstate(value:String):void
		{
			_pstate = value;
		}

		public function get ldate():String
		{
			return _ldate;
		}

		public function set ldate(value:String):void
		{
			_ldate = value;
		}

		public function get lname():String
		{
			return _lname;
		}

		public function set lname(value:String):void
		{
			_lname = value;
		}

		public function get companyId():String
		{
			return _companyId;
		}

		public function set companyId(value:String):void
		{
			_companyId = value;
		}

		public function get self():int
		{
			return _self;
		}

		public function set self(value:int):void
		{
			_self = value;
		}

		public function get itemObj():ItemObj
		{
			return _itemObj;
		}

		public function set itemObj(value:ItemObj):void
		{
			_itemObj = value;
		}
		public function get stateName():String
		{
			return _stateName;
		}
		
		public function set stateName(value:String):void
		{
			_stateName = value;
		}
		
		public function get linkName():String
		{
			return _linkName;
		}
		
		public function set linkName(value:String):void
		{
			_linkName = value;
		}
		
		public function get procName():String
		{
			return _procName;
		}
		
		public function set procName(value:String):void
		{
			_procName = value;
		}
		
		public function get typeName():String
		{
			return _typeName;
		}
		
		public function set typeName(value:String):void
		{
			_typeName = value;
		}
		public function get eTime():String
		{
			return _eTime;
		}
		
		public function set eTime(value:String):void
		{
			_eTime = value;
		}

	}
}