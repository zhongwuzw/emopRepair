package com.boloomo.emop.repair.control
{
	import com.boloomo.common.BlmJSON;
	import com.boloomo.common.Network;
	import com.boloomo.common.Version;
	import com.boloomo.emop.component.EmopVersion;
	import com.boloomo.emop.component.load.LoadingControl;
	import com.boloomo.emop.component.type.BlmDropListItemObject;
	import com.boloomo.emop.repair.event.RepairListEvent;
	import com.boloomo.emop.repair.model.RepairListMgModel;
	import com.boloomo.emop.repair.type.EquipObject;
	import com.boloomo.emop.repair.type.ItemObj;
	import com.boloomo.emop.repair.type.RepairOrderObject;
	import com.boloomo.emop.repair.type.process.ProcessTaskObject;
	import com.boloomo.emop.repair.util.ProcessInfo;
	import com.boloomo.emop.repair.view.repairListManager.AddCWBTPanel;
	import com.boloomo.emop.repair.view.repairListManager.AddRepairListPanel;
	import com.boloomo.emop.repair.view.repairListManager.FinishedPanel;
	import com.boloomo.emop.repair.view.repairListManager.ProjectCodePanel;
	import com.boloomo.emop.repair.view.repairListManager.RepairListDetailsPanel;
	import com.boloomo.emop.repair.view.repairListManager.RepairListMgPanel;
	import com.boloomo.emop.userinfo.control.UserInfoControl;
	import com.boloomo.event.BlmEvent;
	import com.boloomo.event.BlmEventManager;
	import com.boloomo.util.AppUtil;
	import com.boloomo.util.StringUtils;
	import com.boloomo.util.maps.HashMap;
	
	import mx.collections.ArrayCollection;
	import mx.managers.PopUpManager;
	
	public class RepairListManagerControl
	{
		private var _applyMgPanel:RepairListMgPanel = null;	      //修理单列表界面						
		private var _applyDetailPanel:RepairListDetailsPanel = null;//修理单详细界面
		private var _saveMap:HashMap = new HashMap();				  //保存所有流程信息
		private var _projectCodepanel:ProjectCodePanel = null;	  //工程代码和工程名称界面
		private var _addCwbt:AddCWBTPanel;
		
		private var _repairOrderMap:HashMap=new HashMap();//储存修理单的所有数据
		private var _addPanel:AddRepairListPanel;			//添加修理单数据
		private var _data:HashMap;							//保存所有数据
		private var _detailObj:RepairOrderObject;
		private var _InsertObj:RepairOrderObject;
		private var _id:String = "";								//被删除的修理单的id
		private var finishPanel:FinishedPanel = null;
		private var _type:String;
		private var cwbtN:String;
		private var cwbt:String;
		private var shipid:String;
		private var shipna:String;
		
		private static var g_Instance:RepairListManagerControl = null;

		public function get addCwbt():AddCWBTPanel
		{
			return _addCwbt;
		}

		public function set addCwbt(value:AddCWBTPanel):void
		{
			_addCwbt = value;
		}

		public function get type():String
		{
			return _type;
		}

		public function set type(value:String):void
		{
			_type = value;
		}

		public static function get Instance():RepairListManagerControl{
			if(g_Instance == null){
				g_Instance = new RepairListManagerControl();
			}
			return g_Instance;
		}
		
		public function RepairListManagerControl()
		{
			if(g_Instance != null){
				throw new Error("Can't new SingletonFactory(),Please call getInstance()");
			}
			registtEventListener();
			initNetBack();
		}
		//事件监听
		public function registtEventListener():void{
			BlmEventManager.Instance.addEventListener(EmopToolEventType.EMOP_REPAIR_ORDER,onPanel);
			BlmEventManager.Instance.addEventListener(RepairListEvent.Repair_showAppDetailsPanel,onPanels);
			BlmEventManager.Instance.addEventListener(RepairListEvent.REPAIR_ADDTYPE,onUserLoginHandler);
			BlmEventManager.Instance.addEventListener(RepairListEvent.REPAIR_ADDREPAIRLISTPANEL,onAddPanel);
			BlmEventManager.Instance.addEventListener(RepairListEvent.REPAIR_DELREPAIRLIST,onDelRepairList);
			BlmEventManager.Instance.addEventListener(RepairListEvent.REPAIR_SAVEREPAIRLIST,onSaveFun);
			BlmEventManager.Instance.addEventListener(RepairListEvent.REPAIR_InsertRepairList,onInsertFun);
			BlmEventManager.Instance.addEventListener(RepairListEvent.REPAIR_SHOWPROJECTCODE,onShowProjectFun);
			BlmEventManager.Instance.addEventListener(RepairListEvent.REPAIR_ADDPROJECTINFO,onAddProjectInfoFun);
			BlmEventManager.Instance.addEventListener(RepairListEvent.REPAIR_FINISHREPAIRLIST,onFinishListInfoFun);
			BlmEventManager.Instance.addEventListener(RepairListEvent.REPAIR_SHOWFINISHPANEL,onShowFinishPanelFun);
			BlmEventManager.Instance.addEventListener(RepairListEvent.REPAIR_SHOWADDCWBTPANEL,onShowCwbtPanelFun);
			BlmEventManager.Instance.addEventListener(RepairListEvent.REPAIR_REQCWBT,onReqCwbt);
			BlmEventManager.Instance.addEventListener(RepairListEvent.REPAIR_ITEM_DELIVER_TO_REPAIRLIST,onProjectListPacket);

		}
		//回调函数
		public function initNetBack():void
		{
			Network.Instance.RegisterHandler(0x6311,onApplylistPacket);
			Network.Instance.RegisterHandler(0x6312,onApplyDetailPacket);
			Network.Instance.RegisterHandler(0x6313,onAddDetailPacket);
			Network.Instance.RegisterHandler(0x6314,onReqProjectInfoPacket);
			Network.Instance.RegisterHandler(0x6315,onChangeStatePacket);
			Network.Instance.RegisterHandler(0x6316,onDelDetailPacket);
//			Network.Instance.RegisterHandler(0x6303,onProjectListPacket);
//			Network.Instance.RegisterHandler(0x6305,onReqCwbtPacket);
//			Network.Instance.RegisterHandler(0x6307,onAddCwbtPacket);
		}	
		
		
		private function addNewRepairOrder():void
		{
			var shipId:String = addPanel.shipId;
			var taskId:String = "1";
			var stepId:String = "1";
	//		PurchaseModel.Instance.reqAddApply("apply",shipId,taskId,stepId);
		}
		
		
		/**
		 * 
		 * 修理单列表界面
		 * 
		 */		
		
		private function onPanel(e:BlmEvent):void
		{
			BlmEventManager.Instance.dispatchEvent(new BlmEvent(RepairListEvent.REPAIR_ADDTYPE));
			var obj:Object = e.data as Object;
			if(applyMgPanel == null || applyMgPanel.visible == false){
				applyMgPanel = RepairListMgPanel(PopUpManager.createPopUp(AppUtil.Instance.app,RepairListMgPanel,true));
			}
			applyMgPanel.shipVec = getUserShip(obj);
			applyMgPanel.departVec = getDepart(obj);
			applyMgPanel.taskVec = getTask();
			applyMgPanel.stepVec = getStep();
			applyMgPanel.statusVec = getStatus();
			applyMgPanel.typeVec = getType();
			applyMgPanel.visible = true;
			PopUpManager.centerPopUp(applyMgPanel);
			PopUpManager.bringToFront(applyMgPanel);
			LoadingControl.Instance.show(applyMgPanel);
		//	RepairModel.Instance.reqRepairOrder("123");
			RepairListMgModel.Instance.reqApplyList("seq11","blm123","","","","","","");
			
		}
		
		//解析修理单列表
		public function onApplylistPacket(json:String):void
		{
			if(StringUtils.startsWith('{eid:',json) || json == "[]")
			{
				trace(json);
				return;
			}
			var obj:Object = BlmJSON.decode(json); if(obj == null){return;}
			_data = new HashMap;
			var array:Array = obj.info;
			for(var i:int = 0;i < array.length;i++)
			{
				var temp:RepairOrderObject=RepairOrderObject.parse(array[i]);
				_data.put(temp.applyId,temp);
			}
			applyMgPanel.emop_data(_data);
			LoadingControl.Instance.hide();
		}
		
		/**
		 * 
		 * 修理单详细信息界面
		 * 
		 */		
		
		//创建详细信息界面
		private function onPanels(e:BlmEvent):void
		{
			var obj:RepairOrderObject = e.data as RepairOrderObject;
			detailObj = new RepairOrderObject();
			detailObj = obj;
			if(applyDetailPanel == null || applyDetailPanel.visible == false)
				applyDetailPanel = RepairListDetailsPanel(PopUpManager.createPopUp(AppUtil.Instance.app,RepairListDetailsPanel,true));
			applyDetailPanel.visible = true;
			applyDetailPanel.typeVec = getType();
			PopUpManager.centerPopUp(applyDetailPanel);
			RepairListMgModel.Instance.reqDetailsList("seq12",obj.applyId);
			PopUpManager.bringToFront(applyDetailPanel);
		}
		//设置详细信息数据
		public function onApplyDetailPacket(json:String):void
		{
			if(StringUtils.startsWith('{eid:',json) || json == "[]")
			{
				trace(json);
				return;
			}
			var obj:Object = BlmJSON.decode(json);
			if(obj == null){return;}
			
			detailObj.itemObj = ItemObj.parse(obj.item);
			applyDetailPanel.setDetails(detailObj);
			LoadingControl.Instance.hide();
		}
		
		/**
		 * 
		 * 添加信息界面
		 * 
		 */	
		private function onAddPanel(e:BlmEvent):void
		{
			var obj:Object = e.data as Object;
			 shipid = obj.shipId;
			 shipna = obj.shipName;
			RepairListMgModel.Instance.addDetailsList("seq130",0,"",obj.shipId,"","",1,"","","","","","","","","");
		}
		
		//修改修理单流程信息
		public function onChangeStatePacket(json:String):void
		{
			if(StringUtils.startsWith('{eid:',json) || json == "[]")
			{
				trace(json);
				return;
			}
			var obj:Object = BlmJSON.decode(json);
			if(obj == null){return;}
			if(addPanel != null && addPanel.visible == true){
				addPanel.refresh();
			}else{
				applyDetailPanel.refresh();
			}
		}
		
		
		//删除修理单
		private function onDelRepairList(e:BlmEvent):void
		{
			var obj:Object = e.data as Object;
			id = obj.id;
			RepairListMgModel.Instance.DelDetailsList("seq16",obj.id);
		}
		
		public function onDelDetailPacket(json:String):void
		{
			if(StringUtils.startsWith('{eid:',json) || json == "[]")
			{
				trace(json);
				return;
			}
			var obj:Object = BlmJSON.decode(json);
			if(obj == null){return;}
			if(applyDetailPanel != null){
				applyDetailPanel.visible = false;
				data.remove(id);
				applyMgPanel.changeData();
			}
		}
		
		private function onSaveFun(e:BlmEvent):void {
		
		var obj:RepairOrderObject = e.data as RepairOrderObject;
		detailObj = obj;
		RepairListMgModel.Instance.saveDetailsList("seq131",1,obj.applyId,obj.shipId,obj.departId,obj.type,obj.self,obj.companyId,obj.company,obj.adate,obj.bdate,obj.fdate,obj.location,obj.rbdate,obj.rfdate,obj.itemObj.itemId);
		}
		
		private function onInsertFun(e:BlmEvent):void {
			var obj:RepairOrderObject = e.data as RepairOrderObject;
			InsertObj = new RepairOrderObject();
			InsertObj = obj;
		}
		public function onAddDetailPacket(json:String):void
		{
			if(StringUtils.startsWith('{eid:',json) || json == "[]")
			{
				trace(json);
				return;
			}
			var obj:Object = BlmJSON.decode(json);
			if(obj == null){return;}
			if(obj.seq =="seq130"){
			var rListObj:RepairOrderObject = new RepairOrderObject();
			rListObj.proc = "1";
			rListObj.link = '1';
			rListObj.state = '0';
			rListObj.applyId = obj.applyid;
			
			if(addPanel == null || addPanel.visible == false){
				addPanel = AddRepairListPanel(PopUpManager.createPopUp(AppUtil.Instance.app,AddRepairListPanel,true));
			}
			addPanel.visible = true;
			if(shipid != null){
				addPanel.departVec = UserInfoControl.Instance.shipDeptList(shipid) as Vector.<BlmDropListItemObject>;
			}
			addPanel.typeVec = getType();
			addPanel.applyNo.text = obj.applyid;
			addPanel.shipId =  shipid;
			addPanel.shipName = shipna;
			addPanel.setDefData(rListObj);
			PopUpManager.centerPopUp(addPanel);
			PopUpManager.bringToFront(addPanel);
			}
			if(obj.seq =="seq131"){
				data.put(InsertObj.applyId,InsertObj)
				applyMgPanel.changeData();
				addPanel.visible = false;
				
			}
			if(applyDetailPanel != null){
				applyDetailPanel.setDetails(detailObj);
			}
		}
		
		
		private function onShowProjectFun(e:BlmEvent):void {
			
			var obj:Object = e.data as Object;
			if(projectCodepanel == null || projectCodepanel.visible == false){
				projectCodepanel = ProjectCodePanel(PopUpManager.createPopUp(AppUtil.Instance.app,ProjectCodePanel,true));
			}
			projectCodepanel.type = obj.type;
			projectCodepanel.visible = true;
			RepairListMgModel.Instance.reqProjectInfo("seq14",obj.shipid);
			PopUpManager.centerPopUp(projectCodepanel);
			PopUpManager.bringToFront(projectCodepanel);
		}		
		public function onReqProjectInfoPacket(json:String):void
		{
			if(StringUtils.startsWith('{eid:',json) || json == "[]")
			{
				trace(json);
				return;
			}
			var obj:Object = BlmJSON.decode(json);
			if(obj == null){return;}
			var array:Array = obj.info;
			var arr:ArrayCollection = new ArrayCollection();
			for(var i:int = 0;i < array.length;i++)
			{
				var temp:ItemObj = ItemObj.parse(array[i]);
				arr.addItem(temp)
			}
			projectCodepanel.setData(arr);
		}
		
		public function getTaskVector(type:int = 0):Vector.<ProcessTaskObject>
		{
			var vec:Vector.<ProcessTaskObject> = new Vector.<ProcessTaskObject>();
			var arr:Array = ProcessInfo.Instance.repairMap.getValues();
			var land:ProcessTaskObject;
			for(var i:int = 0;i < arr.length;i++)
			{
				var temp:ProcessTaskObject = arr[i] as ProcessTaskObject;
					vec.push(arr[i] as ProcessTaskObject);
			}
			return vec;
		}
		
		public function secondData(shipId:String,departId:String,type:String ,taskId:String,stepId:String,status:String):void
		{
			var vec:HashMap = new HashMap();
			var arr:Array = new Array();
			arr = _data.getValues();
			for(var i:int = 0;i < arr.length;i++)
			{
				var temp:RepairOrderObject = arr[i] as RepairOrderObject;
				if(temp.shipId != shipId && shipId != "")
					continue;
				if(departId != "" && departId != temp.departId)
					continue;
				if(type != "" && type != temp.type.toString())
					continue;
				if(taskId != "" && taskId != temp.proc)
					continue;
				if(stepId != "" && stepId != temp.link)
					continue;
				if(status !=  "" && status != temp.state)
					continue;
				vec.put(temp.applyId,temp);
			}
			applyMgPanel.emop_data(vec);
		}
		
		private function onAddProjectInfoFun(e:BlmEvent):void {
			var obj:Object = e.data as Object;
			type = obj.type;
			RepairListMgModel.Instance.repProjectList("seq03",obj.itemId);
		}
		
		public function onProjectListPacket(e:BlmEvent):void
		{
			var json:String = e.data as String;
			if(StringUtils.startsWith('{eid:',json) || json == "[]")
			{
				trace(json);
				return;
			}
			var obj:Object = BlmJSON.decode(json);
			if(obj == null){return;}
			var temp:ItemObj = ItemObj.parse(obj);
			if(type =="1"){
			   detailObj.itemObj = temp;
			   applyDetailPanel.setDetails(detailObj);
			 }
			if(type =="0"){
			addPanel.setData(temp);
			}
			projectCodepanel.visible = false;
		}
		public function onReqCwbtPacket(json:String):void
		{
			if(StringUtils.startsWith('{eid:',json) || json == "[]")
			{
				trace(json);
				return;
			}
			var obj:Object = BlmJSON.decode(json);
			if(obj == null){return;}
			
			if(cwbtN != null || cwbtN != ""){
				var obj1:Object = new Object();
				obj1.cwbt = cwbt;
				obj1.na = cwbtN;
				obj1.wcs = obj.wcs;
			}
			var obj2:Array = new Array();
			obj2.push(obj1);
			applyDetailPanel.arr.addItemAt(obj2,0);
			addCwbt.visible = false;
		}
		
	public function onAddCwbtPacket(json:String):void
	{
		if(StringUtils.startsWith('{eid:',json) || json == "[]")
		{
			trace(json);
			return;
		}
		var obj:Object = BlmJSON.decode(json);
		if(obj == null){return;}
		cwbtN = obj.na;
	}
		private function onShowFinishPanelFun(e:BlmEvent):void {
			var obj:Object = e.data as Object;
			if(finishPanel == null || finishPanel.visible == false){
				finishPanel = FinishedPanel(PopUpManager.createPopUp(AppUtil.Instance.app,FinishedPanel));
				finishPanel.visible = true;
				finishPanel.applyId = obj.applyid;
				finishPanel.sDate = obj.sDate;
				finishPanel.eDate = obj.eDate;
				PopUpManager.centerPopUp(finishPanel);
				PopUpManager.bringToFront(finishPanel);
			}
		}
		
		private function onShowCwbtPanelFun(e:BlmEvent):void {
			var obj:Object = e.data as Object;
			if(addCwbt == null || addCwbt.visible == false){
				addCwbt = AddCWBTPanel(PopUpManager.createPopUp(AppUtil.Instance.app,AddCWBTPanel,true));
				addCwbt.visible = true;
				addCwbt.shipid = obj.shipid;
				addCwbt.itemid = obj.itemid;
				PopUpManager.centerPopUp(addCwbt);
				PopUpManager.bringToFront(addCwbt);
			}
		}
		
		private function onFinishListInfoFun(e:BlmEvent):void {
			var obj:Object = e.data as Object;
		//	RepairListMgModel.Instance.onFinishListInfoFun("seq6325",obj.applyid,obj.sDate,obj.eDate);
		}
		private function onReqCwbt(e:BlmEvent):void {
			var obj:Object = e.data as Object;
			cwbt = obj.cwbt;
			
	//		RepairListMgModel.Instance.onAddCwbtInfo("seq6307",obj.itemid,obj.shipid,1,obj.cwbt);
			
	//		RepairListMgModel.Instance.onReqCwbtInfo("seq6305",obj.shipid,obj.cwbt);
		
		}
		
		

		private function getTask():Vector.<BlmDropListItemObject>
		{
			var taskVec:Vector.<BlmDropListItemObject> = new Vector.<BlmDropListItemObject>();
			var task:Vector.<ProcessTaskObject> = ProcessInfo.Instance.getTaskVector();
			for(var i:int = 0;i < task.length;i++)
			{
				var temp:ProcessTaskObject = task[i] as ProcessTaskObject;
				var tempList:BlmDropListItemObject = new BlmDropListItemObject();
				tempList.id = temp.taskId;
				tempList.label = temp.taskName;
				tempList.data = temp;
				taskVec.push(tempList);
			}
			var obj:BlmDropListItemObject = new BlmDropListItemObject();
			obj.id = "";
			obj.label = "所有流程";
			taskVec.unshift(obj);
			return taskVec;	
		}
		//step
		private function getStep():Vector.<BlmDropListItemObject>
		{
			var vec:Vector.<BlmDropListItemObject> = new Vector.<BlmDropListItemObject>();
			var obj:BlmDropListItemObject = new BlmDropListItemObject();
			obj.id = "";
			obj.label = "所有环节";
			vec.push(obj);
			return vec;
		}
		//status
		private function getStatus():Vector.<BlmDropListItemObject>
		{
			var vec:Vector.<BlmDropListItemObject> = new Vector.<BlmDropListItemObject>();
			var obj:BlmDropListItemObject = new BlmDropListItemObject();
			obj.id = "";
			obj.label = "所有状态";
			vec.push(obj);
			return vec;
		}
		private function getType():Vector.<BlmDropListItemObject>
		{
			var vec:Vector.<BlmDropListItemObject> = new Vector.<BlmDropListItemObject>();
			var obj:BlmDropListItemObject = new BlmDropListItemObject();
			obj.id = "";
			obj.label = "所有类型";
			vec.push(obj);
			
			obj = new BlmDropListItemObject();
			obj.id = '0';
			obj.label = '厂修'
			vec.push(obj);
			
			obj = new BlmDropListItemObject();
			obj.id = '1';
			obj.label = '航修'
			vec.push(obj);
			return vec;
		}
		
		
		private function getUserShip(shipObj:Object):Vector.<BlmDropListItemObject> 
		{
			var shipVec:Vector.<BlmDropListItemObject> = new Vector.<BlmDropListItemObject>(),obj:BlmDropListItemObject;
			if(Version.Instance.name == EmopVersion.EMOP_VERSION_LAND){
				obj = new BlmDropListItemObject();
				obj.id = "";
				obj.label = "所有船舶";
				shipVec.push(obj);
				var temp:Vector.<BlmDropListItemObject> = UserInfoControl.Instance.userShipList();
				for(var i:int=0;i<temp.length;i++){
					shipVec.push(temp[i]);
				}
			}else{
				obj = new BlmDropListItemObject();
				obj.id = shipObj.shipId;
				obj.label = shipObj.shipName;
				obj.data = shipObj;
				shipVec.push(obj);
			}
			return shipVec;
		}
		//部门
		private function getDepart(shipObj:Object):Vector.<BlmDropListItemObject>
		{
			var departVec:Vector.<BlmDropListItemObject> = new Vector.<BlmDropListItemObject>(),obj:BlmDropListItemObject;
			obj = new BlmDropListItemObject();
			obj.id = "";
			obj.label = "所有部门";
			if(Version.Instance.name == EmopVersion.EMOP_VERSION_SHIP)
				departVec = UserInfoControl.Instance.shipDeptList(shipObj.shipId) as Vector.<BlmDropListItemObject>;
			departVec.unshift(obj);
			return departVec;
		}
		
		private function onUserLoginHandler(e:BlmEvent):void
		{
//			var json:String = '{seq:"test",task:[{taskId:"1",taskName:"申请",detail:[{stepId:"1",sname:"编制",roleId:"1"},{stepId:"2",sname:"船长确认",roleId:"1"}]},{taskId:"2",taskName:"批复",detail:[{stepId:"1",sname:"批复",roleId:"1"}]},{taskId:"3",taskName:"审核",detail:[{stepId:"1",sname:"审核",roleId:"1"}]}]}';
//			onProcessPacket(json);
			ProcessInfo.Instance.onUserLoginHandler();
		}
		
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
				saveMap.put(taskObj.taskId,taskObj);
				
			}
			ProcessInfo.Instance.repairMap = saveMap;
		}
		

		public function taskObject(taskId:String):ProcessTaskObject
		{
			var obj:ProcessTaskObject,array:Array;
			array = saveMap.getValues();
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
		
		
		//////setter   getter  方法
		
		
		public function get applyDetailPanel():RepairListDetailsPanel
		{
			return _applyDetailPanel;
		}
		
		public function set applyDetailPanel(value:RepairListDetailsPanel):void
		{
			_applyDetailPanel = value;
		}
		
		public function get applyMgPanel():RepairListMgPanel
		{
			return _applyMgPanel;
		}
		
		public function set applyMgPanel(value:RepairListMgPanel):void
		{
			_applyMgPanel = value;
		}
		public function get saveMap():HashMap
		{
			return _saveMap;
		}
		
		public function set saveMap(value:HashMap):void
		{
			_saveMap = value;
		}
		public function get data():HashMap
		{
			return _data;
		}
		
		public function set data(value:HashMap):void
		{
			_data = value;
		}
		
		public function get addPanel():AddRepairListPanel
		{
			return _addPanel;
		}
		
		public function set addPanel(value:AddRepairListPanel):void
		{
			_addPanel = value;
		}
		public function get projectCodepanel():ProjectCodePanel
		{
			return _projectCodepanel;
		}
		
		public function set projectCodepanel(value:ProjectCodePanel):void
		{
			_projectCodepanel = value;
		}
		public function get detailObj():RepairOrderObject
		{
			return _detailObj;
		}
		
		public function set detailObj(value:RepairOrderObject):void
		{
			_detailObj = value;
		}
		
		public function get InsertObj():RepairOrderObject
		{
			return _InsertObj;
		}
		
		public function set InsertObj(value:RepairOrderObject):void
		{
			_InsertObj = value;
		}
		public function get id():String
		{
			return _id;
		}
		
		public function set id(value:String):void
		{
			_id = value;
		}


	}
}