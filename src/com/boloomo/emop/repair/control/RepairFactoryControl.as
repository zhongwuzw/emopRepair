package com.boloomo.emop.repair.control
{
	import com.boloomo.common.BlmJSON;
	import com.boloomo.common.Network;
	import com.boloomo.emop.repair.event.RepairListEvent;
	import com.boloomo.emop.repair.model.RepairModel;
	import com.boloomo.emop.repair.type.CheckoutListObject;
	import com.boloomo.emop.repair.type.FactoryRepairObject;
	import com.boloomo.emop.repair.type.PlannedContentObject;
	import com.boloomo.emop.repair.type.ProjectInFactoryObject;
	import com.boloomo.emop.repair.view.RepairShopPlan.AddContOrderPanel;
	import com.boloomo.emop.repair.view.RepairShopPlan.AddProjectOrderPanel;
	import com.boloomo.emop.repair.view.RepairShopPlan.RepairShopManangement;
	import com.boloomo.event.BlmEvent;
	import com.boloomo.event.BlmEventManager;
	import com.boloomo.util.AppUtil;
	import com.boloomo.util.maps.HashMap;
	
	import mx.managers.PopUpManager;

	public class RepairFactoryControl
	{
		
		private static var g_Instance:RepairFactoryControl = null;
		
		private var _repaireShopPanel:RepairShopManangement = null;
		private var _factoryRepairMap:HashMap=new HashMap();//储存厂修管理的所有数据
		private var _unassignProjectOrderMap:HashMap=new HashMap();//某船舶下所有未开始的未被分配的的工程单
		private var _checkOutListMap:HashMap=new HashMap();//请求某船舶下检验列表
		private var _addProjectOrderPanel:AddProjectOrderPanel = null;
		private var _currentFactoryRepair:FactoryRepairObject=new FactoryRepairObject();//储存当前点击厂修管理项 只提供set函数.请在每次点击不同修理单时赋值。并在重新请求时clear。并且在修改或者新增时在此赋值，注意新增时要先clear，并在刷新时判断是否有id
		public var _addContOrderPanel:AddContOrderPanel = null;
		
		
		public static function get Instance():RepairFactoryControl
		{
			if(g_Instance == null)
				g_Instance = new RepairFactoryControl();
			return g_Instance;
		}
		
		public function RepairFactoryControl()  
		{
			if(g_Instance)
				throw new Error('error......');
			BlmEventManager.Instance.addEventListener(EmopToolEventType.EMOP_REPAIR_MANAGER,onRepairShopPanel);
			BlmEventManager.Instance.addEventListener(RepairListEvent.REPAIR_REFFACTORYREPAIRLIST,changeFactoryRepairProjectList);
			BlmEventManager.Instance.addEventListener(RepairListEvent.REPAIR_CONFIRMDELREPAIRCARD,delFactoryRepairList);
			BlmEventManager.Instance.addEventListener(RepairListEvent.REPAIR_EDITREPAIRCARD,editFactoryRepairList);
			BlmEventManager.Instance.addEventListener(RepairListEvent.REPAIR_CANCELFACTORY,cancelFactoryRepair);
			BlmEventManager.Instance.addEventListener(RepairListEvent.REPAIR_DELFACTORYLIST,delFactoryRepairProjectList);
			BlmEventManager.Instance.addEventListener(RepairListEvent.REPAIR_SHOWADDLISTPANEL,addFactoryRepairProjectList);
			BlmEventManager.Instance.addEventListener(RepairListEvent.REPAIR_ADDFACTORYLIST,changeProjectOrderList);
			BlmEventManager.Instance.addEventListener(RepairListEvent.REPAIR_SHOWADDCONTPANEL,contAdd);
			
			Network.Instance.RegisterHandler(0x6331,onHandleFactoryRepair);
			Network.Instance.RegisterHandler(0x6332,onHandleUnassignProjectOrder);
			Network.Instance.RegisterHandler(0x6333,onHandleCheckOutList);
			Network.Instance.RegisterHandler(0x6334,onHandleAddModFactoryRepair);
			Network.Instance.RegisterHandler(0x6335,onHandleDelFactoryRepair);
			Network.Instance.RegisterHandler(0x6336,onHandleAddFactoryRepairProject);
			
			
		}
		/**
		 * 显示厂修管理界面
		 * */
		private function onRepairShopPanel(e:BlmEvent):void
		{
			if(_repaireShopPanel == null || _repaireShopPanel.visible == false)
				_repaireShopPanel = RepairShopManangement(PopUpManager.createPopUp(AppUtil.Instance.app,RepairShopManangement));
			_repaireShopPanel.visible = true;
			PopUpManager.centerPopUp(_repaireShopPanel);
			PopUpManager.bringToFront(_repaireShopPanel);
			RepairModel.Instance.reqFactoryRepair("admin");
			
			
		}
		/**
		 *更改厂修管理下面的工程单list
		 */
		private function changeFactoryRepairProjectList(e:BlmEvent):void
		{
			if(e.data==null)
				_repaireShopPanel.emop_list(new HashMap(),"");
			else
				_currentFactoryRepair=e.data as FactoryRepairObject;
			refreshFactoryRepairProjectList();
			
		}
		/**
		 *删除厂修单
		 */
		private function delFactoryRepairList(e:BlmEvent):void
		{
			_currentFactoryRepair=e.data as FactoryRepairObject;
			RepairModel.Instance.reqDelFactoryRepair("admin",_currentFactoryRepair.factoryId);  
			
		}
		/**
		 *编辑厂修单
		 */
		private function editFactoryRepairList(e:BlmEvent):void
		{
			_currentFactoryRepair=e.data as FactoryRepairObject;
			if(_currentFactoryRepair.factoryId=="")
				RepairModel.Instance.reqAddModFactoryRepair("admin",0,_currentFactoryRepair);
			else
				RepairModel.Instance.reqAddModFactoryRepair("admin",1,_currentFactoryRepair);
		}
		/**
		 *刷新厂修卡
		 */
		private function cancelFactoryRepair(e:BlmEvent):void
		{
			refreshFactoryRepair();
		}
		/**
		 *删除厂修卡下面的工程单
		 */
		private function delFactoryRepairProjectList(e:BlmEvent):void
		{
			var tmpArray:Array = new Array(e.data.proid);
			RepairModel.Instance.reqAddFactoryRepairProject(1,_currentFactoryRepair.factoryId,tmpArray);
			
		}
		/**
		 *popup添加未完成的工程单的界面
		 */
		private function addFactoryRepairProjectList(e:BlmEvent):void
		{
			RepairModel.Instance.reqUnassignProjectOrder(_currentFactoryRepair.shipId);
		
		}
		/**
		 *添加未完成的工程单
		 */
		private function changeProjectOrderList(e:BlmEvent):void
		{
			RepairModel.Instance.reqAddFactoryRepairProject(0,_currentFactoryRepair.factoryId,e.data as Array); 
		}
		/**
		 *popup厂修内容的界面
		 */
		private function contAdd(e:BlmEvent):void
		{
			RepairModel.Instance.reqCheckOutList1(e.data as String);
			if(_addContOrderPanel ==null||_addContOrderPanel.visible == false)
			{
				_addContOrderPanel=AddContOrderPanel(PopUpManager.createPopUp(AppUtil.Instance.app,AddContOrderPanel,true));
				_addContOrderPanel.visible=true;
				PopUpManager.centerPopUp(_addContOrderPanel);
				PopUpManager.bringToFront(_addContOrderPanel);
			}
			
			
		}
		
		/**
		 *刷新工程单
		 * 若currentFactoryRepair isclear() 则刷新为第一个工程单
		 */
		private function refreshFactoryRepair():void
			
		{
			_repaireShopPanel.emop_data(_factoryRepairMap.getValues());
			refreshFactoryRepairProjectList();
			
		}
		/**
		 *刷新厂修管理下面的工程单list
		 */
		private function refreshFactoryRepairProjectList():void
		{
			if(_currentFactoryRepair.isclear())
			{
				_repaireShopPanel.emop_list(null,"");
			}
			else
				_repaireShopPanel.emop_list(_currentFactoryRepair.projectOrder,_currentFactoryRepair.shipName);
		}
		/**
		 *厂修管理请求解析
		 * 数据解析储存在factoryRepairMap中
		 */	
		//		{seq：“”，info：[{facid：“”，shipid：“”，shipna:””,state：“”，pin：，pout：，rin：，rout：，cont：[{id:“”,na:””},{}…]，comid：“”，comna:””,ptime：“”，rtime：“”，port：“”，ccs:””, certdt: pro：[{proid：“”，shipid：“”，state：“”，sday:10，fday：11}，{}]，allproid：“p01|p02|p03“}，{}，{}]}
		public function onHandleFactoryRepair(jasonStr:String):void
		{
			trace(jasonStr);
			var obj:Object = BlmJSON.decode(jasonStr);
			if(obj == null){return;}
			if(obj.eid)
				return;
			var tempFactoryArray:Array=obj.info;
			this._factoryRepairMap.clear();
			this._currentFactoryRepair.clear();
			for(var i:int=0;i<tempFactoryArray.length;i++)
			{
				var tempFactoryRepair:FactoryRepairObject=FactoryRepairObject.parse(tempFactoryArray[i]);
				var tempProjectObjectArray:Array=tempFactoryArray[i].pro;
				var tempContArray:Array = tempFactoryArray[i].cont;
				for(var j:int=0;j<tempProjectObjectArray.length;j++)
				{
					var tempProjectObj:ProjectInFactoryObject=ProjectInFactoryObject.parse(tempProjectObjectArray[j]);
					tempFactoryRepair.projectOrder.put(tempProjectObj.proid,tempProjectObj);
				}
				for(var k:int=0;k<tempContArray.length;k++)
				{
					var tempContentObj:PlannedContentObject=PlannedContentObject.parse(tempContArray[k]);
					tempFactoryRepair.contOrder.put(tempContentObj.id,tempContentObj);
				}
				this._factoryRepairMap.put(tempFactoryRepair.factoryId,tempFactoryRepair);
			}
			this.refreshFactoryRepair();
			
		}
		
		/**
		 *厂修管理请求某船舶下所有未开始的未被分配的的工程单请求解析
		 * 数据解析储存在_unassignProjectOrderMap中
		 */	
		//		{seq：“”，info：[{proid：“”，sday:10，fday：11}，{}]}
		public function onHandleUnassignProjectOrder(jasonStr:String):void
		{
			trace(jasonStr);
			var obj:Object = BlmJSON.decode(jasonStr); if(obj == null){return;}
			if(obj.eid)
				return;
			this._unassignProjectOrderMap.clear();
			var unassignArray:Array=obj.info;
			for(var i:int=0;i<unassignArray.length;i++)
			{
				var tempUnassignObj:ProjectInFactoryObject=ProjectInFactoryObject.parse(unassignArray[i]);
				this._unassignProjectOrderMap.put(tempUnassignObj.proid,tempUnassignObj);
			}
			
			
			if(_addProjectOrderPanel ==null||_addProjectOrderPanel.visible==false)
			{
				_addProjectOrderPanel=AddProjectOrderPanel(PopUpManager.createPopUp(AppUtil.Instance.app,AddProjectOrderPanel,true));
				_addProjectOrderPanel.visible=true;
				PopUpManager.centerPopUp(_addProjectOrderPanel);
				PopUpManager.bringToFront(_addProjectOrderPanel);
				_addProjectOrderPanel.emop_list(_unassignProjectOrderMap,_currentFactoryRepair.shipName);
			}
		}
		/**
		 *厂修管理请求某船舶下检验列表
		 * 数据解析储存在_checkOutListMap中
		 */	
		public function onHandleCheckOutList(jasonStr:String):void
		{
			var obj:Object = BlmJSON.decode(jasonStr); if(obj == null){return;}
			if(obj.eid)
				return;
			this._checkOutListMap.clear();
			var checkOutArray:Array=obj.info;
			for(var i:int=0;i<checkOutArray.length;i++)
			{
				var checkOutObj:CheckoutListObject=CheckoutListObject.parse(checkOutArray[i]);
				this._checkOutListMap.put(checkOutObj.id,checkOutObj);
			}
			
			
				_addContOrderPanel.emop_list(_checkOutListMap);
			
			
		}
		
		
		/**
		 *长修单新增或者修改解析
		 * 新增和修改的修理单存在_currentFactoryRepair中 新增之前记得clear
		 */	
		//		{seq：“”，eid：，type：““，facid：“”}
		public function onHandleAddModFactoryRepair(jasonStr:String):void
		{
			trace(jasonStr);
			var obj:Object = BlmJSON.decode(jasonStr); if(obj == null){return;}
			if(obj.eid!=0)
			{
				if(obj.type==0)
					this.refreshFactoryRepair();
				else if(obj.type==1)
					this.refreshFactoryRepair();
				return;
			}
			if(obj.type==0)
			{
				this._currentFactoryRepair.factoryId=obj.facid;
				this._factoryRepairMap.put(_currentFactoryRepair.factoryId,_currentFactoryRepair);
				this.refreshFactoryRepair();
			}
			else if(obj.type==1)
			{
				this._factoryRepairMap.remove(_currentFactoryRepair.factoryId);
				this._factoryRepairMap.put(_currentFactoryRepair.factoryId,_currentFactoryRepair);
				this.refreshFactoryRepair();
			}
		}
		
		/**
		 *删除厂修卡解析
		 */	
		public function onHandleDelFactoryRepair(jasonStr:String):void
		{
			var obj:Object = BlmJSON.decode(jasonStr); if(obj == null){return;}
			if(obj.eid!=0)
				return;
			this._factoryRepairMap.remove(this._currentFactoryRepair.factoryId);
			this._currentFactoryRepair.clear();
			this.refreshFactoryRepair();
		}
		
		
		
		/**
		 *新增或者删除厂修卡下的工程单解析
		 */	
		public function onHandleAddFactoryRepairProject(jasonStr:String):void
			//		{seq：““，eid：info：[{proid：“”，shipid：“”，state：“”，fday：}，{}]}
			//		{seq：““，eid：}
		{
			trace(jasonStr);
			var obj:Object = BlmJSON.decode(jasonStr); if(obj == null){return;}
			if(obj.eid!=0)
				return;
			if(obj.type==0)
			{
				var str:String=obj.seq;
				var idArray:Array=str.split("|");
				//this._factoryRepairMap.getValue(this._currentFactoryRepair.factoryId).projectOrder.clear();
				for(var i:int=0;i<idArray.length;i++)
					this._factoryRepairMap.getValue(this._currentFactoryRepair.factoryId).projectOrder.put(idArray[i],this._unassignProjectOrderMap.getValue(idArray[i]));//从_unassignProjectOrderMap中取出idArray中的工程单 ，放在_factoryRepairMap中
			}
			else if(obj.type==1)
			{
				var tempStr:String=obj.seq;
				var tempArray:Array=tempStr.split("|");
				for(var j:int=0;j<tempArray.length;j++)
					this._factoryRepairMap.getValue(this._currentFactoryRepair.factoryId).projectOrder.remove(tempArray[j]);
			}
			this.refreshFactoryRepairProjectList();
		}
		
	
	}
}