package com.boloomo.emop.repair.util
{
	import com.boloomo.common.BlmJSON;
	import com.boloomo.common.Network;
	import com.boloomo.emop.repair.event.RepairListEvent;
	import com.boloomo.emop.repair.type.process.*;
	import com.boloomo.event.BlmEvent;
	import com.boloomo.event.BlmEventManager;
	import com.boloomo.util.StringUtils;
	import com.boloomo.util.maps.HashMap;

	/**
	 * 获取流程信息 
	 * @author boloomo
	 * 
	 */	
	public class ProcessInfo
	{
		private static var g_Instance:ProcessInfo = null;
		private var _repairMap:HashMap = new HashMap();									//备件	
		public function ProcessInfo()
		{
			if(g_Instance)
				throw new Error("error...");
			//BlmEventManager.Instance.addEventListener(BlmEvent.USER_LOGIN_SUCC,onUserLoginHandler);
		}
		


		public static function get Instance():ProcessInfo
		{
			if(g_Instance == null)
				g_Instance = new ProcessInfo();
			return g_Instance;
		}
		/**
		 * 当用户登录
		 * */
		public function onUserLoginHandler():void
		{
			var json:String = '{seq:"test",task:[{taskId:"1",taskName:"申请",detail:[{stepId:"1",sname:"编制",roleId:"1"},{stepId:"2",sname:"船长确认",roleId:"1"}]},{taskId:"2",taskName:"批复",detail:[{stepId:"1",sname:"批复",roleId:"1"}]},{taskId:"3",taskName:"审核",detail:[{stepId:"1",sname:"审核",roleId:"1"}]}]}';
			//var json:String = '{seq:"spare",task:[{taskId:"11",taskName:"船端备件申请",detail:[{stepId:"1",sname:"预申请",roleId:"7"},{stepId:"2",sname:"部门签字",roleId:"4"},{stepId:"3",sname:"船长签字",roleId:"2"}]},{taskId:"12",taskName:"采购批复",detail:[{stepId:"1",sname:"采购确认",roleId:"1"},{stepId:"2",sname:"采购批复",roleId:"1"}]},{taskId:"13",taskName:"备件询价",detail:[{stepId:"1",sname:"备件询价",roleId:"1"},{stepId:"2",sname:"备件询价完成",roleId:"1"}]},{taskId:"14",taskName:"备件订购",detail:[{stepId:"1",sname:"备件订购",roleId:"1"},{stepId:"2",sname:"备件订购审核",roleId:"1"}]},{taskId:"15",taskName:"备件入库",detail:[{stepId:"1",sname:"备件验收",roleId:"1"},{stepId:"2",sname:"确认入库",roleId:"1"}]}]}';
			onProcessPacket(json);
		}
		/**
		 * 流程信息
		 * */
		private function onProcessPacket(json:String):void
		{
			if(StringUtils.startsWith(json, "{eid") || json == "[]"){
				trace("[process] return:" + json);
				return;
			}
			var obj:Object = BlmJSON.decode(json); if(obj == null){return;}
			var array:Array = obj.task;
			var seq:String = obj.seq;
			var vec:Vector.<ProcessTaskObject> = new Vector.<ProcessTaskObject>();
			for(var i:int;i < array.length;i++)
			{
				var taskObj:ProcessTaskObject;
				if(i == (array.length -1))
					taskObj = ProcessTaskObject.parse(array[i],true);
				else
					taskObj = ProcessTaskObject.parse(array[i],false);
				vec.push(taskObj);
				repairMap.put(taskObj.taskId,taskObj);
			}
		}
		/**
		 * 根据TaskId获取 流程对象
		 * @param taskId 流程ID
		 * @return 
		 * 
		 */		
		public function taskObject(taskId:String):ProcessTaskObject
		{
			var obj:ProcessTaskObject,array:Array;
			array = repairMap.getValues();
			for(var i:int = 0;i < array.length;i++)
			{
				var temp:ProcessTaskObject = array[i] as ProcessTaskObject;
				if(temp.taskId == taskId)
				{
					obj = temp;
					break;
				}
			}
			return obj;
		}
		/**
		 * 根据taskId和stepId 获取环节对象 
		 * @param taskId 
		 * @param stepId
		 * @param type 0备件；1物料
		 * @return 
		 * 
		 */		
		public function stepObject(taskId:String,stepId:String):ProcessStepObject
		{
			var obj:ProcessStepObject,array:Array;
			array = repairMap.getValues();
			for(var i:int = 0;i < array.length;i++)
			{
				var temp:ProcessTaskObject = array[i] as ProcessTaskObject;
				if(temp.taskId == taskId)
				{
					var tempVec:Vector.<ProcessStepObject> = temp.stepVector;
					for(var j:int = 0;j < tempVec.length;j++)
					{
						if(stepId == tempVec[j].stepId)
						{
							obj = tempVec[j];
							break;
						}
					}
					break;
				}
			}
			return obj;
		}
		/**
		 * 根据taskId 获取名称 
		 * @param taskId
		 * @return 
		 * 
		 */		
		public function taskName(taskId:String):String
		{
			var obj:ProcessTaskObject = null;
			obj = repairMap.getValue(taskId) as ProcessTaskObject;
			var str:String = "";
			if(obj)
				str = obj.taskName;
			return  str;
		}
		/**
		 * 根据 taskId,stepId 获取stepName 
		 * @param taskId
		 * @param stepId
		 * @return 
		 * 
		 */		
		public function stepName(taskId:String,stepId:String):String
		{
			var str:String = "";
			var obj:ProcessTaskObject = null;
			obj = repairMap.getValue(taskId) as ProcessTaskObject;		
			if(obj != null)
			{
				for(var i:int = 0;i < obj.stepVector.length;i++)
				{
					var temp:ProcessStepObject = obj.stepVector[i];
					if(temp.stepId == stepId)
						str = temp.stepName;
				}
			}
			return str;
		}
		/**
		 *获取全部TaskObject 
		 * @param type 0 备件 ；1物料
		 * * */
		
		public function getTaskVector(type:int = 0):Vector.<ProcessTaskObject>
		{
			var vec:Vector.<ProcessTaskObject> = new Vector.<ProcessTaskObject>();
			var arr:Array = new Array();
			arr = repairMap.getValues();
			var land:ProcessTaskObject;
			for(var i:int = 0;i < arr.length;i++)
			{
				var temp:ProcessTaskObject = arr[i] as ProcessTaskObject;
				if(temp.taskId == '21' || temp.taskId == '41')
					land = temp;
				else
					vec.push(arr[i] as ProcessTaskObject);
			}
			vec.sort(taskSort);
			//vec.splice(1,0,land);
			return vec;
		}
		 
		public function taskSort(a:ProcessTaskObject,b:ProcessTaskObject):int
		{
			if(a.taskId > b.taskId)
				return 1;
			else if(a.taskId == b.taskId)
				return 0;
			else
				return -1;
		}
		public function get repairMap():HashMap
		{
			return _repairMap;
		}
		
		public function set repairMap(value:HashMap):void
		{
			_repairMap = value;
		}

	}
}