package com.boloomo.emop.repair.type.process
{
	/**
	 * 能够操作的步骤 
	 * @author boloomo
	 */	
	public class ProcessOpreateObject
	{
		private var _taskId:String;
		private var _stepId:String;
		private var _status:int;
		private var _id:int;
		private var _label:String;
		
		public function ProcessOpreateObject()
		{
		}
		//格式化数据
		public static function parse(arr:Array):ProcessOpreateObject
		{
			var obj:ProcessOpreateObject = new ProcessOpreateObject();
			obj.taskId = arr[0];
			obj.stepId = arr[1];
			obj.status = int(arr[2]);
			obj.id = int(arr[3]);
			obj.label = arr[4];
			return obj;
		}
		public function get taskId():String
		{
			return _taskId;
		}

		public function set taskId(value:String):void
		{
			_taskId = value;
		}

		public function get stepId():String
		{
			return _stepId;
		}

		public function set stepId(value:String):void
		{
			_stepId = value;
		}

		public function get status():int
		{
			return _status;
		}

		public function set status(value:int):void
		{
			_status = value;
		}

		public function get id():int
		{
			return _id;
		}

		public function set id(value:int):void
		{
			_id = value;
		}

		public function get label():String
		{
			return _label;
		}

		public function set label(value:String):void
		{
			_label = value;
		}


	}
}