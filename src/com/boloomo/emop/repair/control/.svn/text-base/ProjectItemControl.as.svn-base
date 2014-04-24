package com.boloomo.emop.repair.control
{
	
	import com.boloomo.common.BlmJSON;
	import com.boloomo.common.Network;
	import com.boloomo.emop.component.prompt.PromptEvent;
	import com.boloomo.emop.component.prompt.promrtWindow;
	import com.boloomo.emop.repair.model.RepairModel;
	import com.boloomo.emop.repair.type.ApplyObject;
	import com.boloomo.emop.repair.type.ProjectOrderObject;
	import com.boloomo.emop.repair.view.EngineerID.EngineerIDFactoryRepairInfo;
	import com.boloomo.emop.repair.view.EngineerID.EngineerIDManage;
	import com.boloomo.emop.repair.view.EngineerID.EngineerIDPanel;
	import com.boloomo.emop.repair.view.EngineerID.EngineerIDPanelAdd;
	import com.boloomo.emop.repair.view.EngineerID.EngineerRepairIDManage;
	import com.boloomo.event.BlmEvent;
	import com.boloomo.event.BlmEventManager;
	import com.boloomo.util.AppUtil;
	import com.boloomo.util.TimeUtil;
	import com.boloomo.util.maps.HashMap;
	
	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;
	import mx.managers.PopUpManager;
	
	/**
	 *修船管理 控制类
	 * @author zhongwu
	 * 
	 */	
	public class ProjectItemControl
	{
		private static var g_Instance:ProjectItemControl = null;
		
		private var _projectOrderMap:HashMap=new HashMap();//储存工程单的所有数据
		private var _currentProjectOrder:ProjectOrderObject=new ProjectOrderObject();//储存当前点击的工程单 只提供set函数.请在每次点击不同修理单时赋值。并在重新请求时clear。并且在修改或者新增时在此赋值，注意新增时要先clear，并在刷新时判断是否有id
		private var _applyListMap:HashMap=new HashMap();//某船舶的未派工程单的且状态为未开始的修理单列表
		private var _tempApplyListMap:HashMap = new HashMap();
		
		
		
		private var _engineerDetailPanel:EngineerIDPanel=null;	
		private var _engineerId:String;
		public var engineerIDManage:EngineerIDManage = null;
		public var engineerIDPanelAdd:EngineerIDPanelAdd = null;
		public var engineerRepairID:EngineerRepairIDManage = null;
		public var EngineerIDFactoryPlan:EngineerIDFactoryRepairInfo = null;
		private var promrt:promrtWindow;
		
		public function ProjectItemControl()
		{
			if(g_Instance != null)
				throw new Error("error.......");
			BlmEventManager.Instance.addEventListener(RepairEventType.EMOP_ENGINEER_ID,showApplyDetailPanel);
			BlmEventManager.Instance.addEventListener(EmopToolEventType.EMOP_REPAIR_PROJECT,ShowEngineerIDManage);
			BlmEventManager.Instance.addEventListener(RepairEventType.EMOP_ENGINEER_ID_ADD,onHandleEngineerAdd);
					
			Network.Instance.RegisterHandler(0x6321,onHandleProjectOrder);
			Network.Instance.RegisterHandler(0x6322,onHandleDetailProjectOrder);
			Network.Instance.RegisterHandler(0x6323,onHandleAddModProjectOrder);
			Network.Instance.RegisterHandler(0x6324,onHandleApplyList);
			Network.Instance.RegisterHandler(0x6325,onHandleFufillProjectOrder);
			Network.Instance.RegisterHandler(0x6326,onHandleDelProjectOrder);
			
		}
		
		//请求删除工程单下的修理单
		public function onHandleDeleteRepairID(obj:Object):void
		{
			obj = obj as ApplyObject;
			_currentProjectOrder.applyMap.remove(obj.applyid);
			RepairModel.Instance.reqAddModProjectOrder("admin","1",_currentProjectOrder);
		}

		//请求工程单管理界面的厂修计划
		public function reqEngineerFactoryPlan(obj:ProjectOrderObject):void
		{
			if(EngineerIDFactoryPlan == null || EngineerIDFactoryPlan.visible ==false)
				EngineerIDFactoryPlan = EngineerIDFactoryRepairInfo(PopUpManager.createPopUp(AppUtil.Instance.app,EngineerIDFactoryRepairInfo,true));
			EngineerIDFactoryPlan.visible = true;
			PopUpManager.centerPopUp(EngineerIDFactoryPlan);
			PopUpManager.bringToFront(EngineerIDFactoryPlan);
			EngineerIDFactoryPlan.factoryPlan.text = obj.facna;
		}
		
		//请求工程单中修理单列表的完成
		public function reqEngineerIDRepairFin(obj:ApplyObject,startNum:Date,endNum:Date):void
		{
			//obj.st = 2;
			
			/*		data.st = 2;*/
			RepairModel.Instance.reqFufillProjectOrder(obj.applyid,startNum,endNum);
			//	RepairControl.Instance.reqRefreshList();
		}
		
		//请求删除工程单
		public function reqDelProjectID():void
		{
			RepairModel.Instance.reqDelProjectOrder("admin",_currentProjectOrder.proId);
		}
		
		//工程单详细界面的列表的刷新
		public function reqRefreshList():void
		{
			//_engineerDetailPanel.fakeList.refresh();
			RepairModel.Instance.reqProjectOrder("admin");
			
		}
		
		//处理工程单新增
		public function onHandleEngineerAdd(e:BlmEvent):void
		{
			if(engineerIDPanelAdd==null || engineerIDPanelAdd.visible == false)
				engineerIDPanelAdd = EngineerIDPanelAdd(PopUpManager.createPopUp(AppUtil.Instance.app,EngineerIDPanelAdd,true));
			
			engineerIDPanelAdd.visible = true;
			PopUpManager.centerPopUp(engineerIDPanelAdd);
			PopUpManager.bringToFront(engineerIDPanelAdd);
		}
		
		//工程单详情界面保存修改后的信息
		public function reqSaveEngineerInfo():void
		{
			//_currentProjectOrder.proId = _engineerDetailPanel.projectID1.text;
			//	_currentProjectOrder.state = _engineerDetailPanel.state1.text;
			//_currentProjectOrder.myState = _engineerDetailPanel.state1.text;
			//	_currentProjectOrder.type = _engineerDetailPanel.repairKind1.text;
			//	_currentProjectOrder.myType = _engineerDetailPanel.repairKind1.text;
			_currentProjectOrder.myType = _engineerDetailPanel.repairKind1.blm_selected().label;
			/*_currentProjectOrder.myType = _engineerDetailPanel.repairKind1.blm_selected().label;*/
			_currentProjectOrder.location = _engineerDetailPanel.repairLoc1.text;
			_currentProjectOrder.company = _engineerDetailPanel.company1.text;
			//			_currentProjectOrder.plan = _engineerDetailPanel.facplan1.text;
			_currentProjectOrder.alert = _engineerDetailPanel.reason.text;
			_currentProjectOrder.psday = _engineerDetailPanel.plan1.blm_getSelectDate();
			_currentProjectOrder.pfday = _engineerDetailPanel.plan3.blm_getSelectDate();
			_currentProjectOrder.asday = _engineerDetailPanel.realPlan1.blm_getSelectDate();
			_currentProjectOrder.afday = _engineerDetailPanel.realPlan3.blm_getSelectDate();
			
			saveEngineerCheckboxInfo();	
			RepairModel.Instance.reqAddModProjectOrder("admin","1",_currentProjectOrder);
		}
		
		//新增工程单时的保存操作
		public function reqAddSaveInfo():void
		{
			_currentProjectOrder.shipName = engineerIDPanelAdd.shipName1.blm_selected().label;
			_currentProjectOrder.shipId = engineerIDPanelAdd.shipName1.blm_selected().id;
	/*		_currentProjectOrder.proId = engineerIDPanelAdd.projectID1.text;*/
			//	_currentProjectOrder.state = _engineerDetailPanel.state1.text;
			_currentProjectOrder.myState = "未开始";
			//	_currentProjectOrder.type = _engineerDetailPanel.repairKind1.text;
			//	_currentProjectOrder.myType = engineerIDPanelAdd.repairKind1.text;
			_currentProjectOrder.myType = engineerIDPanelAdd.repairKind1.blm_selected().label;
			_currentProjectOrder.location = engineerIDPanelAdd.repairLoc1.text;
			_currentProjectOrder.company = engineerIDPanelAdd.company1.text;
			//			_currentProjectOrder.plan = _engineerDetailPanel.facplan1.text;
			_currentProjectOrder.alert = engineerIDPanelAdd.reason.text;
			
			_currentProjectOrder.psday = engineerIDPanelAdd.plan1.blm_getSelectDate();
			_currentProjectOrder.pfday = engineerIDPanelAdd.plan3.blm_getSelectDate();
			_currentProjectOrder.asday = engineerIDPanelAdd.realPlan1.blm_getSelectDate();
			_currentProjectOrder.afday = engineerIDPanelAdd.realPlan3.blm_getSelectDate();
			
			saveEngineerCheckboxInfo1();	
			RepairModel.Instance.reqAddModProjectOrder("admin","0",_currentProjectOrder);
		}
		
		public function saveEngineerCheckboxInfo1():void
		{
			var tmpArray:Array = new Array();
			var tempCount:int = 0;
			if(engineerIDPanelAdd.urgency.selected)
			{
				tmpArray[tempCount] = "1";
				tempCount++;
			}
			if(engineerIDPanelAdd.ca.selected)
			{
				tmpArray[tempCount] = "2";
				tempCount++;
			}
			if(engineerIDPanelAdd.ca0.selected)
			{
				tmpArray[tempCount] = "3";
				tempCount++;
			}
			if(engineerIDPanelAdd.ca1.selected)
			{
				tmpArray[tempCount] = "4";
				tempCount++;
			}
			if(engineerIDPanelAdd.ca2.selected)
			{
				tmpArray[tempCount] = "5";
				tempCount++;
			}
			if(engineerIDPanelAdd.ca3.selected)
			{
				tmpArray[tempCount] = "6";
				tempCount++;
			}
			if(engineerIDPanelAdd.ca4.selected)
			{
				tmpArray[tempCount] = "7";
				tempCount++;
			}
			if(engineerIDPanelAdd.ca5.selected)
			{
				tmpArray[tempCount] = "8";
				tempCount++;
			}
			if(engineerIDPanelAdd.ca6.selected)
			{
				tmpArray[tempCount] = "9";
				tempCount++;
			}
			if(engineerIDPanelAdd.ca7.selected)
			{
				tmpArray[tempCount] = "10";
				tempCount++;
			}
			if(engineerIDPanelAdd.ca8.selected)
			{
				tmpArray[tempCount] = "11";
				tempCount++;
			}
			if(engineerIDPanelAdd.ca9.selected)
			{
				tmpArray[tempCount] = "12";
				tempCount++;
			}
			if(engineerIDPanelAdd.ca10.selected)
			{
				tmpArray[tempCount] = "13";
				tempCount++;
			}
			if(engineerIDPanelAdd.ca11.selected)
			{
				tmpArray[tempCount] = "14";
				tempCount++;
			}
			if(engineerIDPanelAdd.ca12.selected)
			{
				tmpArray[tempCount] = "15";
				tempCount++;
			}
			if(engineerIDPanelAdd.ca13.selected)
			{
				tmpArray[tempCount] = "16";
				tempCount++;
			}
			
			_currentProjectOrder.illuArray = tmpArray;
		}
		
		public function saveEngineerCheckboxInfo():void
		{
			var tmpArray:Array = new Array();
			var tempCount:int = 0;
			if(_engineerDetailPanel.urgency.selected)
			{
				tmpArray[tempCount] = "1";
				tempCount++;
			}
			if(_engineerDetailPanel.ca.selected)
			{
				tmpArray[tempCount] = "2";
				tempCount++;
			}
			if(_engineerDetailPanel.ca0.selected)
			{
				tmpArray[tempCount] = "3";
				tempCount++;
			}
			if(_engineerDetailPanel.ca1.selected)
			{
				tmpArray[tempCount] = "4";
				tempCount++;
			}
			if(_engineerDetailPanel.ca2.selected)
			{
				tmpArray[tempCount] = "5";
				tempCount++;
			}
			if(_engineerDetailPanel.ca3.selected)
			{
				tmpArray[tempCount] = "6";
				tempCount++;
			}
			if(_engineerDetailPanel.ca4.selected)
			{
				tmpArray[tempCount] = "7";
				tempCount++;
			}
			if(_engineerDetailPanel.ca5.selected)
			{
				tmpArray[tempCount] = "8";
				tempCount++;
			}
			if(_engineerDetailPanel.ca6.selected)
			{
				tmpArray[tempCount] = "9";
				tempCount++;
			}
			if(_engineerDetailPanel.ca7.selected)
			{
				tmpArray[tempCount] = "10";
				tempCount++;
			}
			if(_engineerDetailPanel.ca8.selected)
			{
				tmpArray[tempCount] = "11";
				tempCount++;
			}
			if(_engineerDetailPanel.ca9.selected)
			{
				tmpArray[tempCount] = "12";
				tempCount++;
			}
			if(_engineerDetailPanel.ca10.selected)
			{
				tmpArray[tempCount] = "13";
				tempCount++;
			}
			if(_engineerDetailPanel.ca11.selected)
			{
				tmpArray[tempCount] = "14";
				tempCount++;
			}
			if(_engineerDetailPanel.ca12.selected)
			{
				tmpArray[tempCount] = "15";
				tempCount++;
			}
			if(_engineerDetailPanel.ca13.selected)
			{
				tmpArray[tempCount] = "16";
				tempCount++;
			}
			
			_currentProjectOrder.illuArray = tmpArray;
		}
		
		//显示工程单详细信息
		private function showApplyDetailPanel(e:BlmEvent):void{
			_currentProjectOrder = e.data as ProjectOrderObject;
			if(_engineerDetailPanel==null || _engineerDetailPanel.visible == false)
				_engineerDetailPanel = EngineerIDPanel(PopUpManager.createPopUp(AppUtil.Instance.app,EngineerIDPanel,true));
			
			_engineerDetailPanel.visible = true;
			PopUpManager.centerPopUp(_engineerDetailPanel);
			PopUpManager.bringToFront(_engineerDetailPanel);
			refreshEngineerIDPanel(_currentProjectOrder);
			
		}
		//更新工程单详情界面的信息
		public function refreshEngineerIDPanel(obj:ProjectOrderObject):void
		{
			_engineerDetailPanel.shipName.text = obj.shipName;
			_engineerDetailPanel.projectID.text = obj.proId;
			//	_engineerDetailPanel.state.text = obj.state;
			_engineerDetailPanel.state.text = obj.myState;
			//	_engineerDetailPanel.repairKind.text = obj.type;
			_engineerDetailPanel.repairKind.text = obj.myType;
			_engineerDetailPanel.repairLoc.text = obj.location;
			_engineerDetailPanel.plan.text = TimeUtil.getTimeStr(obj.psday,"YYYY-MM-DD");
			_engineerDetailPanel.plan2.text = TimeUtil.getTimeStr(obj.pfday,"YYYY-MM-DD");
			_engineerDetailPanel.realPlan.text = TimeUtil.getTimeStr(obj.asday,"YYYY-MM-DD");
			_engineerDetailPanel.realPlan2.text = TimeUtil.getTimeStr(obj.afday,"YYYY-MM-DD");
			_engineerDetailPanel.company.text = obj.company;
			_engineerDetailPanel.facplan.text = obj.facid;
			//			_engineerDetailPanel.facplan.text = obj.plan;
			_engineerDetailPanel.reason.text = obj.alert;
			_engineerDetailPanel.repairDate.text = obj.myplandate;
			_engineerDetailPanel.aheadDate.text = obj.myplanahead;
			_engineerDetailPanel.repairDate2.text = obj.myrealdate;
			_engineerDetailPanel.saveTime.text = obj.myrealahead;
			refreshEngineerIDList(obj);
			refreshEngineerCheckBoxInfo(obj);
		}
		
		//更新工程单详细界面的下面的列表
		public function refreshEngineerIDList(obj:ProjectOrderObject):void
		{
			_engineerDetailPanel.fakeList = new ArrayCollection(obj.applyMap.getValues());
		}
		
		//新增工程单之后的点击保存的刷新界面
		public function refreshEngineerIDAddPanel(obj:ProjectOrderObject):void
		{
			engineerIDPanelAdd.shipName.text = obj.shipName;
			engineerIDPanelAdd.projectID.text = obj.proId;
			//	engineerIDPanelAdd.state.text = obj.state;
			engineerIDPanelAdd.state.text = obj.myState;
			//	engineerIDPanelAdd.repairKind.text = obj.type;
			engineerIDPanelAdd.repairKind.text = obj.myType;
			engineerIDPanelAdd.repairLoc.text = obj.location;
			engineerIDPanelAdd.plan.text = TimeUtil.getTimeStr(obj.psday,"YYYY-MM-DD");
			engineerIDPanelAdd.plan2.text = TimeUtil.getTimeStr(obj.pfday,"YYYY-MM-DD");
			engineerIDPanelAdd.realPlan.text = TimeUtil.getTimeStr(obj.asday,"YYYY-MM-DD");
			engineerIDPanelAdd.realPlan2.text = TimeUtil.getTimeStr(obj.afday,"YYYY-MM-DD");
			engineerIDPanelAdd.company.text = obj.company;
			engineerIDPanelAdd.facplan.text = obj.facid;
			//			engineerIDPanelAdd.facplan.text = obj.plan;
			engineerIDPanelAdd.reason.text = obj.alert;
			engineerIDPanelAdd.repairDate.text = obj.myplandate;
			engineerIDPanelAdd.aheadDate.text = obj.myplanahead;
			engineerIDPanelAdd.repairDate2.text = obj.myrealdate;
			engineerIDPanelAdd.saveTime.text = obj.myrealahead;
			refreshEngineerCheckBoxInfo1(obj);
		}
		
		public function refreshEngineerCheckBoxInfo1(obj:ProjectOrderObject):void
		{
			for(var i:int = 0;i < obj.illuArray.length;i++)
			{
				var tempstr:String = obj.illuArray[i];
				switch(tempstr)
				{
					case "1":
						engineerIDPanelAdd.urgency.selected = true;
						break;
					case "2":
						engineerIDPanelAdd.ca.selected = true;
						break;
					case "3":
						engineerIDPanelAdd.ca0.selected = true;
						break;
					case "4":
						engineerIDPanelAdd.ca1.selected = true;
						break;
					case "5":
						engineerIDPanelAdd.ca2.selected = true;
						break;
					case "6":
						engineerIDPanelAdd.ca3.selected = true;
						break;
					case "7":
						engineerIDPanelAdd.ca4.selected = true;
						break;
					case "8":
						engineerIDPanelAdd.ca5.selected = true;
						break;
					case "9":
						engineerIDPanelAdd.ca6.selected = true;
						break;
					case "10":
						engineerIDPanelAdd.ca7.selected = true;
						break;
					case "11":
						engineerIDPanelAdd.ca8.selected = true;
						break;
					case "12":
						engineerIDPanelAdd.ca9.selected = true;
						break;
					case "13":
						engineerIDPanelAdd.ca10.selected = true;
						break;
					case "14":
						engineerIDPanelAdd.ca11.selected = true;
						break;
					case "15":
						engineerIDPanelAdd.ca12.selected = true;
						break;
					case "16":
						engineerIDPanelAdd.ca13.selected = true;
						break;
				}
			}
		}
		
		//更新工程单详情界面的checkbox的信息
		public function refreshEngineerCheckBoxInfo(obj:ProjectOrderObject):void
		{
			for(var i:int = 0;i < obj.illuArray.length;i++)
			{
				var tempstr:String = obj.illuArray[i];
				switch(tempstr)
				{
					case "1":
						_engineerDetailPanel.urgency.selected = true;
						break;
					case "2":
						_engineerDetailPanel.ca.selected = true;
						break;
					case "3":
						_engineerDetailPanel.ca0.selected = true;
						break;
					case "4":
						_engineerDetailPanel.ca1.selected = true;
						break;
					case "5":
						_engineerDetailPanel.ca2.selected = true;
						break;
					case "6":
						_engineerDetailPanel.ca3.selected = true;
						break;
					case "7":
						_engineerDetailPanel.ca4.selected = true;
						break;
					case "8":
						_engineerDetailPanel.ca5.selected = true;
						break;
					case "9":
						_engineerDetailPanel.ca6.selected = true;
						break;
					case "10":
						_engineerDetailPanel.ca7.selected = true;
						break;
					case "11":
						_engineerDetailPanel.ca8.selected = true;
						break;
					case "12":
						_engineerDetailPanel.ca9.selected = true;
						break;
					case "13":
						_engineerDetailPanel.ca10.selected = true;
						break;
					case "14":
						_engineerDetailPanel.ca11.selected = true;
						break;
					case "15":
						_engineerDetailPanel.ca12.selected = true;
						break;
					case "16":
						_engineerDetailPanel.ca13.selected = true;
						break;
				}
			}
		}
		
		//工程单详情界面编辑放弃处理
		public function reqQuitEditInfo():void
		{
			var event:FlexEvent;
			_engineerDetailPanel.blmtitlewindow1_creationCompleteHandler(event);
			refreshEngineerIDPanel(_currentProjectOrder);
		}
		
		//工程单中的修理单管理
		public function reqEngineerRepairIDManage():void
		{
			var tempInt:int = _currentProjectOrder.state as int;
			RepairModel.Instance.reqApplyObject(_currentProjectOrder.shipId,tempInt);
		}
		
		//保存工程单详细信息界面的下面列表的管理
		public function reqSaveEngineerManage(obj:Object,flag:Boolean):void
		{
			if(flag == false)
				reqDeleteRepairID(obj);
			else
				reqAddRepairID(obj);
		}
		
		public function reqSubmitOperation():void
		{
			var tempHashList:ArrayCollection = new ArrayCollection(_tempApplyListMap.getValues());
			for(var i:int = 0;i < tempHashList.length;i++)
			{
				_currentProjectOrder.applyMap.put(tempHashList[i].applyid,tempHashList[i]);
			}
			
			RepairModel.Instance.reqAddModProjectOrder("admin","1",_currentProjectOrder);
		}
		
		public function reqAddRepairID(obj:Object):void
		{
			this._tempApplyListMap.put(obj.applyid,obj);
		}
		
		public function reqDeleteRepairID(obj:Object):void
		{
			this._tempApplyListMap.remove(obj.applyid);
		}
		
		//新增工程单时编辑操作
		public function reqAddEditEngineer():void
		{
			engineerIDPanelAdd.setEditEnable();
		}
		
		//工程单详情界面点击编辑进行操作
		public function reqEditEnginnerInfo():void
		{
			_engineerDetailPanel.setEditEnable();
			resetTextinputInfo();
		}
		
		//将textinput设为默认值
		public function resetTextinputInfo():void
		{
			//_engineerDetailPanel.projectID1.text = _engineerDetailPanel.projectID.text;
			//_engineerDetailPanel.state1.text = _engineerDetailPanel.state.text;
			//	_engineerDetailPanel.repairKind1.text = _engineerDetailPanel.repairKind.text;
			_engineerDetailPanel.repairLoc1.text = _engineerDetailPanel.repairLoc.text;
			_engineerDetailPanel.company1.text = _engineerDetailPanel.company.text;
			/*_engineerDetailPanel.facplan1.text = _engineerDetailPanel.facplan.text;*/
			_engineerDetailPanel.plan1.blm_setDefaultDate(resetEngineerIDDate(_engineerDetailPanel.plan.text));
			_engineerDetailPanel.plan3.blm_setDefaultDate(resetEngineerIDDate(_engineerDetailPanel.plan2.text));
			_engineerDetailPanel.realPlan1.blm_setDefaultDate(resetEngineerIDDate(_engineerDetailPanel.realPlan.text));
			_engineerDetailPanel.realPlan3.blm_setDefaultDate(resetEngineerIDDate(_engineerDetailPanel.realPlan2.text));
			//_engineerDetailPanel.plan1.text = _engineerDetailPanel.plan.text;
			if(_currentProjectOrder.type != '')
				_engineerDetailPanel.repairKind1.blm_selectId(_currentProjectOrder.type);
			else
				_engineerDetailPanel.repairKind1.blm_selectId('0');
			
		}
		
		public function resetEngineerIDDate(tempString:String):Date
		{
			var tempArray:Array = tempString.split("-");
			var tempDate:Date = new Date();
			tempDate.fullYear = tempArray[0];
			tempDate.month = parseInt(tempArray[1]) - 1;
			tempDate.date = tempArray[2];
			return tempDate;
		}
		
		//显示工程单管理界面
		public function ShowEngineerIDManage(e:BlmEvent):void
		{
			if(engineerIDManage == null || engineerIDManage.visible == false)
			{
				engineerIDManage = EngineerIDManage(PopUpManager.createPopUp(AppUtil.Instance.app,EngineerIDManage,true));
				
			}
			engineerIDManage.visible = true;
			PopUpManager.centerPopUp(engineerIDManage);
			PopUpManager.bringToFront(engineerIDManage);
		}
		
		public static function get Instance():ProjectItemControl
		{
			if(g_Instance == null)
				g_Instance = new ProjectItemControl();
			return g_Instance;
		}	
		
		/**
		 *工程单请求解析
		 * 数据解析储存在projectOrderMap中
		 */	
		//		{seq：“”，info：[{proid：“”，shipid：“”，type：“”，state：“”，loc：“”，date：，day：“”，bday：，fday：，com：“”，plan：“”，alert：“”，illu：“a|b|c|d”，applyid：“a01|a02|a03”，statede：[{fn:””,fc:””,ft:,fr:””,fs:””},{},{}],itinfo：[{itemid：“”，itemn：“”，content：“”},{ itemid：“”，itemn：“”，content：“”}]},{}]}
		public function onHandleProjectOrder(jasonStr:String):void
		{
			trace("abcdefghijklmn");
			trace(jasonStr);
			var obj:Object = BlmJSON.decode(jasonStr); if(obj == null){return;}
			if(obj.eid)
				return;
			var tempProjectArray:Array=obj.info;
			this._projectOrderMap.clear();
			for(var i:int=0;i<tempProjectArray.length;i++)
			{
				var tempProjectOrderObj:ProjectOrderObject=ProjectOrderObject.parse(tempProjectArray[i]);
				this._projectOrderMap.put(tempProjectOrderObj.proId,tempProjectOrderObj);
			}
			this.refreshProjectOrder();
		}
		
		/**
		 *工程单详细信息请求解析
		 * 数据解析储存在projectOrderMap中
		 */	
		
		public function onHandleDetailProjectOrder(jasonStr:String):void
		{
			//			{seq：“”，proid：“”，shipid：“”，shipna:””,type：“”，state：“”，loc：“”，psday:1000,pfday:1000,asday:1000,afday:1000, pdays:1.1,adays:2.1,comid：“”，comna:””, facid:””, facna：“”，alert：“”，illu：“1|2|3|4”，applyinfo：[{applyid:””,itemid：“”，itemn：“”，content：“”，adate:,bdate:,fdate:,st:}] }
			trace("_______________________________________++++++++++++++++++++++");
			trace(jasonStr);
			var obj:Object = BlmJSON.decode(jasonStr); if(obj == null){return;}
			if(obj.eid)
				return;
			var tempProjectObj:ProjectOrderObject=ProjectOrderObject.parse(obj);
			var tempApplyArray:Array=obj.applyinfo;
			for(var i:int=0;i<tempApplyArray.length;i++)
			{
				var tempApplyObj:ApplyObject=ApplyObject.parse(tempApplyArray[i]);
				tempProjectObj.applyMap.put(tempApplyObj.applyid,tempApplyObj);
			}
			this._projectOrderMap.remove(this._currentProjectOrder.proId);
			this._projectOrderMap.put(tempProjectObj.proId,tempProjectObj);
			this._currentProjectOrder = tempProjectObj;
			
			this.refreshDetailProjectOrder();
		}
		
		//当下拉列表变化时进行信息的更新for工程单管理
		public function FilterLeftInfo(shipRepairID:String,stateId:String,kindId:String):void
		{
			engineerIDManage.shipRepairList.removeAll();
			var shipRepairChangeArr:Array = _projectOrderMap.getValues();
			
			for(var a:int = 0;a < shipRepairChangeArr.length;a++)
			{
				var repairOrderObject1:ProjectOrderObject = new ProjectOrderObject();
				repairOrderObject1 = shipRepairChangeArr[a] as ProjectOrderObject;
				if(shipRepairID == "allShip" && stateId != "3" && kindId != "2")
				{
					if(repairOrderObject1.state == stateId && kindId == repairOrderObject1.type)
						engineerIDManage.shipRepairList.addItem(repairOrderObject1);
				}
				else if(shipRepairID != "allShip" && stateId == "3" && kindId != "2")
				{
					if(repairOrderObject1.shipId == shipRepairID && repairOrderObject1.type == kindId)
						engineerIDManage.shipRepairList.addItem(repairOrderObject1);
				}
				else if(shipRepairID != "allShip" && stateId != "3" && kindId == "2")
				{
					if(repairOrderObject1.shipId == shipRepairID && repairOrderObject1.state == stateId)
						engineerIDManage.shipRepairList.addItem(repairOrderObject1);
				}
				else if(shipRepairID == "allShip" && stateId == "3" && kindId != "2")
				{
					if(repairOrderObject1.type == kindId)
						engineerIDManage.shipRepairList.addItem(repairOrderObject1);
				}
				else if(shipRepairID == "allShip" && stateId != "3" && kindId == "2")
				{
					if(repairOrderObject1.state == stateId)
						engineerIDManage.shipRepairList.addItem(repairOrderObject1);
				}
				else if(shipRepairID != "allShip" && stateId == "3" && kindId == "2")
				{
					if(repairOrderObject1.shipId == shipRepairID)
						engineerIDManage.shipRepairList.addItem(repairOrderObject1);
				}
				else if(shipRepairID == "allShip" && stateId == "3" && kindId == "2")
				{
					engineerIDManage.shipRepairList.addItem(repairOrderObject1);
				}
				else if(shipRepairID != "allShip" && stateId != "3" && kindId != "2")
				{
					if(repairOrderObject1.shipId == shipRepairID && repairOrderObject1.type == kindId && repairOrderObject1.state == stateId)
						engineerIDManage.shipRepairList.addItem(repairOrderObject1);
				}
			}
			engineerIDManage.shipRepairList.refresh();
			engineerIDManage.table.selectedIndex = 0;
			
		}	
		
		/**
		 *工程单新增或者修改解析
		 * 新增和修改的修理单存在_currentProjectOrder中 新增之前记得clear
		 */	
		//		{seq：“”，eid：，dis：“”，proid：“”}
		public function onHandleAddModProjectOrder(jasonStr:String):void
		{
		    var promrtAddSuccess:promrtWindow; 
			var promrtEditSuccess:promrtWindow;
			var obj:Object = BlmJSON.decode(jasonStr); if(obj == null){return;}
			if(obj.eid!=0)
			{
				if(obj.seq=="0")
					this.refreshProjectOrder();
				else if(obj.seq=="1")
					this.refreshProjectOrder();
				return;
			}
			if(obj.seq=="0")
			{
				promrtAddSuccess = promrtWindow(PopUpManager.createPopUp(AppUtil.Instance.app,promrtWindow,true));
				promrtAddSuccess.show(PromptEvent.ALERT,'添加成功！');
				PopUpManager.centerPopUp(promrtAddSuccess);
				promrtAddSuccess.visible = true;
				this._currentProjectOrder.proId=obj.proid;
				this._projectOrderMap.put(_currentProjectOrder.proId,_currentProjectOrder);
				//this.refreshProjectOrder();
				RepairModel.Instance.reqProjectOrder("admin");
			}
			else if(obj.seq=="1")
			{
				promrtEditSuccess = promrtWindow(PopUpManager.createPopUp(AppUtil.Instance.app,promrtWindow,true));
				promrtEditSuccess.show(PromptEvent.ALERT,'编辑成功！');
				PopUpManager.centerPopUp(promrtEditSuccess);
				promrtEditSuccess.visible = true;
				
				this._projectOrderMap.remove(_currentProjectOrder.proId);
				this._projectOrderMap.put(_currentProjectOrder.proId,_currentProjectOrder);
				//this.refreshProjectOrder();
				RepairModel.Instance.reqProjectOrder("admin");
			}
		}
		/**
		 *某船舶的未派工程单的且状态为未开始的修理单列表解析
		 * 解析得来的申请单存在_applyListMap
		 */
		public function onHandleApplyList(jasonStr:String):void
		{
			trace(jasonStr);
			var obj:Object = BlmJSON.decode(jasonStr); if(obj == null){return;}
			if(obj.eid!=0)
				return;
			this._applyListMap.clear();
			var tempApply:Array=obj.info;
			for(var i:int=0;i<tempApply.length;i++)
			{
				var tempApplyObj:ApplyObject=ApplyObject.parse(tempApply[i]);
				this._applyListMap.put(tempApplyObj.applyid,tempApplyObj);
			}
			onHandleEngineerRepairPanel();
			
		}
		
		//处理工程单下面修理单的点击菜单项
		public function onHandleEngineerRepairPanel():void
		{
			var flagList:ArrayCollection = new ArrayCollection(_applyListMap.getValues());
			if (flagList.length == 0)
			{
				promrt = promrtWindow(PopUpManager.createPopUp(AppUtil.Instance.app,promrtWindow,true));
				promrt.show(PromptEvent.ALERT,"无可用的申请单");
				PopUpManager.centerPopUp(promrt);
				promrt.visible = true;
				return ;
			}
			if(engineerRepairID == null)
			{
				engineerRepairID = EngineerRepairIDManage(PopUpManager.createPopUp(AppUtil.Instance.app,EngineerRepairIDManage,false));
			}
			engineerRepairID.visible = true;
			PopUpManager.centerPopUp(engineerRepairID);
			PopUpManager.bringToFront(engineerRepairID);     
			engineerRepairID.tempList.removeAll();
			
			engineerRepairID.tempList = new ArrayCollection(_applyListMap.getValues());
			this._tempApplyListMap.clear();
			/*			for(var i:int = 0;i < _engineerDetailPanel.fakeList.length;i++)
			{
			engineerRepairID.tempList.addItem(_engineerDetailPanel.fakeList[i]);
			}*/
			//     engineerRepairID.tempList = _engineerDetailPanel.fakeList;
			engineerRepairID.tempList.refresh();
			//engineerRepairID.tempList1.removeAll();
		}
		
		
		/**
		 *完成工程单解析
		 */	
		public function onHandleFufillProjectOrder(jasonStr:String):void
		{
			trace("abcdefghijklmn");
			trace(jasonStr);
			var obj:Object = BlmJSON.decode(jasonStr); if(obj == null){return;}
			if(obj.eid!=0)
				return;
			else 
				this._projectOrderMap.getValue(this._currentProjectOrder.proId).applyMap.getValue(obj.seq).st=2;
			//			处理完成按钮
			var tempArray1:ArrayCollection = new ArrayCollection(_currentProjectOrder.applyMap.getValues());
			
/*			var flag:Boolean = true;
			
			for(var i:int = 0;i < tempArray1.length;i++)
			{
				if(tempArray1[i].st != 2)
				{
					flag = false;
					break;
				}
			}
			
			if(flag)
			{
				_currentProjectOrder.state = '2';
				RepairModel.Instance.reqAddModProjectOrder("admin","1",_currentProjectOrder);
			}*/
			reqRefreshList();
		}
		
		/**
		 *删除工程单解析
		 */	
		public function onHandleDelProjectOrder(jasonStr:String):void
		{
			var promrtDeleteSuccess:promrtWindow;
			var obj:Object = BlmJSON.decode(jasonStr); if(obj == null){return;}
			if(obj.eid!=0)
				return;
			
			promrtDeleteSuccess = promrtWindow(PopUpManager.createPopUp(AppUtil.Instance.app,promrtWindow,true));
			promrtDeleteSuccess.show(PromptEvent.ALERT,'删除成功！');
			PopUpManager.centerPopUp(promrtDeleteSuccess);
			promrtDeleteSuccess.visible = true;
			
			this._projectOrderMap.remove(this._currentProjectOrder.proId);
			//			this._currentRepairOrder.clear();
			this.refreshProjectOrder();
		}
		
		/**
		 *刷新工程单
		 * 若currentProjectOrder isclear() 则刷新为第一个修理单
		 */
		private function refreshProjectOrder():void
		{
			
			engineerIDManage.shipRepairList.removeAll();
			var shipRepairManageArr:Array = _projectOrderMap.getValues();
			
			for(var j:int = 0;j < shipRepairManageArr.length;j++)
			{
				var repairOrderObject:ProjectOrderObject = new ProjectOrderObject();
				repairOrderObject = shipRepairManageArr[j] as ProjectOrderObject;
				engineerIDManage.shipRepairList.addItem(repairOrderObject);
			}
			trace("=======================================================");
			trace(engineerIDManage.shipRepairList.length);
			engineerIDManage.shipRepairList.refresh();
			engineerIDManage.pagecount.text = engineerIDManage.shipRepairList.length.toString();
			//engineerIDManage.table.selectedIndex = 0;
			if(_engineerDetailPanel != null)
			{
				var event:FlexEvent;
				_engineerDetailPanel.blmtitlewindow1_creationCompleteHandler(event);
				refreshEngineerIDPanel(_currentProjectOrder);
			}
			if(engineerIDPanelAdd != null)
			{
				var event1:FlexEvent;
				engineerIDPanelAdd.blmtitlewindow1_creationCompleteHandler(event1);
				refreshEngineerIDAddPanel(_currentProjectOrder);
			}
			/*			if(_repairPanel.engineerGroup.shipRepairList.length > 0)
			{
			reqShipRepairManageRightInfo();
			}*/
		}
		
		
		private function refreshDetailProjectOrder():void
		{
			//_currentProjectOrder = e.data as ProjectOrderObject;
		//	_currentProjectOrder = _projectOrderMap.getValues()[0];
			if(_engineerDetailPanel==null || _engineerDetailPanel.visible == false)
				_engineerDetailPanel = EngineerIDPanel(PopUpManager.createPopUp(AppUtil.Instance.app,EngineerIDPanel,true));
			
			_engineerDetailPanel.visible = true;
			PopUpManager.centerPopUp(_engineerDetailPanel);
			PopUpManager.bringToFront(_engineerDetailPanel);
			refreshEngineerIDPanel(_currentProjectOrder);
		}		
		
		/**
		 *修改内存内容
		 * @author lisicong
		 */
		
		/**
		 *设置_currentRepairItemMap内容，当用户勾选后，传入id数组即可
		 */

		public function set currentProjectOrder(value:ProjectOrderObject):void
		{
			_currentProjectOrder = value;
		}	
	}
}