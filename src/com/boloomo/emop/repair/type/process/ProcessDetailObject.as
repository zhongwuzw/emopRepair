package com.boloomo.emop.repair.type.process
{
	import com.boloomo.emop.repair.util.*;

	/**
	 *  
	 * @author boloomo
	 * 
	 */	
	public class ProcessDetailObject
	{
		private var _taskId:String;
		private var _taskName:String;
		private var _stepId:String;
		private var _stepName:String;
		private var _status:int;
		private var _statusName:String;
		private var _opreate:String;
		private var _lastOpreate:String;
		private var _lastStatus:String;
		private var _lister:Vector.<ProcessOpreateObject>
		public function ProcessDetailObject()
		{
		}
		/**
		 * 格式化数据
		 * */
		public static function parse1(taskId:String,taskName:String,stepId:String,stepName:String,status:int,statusName:String,opreate:String,lp:String,ls:String):ProcessDetailObject
		{
			var obj:ProcessDetailObject = new ProcessDetailObject();
			obj.taskId = taskId;
			obj.taskName = taskName;
			obj.stepName = stepName;
			obj.stepId = stepId;
			obj.status = status;
			obj.statusName = statusName;
			obj.opreate = opreate;
			obj.lastOpreate = lp;
			obj.lastStatus = ls;
			return obj;
		}
		/**
		 * 格式化数据
		 * */
		public static function parse(arr:Array,type:int = 0):ProcessDetailObject
		{
			var obj:ProcessDetailObject = new ProcessDetailObject();
			obj.taskId = arr[0];
			obj.taskName = arr[1];
			obj.stepId = arr[2];
			obj.stepName = arr[3];
			obj.status = int(arr[4]);
			obj.statusName = arr[5];
			obj.opreate = arr[6];
			obj.lastOpreate = arr[7];
			obj.lastStatus = arr[8];
			if(type == 0)
				obj.lister =  ProcessUtil.getOpreate(obj.taskId,obj.stepId,obj.status);
			else
				obj.lister = ProcessUtil.getSingleOpreate(obj.taskId,obj.stepId,obj.status);
			return obj;
		}
		
		/**
		 *taskId 
		 */
		public function get taskId():String
		{
			return _taskId;
		}

		/**
		 * @private
		 */
		public function set taskId(value:String):void
		{
			_taskId = value;
		}

		/**
		 *stepId 
		 */
		public function get stepId():String
		{
			return _stepId;
		}

		/**
		 * @private
		 */
		public function set stepId(value:String):void
		{
			_stepId = value;
		}

		/**
		 *状态值 
		 */
		public function get status():int
		{
			return _status;
		}

		/**
		 * @private
		 */
		public function set status(value:int):void
		{
			_status = value;
		}

		/**
		 *状态名称 
		 */
		public function get statusName():String
		{
			return _statusName;
		}

		/**
		 * @private
		 */
		public function set statusName(value:String):void
		{
			_statusName = value;
		}

		/**
		 *操作 
		 */
		public function get opreate():String
		{
			return _opreate;
		}

		/**
		 * @private
		 */
		public function set opreate(value:String):void
		{
			_opreate = value;
		}

		/**
		 *最后操作 
		 */
		public function get lastOpreate():String
		{
			return _lastOpreate;
		}

		/**
		 * @private
		 */
		public function set lastOpreate(value:String):void
		{
			_lastOpreate = value;
		}

		/**
		 *提交后状态名称 
		 */
		public function get lastStatus():String
		{
			return _lastStatus;
		}

		/**
		 * @private
		 */
		public function set lastStatus(value:String):void
		{
			_lastStatus = value;
		}

		/**
		 *taskName 
		 */
		public function get taskName():String
		{
			return _taskName;
		}

		/**
		 * @private
		 */
		public function set taskName(value:String):void
		{
			_taskName = value;
		}

		/**
		 *stepName 
		 */
		public function get stepName():String
		{
			return _stepName;
		}

		/**
		 * @private
		 */
		public function set stepName(value:String):void
		{
			_stepName = value;
		}

		/**
		 * 可执行的操作 
		 */
		public function get lister():Vector.<ProcessOpreateObject>
		{
			return _lister;
		}

		/**
		 * @private
		 */
		public function set lister(value:Vector.<ProcessOpreateObject>):void
		{
			_lister = value;
		}


	}
}