package com.boloomo.emop.repair.type.process
{
	/**
	 * 环节对象 
	 * @author boloomo
	 * 
	 */	
	public class ProcessStepObject
	{	
		private var _stepId:String;
		private var _stepName:String;
		private var _taskId:String;
		private var _roleId:String;
		private var _end:Boolean;
		public function ProcessStepObject()
		{
		}
		public static function parse(obj:Object,last:Boolean):ProcessStepObject
		{
			var stepObj:ProcessStepObject = new ProcessStepObject();
			stepObj.stepId = obj.stepId;
			stepObj.stepName = obj.sname;
			stepObj.end = last;
			stepObj.roleId = obj.roleId;
			return stepObj;
		}
		/**
		 *步骤ID 
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
		 *步骤名称 
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
		 *步骤权限ID 
		 */
		public function get roleId():String
		{
			return _roleId;
		}
		
		/**
		 * @private
		 */
		public function set roleId(value:String):void
		{
			_roleId = value;
		}
		
		/**
		 *是否为最后一个 
		 */
		public function get end():Boolean
		{
			return _end;
		}
		
		/**
		 * @private
		 */
		public function set end(value:Boolean):void
		{
			_end = value;
		}

		/**
		 *流程ID 
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


	}
}