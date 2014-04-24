package com.boloomo.emop.repair.type.process
{
	/**
	 * 流程对象 
	 * @author boloomo
	 * 
	 */	
	public class ProcessTaskObject
	{
		private var _taskId:String = null;
		private var _taskName:String = null;
		private var _stepVector:Vector.<ProcessStepObject> = null;
		private var _end:Boolean = false;
		public function ProcessTaskObject()
		{
		}
		/**
		 * 格式化数据
		 * */
		public static function parse(obj:Object,last:Boolean):ProcessTaskObject
		{
			var taskObj:ProcessTaskObject = new ProcessTaskObject();
			taskObj.taskId = obj.taskId;
			taskObj.taskName = obj.taskName;
			taskObj.end = last;
			taskObj.stepVector = stepParse(obj.detail,taskObj.taskId)
			return taskObj;	
		}
		public static function stepParse(arr:Array,taskId:String):Vector.<ProcessStepObject>
		{
			var vec:Vector.<ProcessStepObject> = new Vector.<ProcessStepObject>();
			for(var i:int = 0;i < arr.length;i++)
			{
				var obj:ProcessStepObject;
				if(i == (arr.length - 1))
					obj = ProcessStepObject.parse(arr[i],true);
				else
					obj = ProcessStepObject.parse(arr[i],false);
				obj.taskId = taskId;
				vec.push(obj);
			}
			return vec;
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

		/**
		 *流程名称 
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
		 *包含的环节 
		 */
		public function get stepVector():Vector.<ProcessStepObject>
		{
			return _stepVector;
		}

		/**
		 * @private
		 */
		public function set stepVector(value:Vector.<ProcessStepObject>):void
		{
			_stepVector = value;
		}

		/**
		 *是否流程结束 
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


	}
}