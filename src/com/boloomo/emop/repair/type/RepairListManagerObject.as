package com.boloomo.emop.repair.type
{
	public class RepairListManagerObject
	{
		private var _applyId:String;
		private var _shipId:String;
		private var _shipName:String;
		private var _departId:String;
		private var _departName:String;
		private var _aDate:String;  //申请日期
		private var _sDate:String;  //开始时间
		private var _eDate:String;	//结束时间
		private var _planTime:String;
		private var _repairPort:String;
		private var _Builder:String;
		private var _projectId:String;
		
		private var _taskId:String;		//流程
		private var _taskName:String;
		private var _stepId:String;		//环节
		private var _stepName:String;
		private var _status:String;		//状态
		private var _statusName:String;
		private var _type:int;	
		private var _typeName:String;
		
		public static function parseObj(val:Object):RepairListManagerObject
		{
			var obj:RepairListManagerObject = new RepairListManagerObject();
			obj.applyId = val.applyId;
			obj.shipId = val.sid;
			obj.shipName = val.sn;
			obj.departId = val.did;
			obj.departName = val.dn;
			obj.typeName = val.cName;
			obj.aDate = val.aDate;
			obj.sDate = val.sDate;
			obj.eDate = val.eDate;
			obj.planTime = val.planTime;
			obj.repairPort = val.repairPort;
			obj.Builder = val.Builder;
			obj.taskName = val.taskName;
			obj.taskId =val.taskId;
			obj.stepId = val.stepId;
			obj.stepName = val.stepName;
			obj.status = val.status;
			obj.statusName = val.statusName;
			obj.projectId = val.pId;
			return obj;
		}
		
		
		
		public function RepairListManagerObject()
		{
		}

		public function get projectId():String
		{
			return _projectId;
		}

		public function set projectId(value:String):void
		{
			_projectId = value;
		}

		public function get Builder():String
		{
			return _Builder;
		}

		public function set Builder(value:String):void
		{
			_Builder = value;
		}

		public function get repairPort():String
		{
			return _repairPort;
		}

		public function set repairPort(value:String):void
		{
			_repairPort = value;
		}

		public function get planTime():String
		{
			return _planTime;
		}

		public function set planTime(value:String):void
		{
			_planTime = value;
		}

		public function get eDate():String
		{
			return _eDate;
		}

		public function set eDate(value:String):void
		{
			_eDate = value;
		}

		public function get sDate():String
		{
			return _sDate;
		}

		public function set sDate(value:String):void
		{
			_sDate = value;
		}

		public function get aDate():String
		{
			return _aDate;
		}

		public function set aDate(value:String):void
		{
			_aDate = value;
		}

		public function get departName():String
		{
			return _departName;
		}

		public function set departName(value:String):void
		{
			_departName = value;
		}

		public function get shipName():String
		{
			return _shipName;
		}

		public function set shipName(value:String):void
		{
			_shipName = value;
		}

		public function get shipId():String
		{
			return _shipId;
		}

		public function set shipId(value:String):void
		{
			_shipId = value;
		}

		public function get applyId():String
		{
			return _applyId;
		}

		public function set applyId(value:String):void
		{
			_applyId = value;
		}
		public function get typeName():String
		{
			return _typeName;
		}
		
		public function set typeName(value:String):void
		{
			_typeName = value;
		}
		
		public function get statusName():String
		{
			return _statusName;
		}
		
		public function set statusName(value:String):void
		{
			_statusName = value;
		}
		
		public function get stepName():String
		{
			return _stepName;
		}
		
		public function set stepName(value:String):void
		{
			_stepName = value;
		}
		
		public function get taskName():String
		{
			return _taskName;
		}
		
		public function set taskName(value:String):void
		{
			_taskName = value;
		}
		
		public function get type():int
		{
			return _type;
		}
		
		public function set type(value:int):void
		{
			_type = value;
		}
		
		public function get status():String
		{
			return _status;
		}
		
		public function set status(value:String):void
		{
			_status = value;
		}
		
		public function get stepId():String
		{
			return _stepId;
		}
		
		public function set stepId(value:String):void
		{
			_stepId = value;
		}
		
		public function get taskId():String
		{
			return _taskId;
		}
		
		public function set taskId(value:String):void
		{
			_taskId = value;
		}
		
		public function get departId():String
		{
			return _departId;
		}
		
		public function set departId(value:String):void
		{
			_departId = value;
		}
	}
}