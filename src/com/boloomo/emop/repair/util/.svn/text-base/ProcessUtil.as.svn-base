package  com.boloomo.emop.repair.util
{
	import com.boloomo.common.Version;
	import com.boloomo.emop.repair.type.process.*;
	import com.boloomo.emop.userinfo.control.UserInfoControl;
	import com.boloomo.emop.userinfo.type.RoleType;

	/**
	 * 根据taskId,stepId和status 获取相应名称 
	 * @author boloomo
	 * 
	 */	
	public class ProcessUtil
	{
		private static var _data:Vector.<ProcessDetailObject> = null;
		private static var _opreater:Vector.<ProcessOpreateObject> = null;
		public function ProcessUtil()
		{
		}
		
		/**
		 * 根据给定的值获取到状态名称 
		 * @param taskId 流程ID
		 * @param stepId 环节ID
		 * @param status 状态值  0未提交;1同意;2退回;3废单;
		 */		
		public static function getWorkFlow(taskId:String,stepId:String,status:int):ProcessDetailObject
		{
			if(_data == null)
				setDefaultData();
			var obj:ProcessDetailObject;
			for(var i:int = 0;i < _data.length;i++)
			{
				var temp:ProcessDetailObject = _data[i];
				if(temp.taskId == taskId && temp.stepId == stepId && temp.status == status)
				{
					obj = temp;
					break;
				}
			}
			return obj;
		}
		/**
		 * 获取单独操作 流程内容 
		 * @param taskId
		 * @param stepId
		 * @param status
		 * 
		 */		
		public static function getSingleWorkFlow(taskId:String,stepId:String,status:int):ProcessDetailObject
		{
			
			var vec:Vector.<ProcessDetailObject> = setSingleDefaultData();
			var obj:ProcessDetailObject;
			for(var i:int = 0;i < vec.length;i++)
			{
				var temp:ProcessDetailObject = vec[i];
				if(temp.taskId == taskId && temp.stepId == stepId && temp.status == status)
				{
					obj = temp;
					break;
				}
			}
			return obj;
		}
		private static function setSingleDefaultData():Vector.<ProcessDetailObject>
		{
			var array:Array = new Array(
				['13','备件询价','1','备件询价',0,'未询价','询价','起草','未询价'],
				['13','备件询价','1','备件询价',1,'已报价','询价','起草','已报价'],
				
				['14','备件订购','1','备件订购',0,'订购','订购','订购','订购'],
				
				['15','备件验收','1','备件验收',0,'验收','验收','验收','验收']
			);
			var vec:Vector.<ProcessDetailObject> = new Vector.<ProcessDetailObject>();
			for(var i:int = 0;i < array.length;i++)
			{
				var temp:ProcessDetailObject = ProcessDetailObject.parse(array[i] as Array,1);
				vec.push(temp);
			}
			return vec;
		}
		/**
		 * 根据taskId stepId 和 status 获取操作 
		 * @param taskId
		 * @param stepId
		 * @param status
		 * @return 
		 */		
		public static function getOpreate(taskId:String,stepId:String,status:int):Vector.<ProcessOpreateObject>
		{
			if(_opreater == null)
				getOpreater();
			var vec:Vector.<ProcessOpreateObject> = new Vector.<ProcessOpreateObject>();
			for(var i:int = 0;i < _opreater.length;i++)
			{
				var temp:ProcessOpreateObject = _opreater[i];
				if(temp.taskId == taskId && temp.stepId == stepId && temp.status == status)
				{
					vec.push(temp);
				}
			}
			return vec;
		}
		/**
		 * 根据taskId stepId 和 status 获取操作 
		 * @param taskId
		 * @param stepId
		 * @param status
		 * @return 
		 */		
		public static function getSingleOpreate(taskId:String,stepId:String,status:int):Vector.<ProcessOpreateObject>
		{
			var arr:Vector.<ProcessOpreateObject> = getSingleOpreater();
			var vec:Vector.<ProcessOpreateObject> = new Vector.<ProcessOpreateObject>();
			for(var i:int = 0;i < arr.length;i++)
			{
				var temp:ProcessOpreateObject = arr[i];
				if(temp.taskId == taskId && temp.stepId == stepId && temp.status == status)
				{
					vec.push(temp);
				}
			}
			return vec;
		}
		/**
		 * 用户是否有指定task和step的权限
		 * @param taskId
		 * @param stepId
		 * @param uid
		 * @return 
		 * 
		 */	
		public static function getRole(taskId:String,stepId:String,uid:String = ""):Boolean
		{			
			if(uid == "")
				uid = Version.Instance.uid
			var boolean:Boolean = false;
			var userRole:Vector.<RoleType> = UserInfoControl.Instance.getUserRoles();
			if(!userRole || userRole.length ==0)
				return boolean;
			var leng:Number = userRole.length;
			var roleId:String = ProcessInfo.Instance.stepObject(taskId,stepId).roleId;
			for(var i:int = 0;i < leng;i++)
			{
				var temp:RoleType = userRole[i];
				if(temp.roleId == roleId)
				{
					boolean = true;
					break;
				}
			}
			return boolean;
		}
		/**
		 *设置默认值
		 */		
		public static function setDefaultData():void
		{
			var array:Array = new Array(
				['1','申请','1','申请',0,'未提交','提交','起草','待提交'],
				['1','申请','1','申请',1,'已提交','同意','提交申请','待审核'],
				['1','申请','2','船长签字',0,'待签字','同意','部门同意','待审核'],
				['1','申请','2','船长签字',1,'已签字','同意','船长同意','待确认'],
				['1','申请','2','船长签字',2,'待审核','退回','船长退回','待提交'],
				['1','申请','2','船长签字',3,'未提交','废单','船长废单','已废单'],

				
				['2','批复','1','批复',0,'待批复','确认','提交申请','待确认'],
				['2','批复','1','批复',1,'已批复','退回','退单','待确认'],
				['2','批复','1','批复',2,'废单','废单','废单','已废单'],
				
				['3','审核','1','审核',0,'待审核','确认','提交申请','待确认'],
				['3','审核','1','审核',1,'已审核','派单','派单','待确认'],
				['3','审核','1','审核',2,'退单','退回','船长退回','待提交'],
				['3','批复','1','审核',3,'废单','废单','废单','已废单']
				
				
				
			);
			var vec:Vector.<ProcessDetailObject> = new Vector.<ProcessDetailObject>();
			for(var i:int = 0;i < array.length;i++)
			{
				var temp:ProcessDetailObject = ProcessDetailObject.parse(array[i] as Array);
				vec.push(temp);
			}
			_data = vec;
		}
		public static function getSingleOpreater():Vector.<ProcessOpreateObject>
		{
			var array:Array = new Array(
				['13','1',0,1,'询价'],
				['14','1',0,1,'直接订购'],
				['14','1',0,2,'比价订购'],
				['15','1',0,1,'验收']
			);
			var vec:Vector.<ProcessOpreateObject> = new Vector.<ProcessOpreateObject>();
			for(var i:int = 0;i < array.length;i++)
			{
				var temp:ProcessOpreateObject = ProcessOpreateObject.parse(array[i] as Array);
				vec.push(temp);
			}
			return vec;
		}
		/**
		 * 根据ID获取可操作ID
		 * 1 提交，同意 审核，确认；  2 退单；3 废单
		 * */
		public static function getOpreater():void
		{
			var array:Array = new Array(
				['1','1',0,1,'提交'],
				['1','1',2,1,'提交'],
				['1','2',0,1,'同意'],
//				['1','2',0,2,'退回'],
//				['1','2',0,3,'废单'],
//				['1','2',2,1,'同意'],
//				['1','2',2,3,'废单'],
//				['1','3',0,1,'同意'],
//				['1','3',0,2,'退回'],
//				['1','3',0,3,'废单'],
				
				
				['2','1',0,1,'确认'],
//				['2','1',0,2,'退回'],
//				['2','1',0,3,'废单'],
//				['2','1',2,1,'确认'],
//				['2','1',2,3,'废单'],
//				['2','2',0,1,'同意'],
//				['2','2',0,2,'退回'],
//				['2','2',0,3,'废单'],
//				['2','2',2,1,'同意'],
//				['2','2',2,3,'废单'],
				
				['3','1',0,1,'提交']
//				['3','1',2,1,'提交'],
//				['3','2',0,1,'同意'],
//				['3','2',0,2,'退回'],
//				['3','2',0,3,'废单'],
//				['3','2',2,1,'同意'],
//				['3','2',2,3,'废单'],
//				['3','3',0,1,'同意'],
//				['3','3',0,2,'退回'],
//				['3','3',0,3,'废单']
				
			);
			var vec:Vector.<ProcessOpreateObject> = new Vector.<ProcessOpreateObject>();
			for(var i:int = 0;i < array.length;i++)
			{
				var temp:ProcessOpreateObject = ProcessOpreateObject.parse(array[i] as Array);
				vec.push(temp);
			}
			_opreater = vec;
		}
		/**
		 * stepId排序
		 * */
		public static function stepSort(a:ProcessStepObject,b:ProcessStepObject):int
		{
			if(a.stepId > b.stepId)
				return 1;
			else if(a.stepId == b.stepId)
				return 0;
			else
				return -1;
		}
		/**
		 *操作信息 
		 */
		public static function get opreater():Vector.<ProcessOpreateObject>
		{
			return _opreater;
		}

		/**
		 * @private
		 */
		public static function set opreater(value:Vector.<ProcessOpreateObject>):void
		{
			_opreater = value;
		}

		
	}
}