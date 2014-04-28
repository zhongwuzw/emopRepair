package com.boloomo.emop.repair.control
{
	import com.boloomo.common.BlmJSON;
	import com.boloomo.common.Network;
	import com.boloomo.emop.repair.model.RepairModel;
	import com.boloomo.emop.repair.type.CategoryObject;
	import com.boloomo.emop.repair.type.EquipObject;
	import com.boloomo.emop.repair.type.ItemObject;
	import com.boloomo.emop.repair.type.RepairItemObject;
	import com.boloomo.emop.repair.type.ShipObject;
	import com.boloomo.emop.repair.type.WorkCardObject;
	import com.boloomo.emop.repair.utils.RepairItemTreeUtils;
	import com.boloomo.emop.repair.view.RepairItem.RepairItemPanel;
	import com.boloomo.event.BlmEvent;
	import com.boloomo.event.BlmEventManager;
	import com.boloomo.util.AppUtil;
	import com.boloomo.util.maps.HashMap;
	
	import mx.collections.ArrayCollection;
	import mx.collections.XMLListCollection;
	import mx.managers.PopUpManager;
	
	public class RepairItemControl
	{
		private static var g_Instance:RepairItemControl = null;
		private var repairItemView:RepairItemPanel =null;
		
		private var _repairItem:RepairItemObject=new RepairItemObject();//储存修理项所有数据
		private var _currentCategory:CategoryObject=new CategoryObject();//存储当前点击的类别或者新建的类别，只提供set函数 请在每次点击时赋值。并在重新请求时clear。并且在修改或者新增时在此赋值，注意新增时要先clear，并在刷新时判断是否有id
		private var _currentItem:ItemObject=new ItemObject();//储存当前点击的修理项或者新建的修理项，只提供set函数 请在每次点击时赋值。并在重新请求时clear。并且在修改或者新增时在此赋值，注意新增时要先clear，并在刷新时判断是否有id
		private var _beforeEditItem:ItemObject=new ItemObject();//保存修改前的内容，防止修改失败
		private var _currentShip:ShipObject=new ShipObject();//储存当前点击的船舶，只提供set函数
		private var _currentEquip:EquipObject=new EquipObject();//储存当前点击的设备，只提供set函数
		private var _addableWorkCardMap:HashMap=new HashMap();//储存可添加工作卡
		private var _addDelShipVec:Vector.<ShipObject>=new Vector.<ShipObject>;//储存增加或者删除的ship  vector
		private var _addDelWorkCardVec:Vector.<WorkCardObject>=new Vector.<WorkCardObject>;//储存增加或者删除的ship  vector
		private var _addDelCwbt:EquipObject=new EquipObject();//储存增加或者删除的cwbt
				
		public function RepairItemControl()
		{
			if(g_Instance)
				throw new Error('error......');
			BlmEventManager.Instance.addEventListener(EmopToolEventType.EMOP_REPAIR_ITEMS,onRepairItemControl);
			
			Network.Instance.RegisterHandler(0x6301,onHandleRepairItemCate);
			Network.Instance.RegisterHandler(0x6302,onHandleRepairItem);
			Network.Instance.RegisterHandler(0x6303,onHandleDetailRepairItem);
			Network.Instance.RegisterHandler(0x6304,onHandleModRepairItem);
			Network.Instance.RegisterHandler(0x6305,onHandleAddable);
			Network.Instance.RegisterHandler(0x6306,onHandleAddDelShip);
			Network.Instance.RegisterHandler(0x6307,onHandleAddDelEquip);
			Network.Instance.RegisterHandler(0x6308,onHandleAddDelWorkCard);
			Network.Instance.RegisterHandler(0x6309,onHandleDelRepairItem);
		}
		
		public function get beforeEditItem():ItemObject
		{
			return _beforeEditItem;
		}
		
		public function set beforeEditItem(value:ItemObject):void
		{
			_beforeEditItem = value;
		}
		
		public static function get Instance():RepairItemControl
		{
			if(g_Instance == null)
				g_Instance = new RepairItemControl();
			return g_Instance;
		}
		//---------------------------------修理项管理------------------------	
		/**
		 * 显示修理项面板
		 */ 
		private function onRepairItemControl(e:BlmEvent):void
		{
			if(repairItemView == null || repairItemView.visible==false)
			{
				repairItemView = RepairItemPanel(PopUpManager.createPopUp(AppUtil.Instance.app,RepairItemPanel,true));
			}
			repairItemView.visible = true;
			PopUpManager.centerPopUp(repairItemView);
			PopUpManager.bringToFront(repairItemView);	
		}
		
		/**
		 *解析函数
		 * @author lisicong
		 */	
		/**
		 *修理项请求类别
		 * 解析之前clear
		 * 把解析后的数据存储在_repairItem中
		 */	
		//		{seq：“”，info：[{cateid：“”，caten：“”} {},{}]}
		public function onHandleRepairItemCate(jasonStr:String):void{
			var obj:Object = BlmJSON.decode(jasonStr); if(obj == null){return;}
			if(obj.eid)
				return;
			var categoryArray:Array=obj.info;
			this._repairItem.categoryMap.clear();
			for(var i:int=0;i<categoryArray.length;i++)
			{
				var tempCateObj:CategoryObject=CategoryObject.parse(categoryArray[i]);
				this._repairItem.categoryMap.put(tempCateObj.cateId,tempCateObj);
			}
			this.refreshRepairCategory();
		}
		/**
		 * 选中树的某项时，设置当前点击的修理项类别
		 */ 
		public function setCurrentCategory(cateID:String):void{
			_currentCategory=_repairItem.categoryMap.getValue(cateID) as CategoryObject;			
		}
		/**
		 *修理项数据请求接口
		 * 解析之前clear
		 * 把解析后的数据存储在_repairItem中
		 */	
		public function onHandleRepairItem(jasonStr:String):void{//jasonStr = "{seq:"D",info:[{cateid:"D",caten:"坞修工程",item:[{itemid:"D",itemn:"坞修工程"},{itemid:"D-100",itemn:"坞修工程说明"},{itemid:"D-200",itemn:"船体表面处理"},{itemid:"D-201",itemn:"动力磨轮清洁"},{itemid:"D-202",itemn:"人工手铲，去除污物"},{itemid:"D-203",itemn:"对船壳板进行颗粒喷沙，达到SA 2.5 标准"},{itemid:"D-204",itemn:"对船壳板进行颗粒喷沙，达到SA 2.0 标准"},{itemid:"D-205",itemn:"对船壳板进行颗粒喷沙，达到SA 1.0 标准"},{itemid:"D-206",itemn:" 船壳油漆"},{itemid:"D-207",itemn:"轻重载水线间部分"},
			var obj:Object = BlmJSON.decode(jasonStr); 
			if(obj == null){return;}
			if(obj.eid)
				return;
			//			if(obj.seq!=this._currentCategory.cateId)
			//				return;
			var cateArray:Array=obj.info;
			var ItemArray:Array=cateArray[0].item;
			this._repairItem.categoryMap.getValue(this._currentCategory.cateId).itemMap.clear();
			for(var i:int=0;i<ItemArray.length;i++)
			{
				var tempItemObj:ItemObject=ItemObject.parse(ItemArray[i]);
				this._repairItem.categoryMap.getValue(this._currentCategory.cateId).itemMap.put(tempItemObj.itemId,tempItemObj);
			}
			this.refreshRepairItemName();
		}
		/**
		 * 选中树的某项时，设置当前点击的修理项
		 * 修理项的类别也要对应修改
		 */ 
		public function setCurrentItem(cateID:String,itemID:String):void{
			//			_currentCategory.clear();
			//			_currentItem.clear();
			_currentCategory=_repairItem.categoryMap.getValue(cateID) as CategoryObject;
			_currentItem=_currentCategory.itemMap.getValue(itemID);	
		}		
		/**
		 *单个修理项详细数据请求接口
		 * 点击的时候把itemmap  clear
		 * 把解析后的数据存储在_repairItem中
		 */	
		//		{seq:””,itemid:””,itemna:””,content:””,ships:[{id:””,name:””,equips:[{idcwbt:””,na:””,wcs:[{id:””,level:””,owner:””},{}]}, {}] },{}};
		public function onHandleDetailRepairItem(jasonStr:String):void{//ships:[{id:"",name:"",equips:[]},{id:"",name:"",equips:[]},{id:"",name:"",equips:[]},{id:"",name:"",equips:[]},{id:"",name:"",equips:[]},{id:"",name:"",equips:[]}]}"
			var obj:Object = BlmJSON.decode(jasonStr);	
			if(obj.seq=="seq03")
				BlmEventManager.Instance.dispatchEvent(new BlmEvent(RepairEventType.REPAIR_ITEM_DELIVER_TO_REPAIRLIST,jasonStr));
			else{				
				if(obj == null){return;}
				if(obj.eid)
					return;
				var tempItemObj:ItemObject=ItemObject.parseDetail(obj);
				var tempShipArray:Array=obj.ships;
				for(var i:int=0;i<tempShipArray.length;i++)
				{
					var tempShipObj:ShipObject=ShipObject.parse(tempShipArray[i]);
					var tempEquipArray:Array=tempShipArray[i].equips;
					for(var j:int=0;j<tempEquipArray.length;j++)
					{
						var tempEquip:EquipObject=EquipObject.parse(tempEquipArray[j]);
						var tempWorkCardArray:Array=tempEquipArray[j].wcs;
						for(var k:int=0;k<tempWorkCardArray.length;k++)
						{
							var tempWorlCard:WorkCardObject=WorkCardObject.parseInit(tempWorkCardArray[k]);
							tempEquip.workCardMap.put(tempWorlCard.workCardId,tempWorlCard);
						}
						tempShipObj.equipMap.put(tempEquip.equiqId,tempEquip);
					}
					tempItemObj.shipMap.put(tempShipObj.shipId,tempShipObj);
				}
				this._currentItem.clear();
				this._currentItem=tempItemObj;
				this._repairItem.categoryMap.getValue(this._currentCategory.cateId).itemMap.put(tempItemObj.itemId,tempItemObj);
				this.refreshRepairItemDetail();
			}
		}
		/*
		/**
		*修船管理 解析
		* 解析所有的类别id、类别名称和修理项id、修理项名称
		* 把解析后的数据存储在_repairItem中
		*/	
		//		{seq：“”，info：[{cateid：“”，caten：“”，item：[{itemid：“”，itemn：“”},{ itemid：“”，itemn：“”}]},{},{}]};
		/*
		public function onHandleRepairItem(jasonStr:String):void{
		var obj:Object = BlmJSON.decode(jasonStr); if(obj == null){return;}
		if(obj.eid)
		return;
		var categoryArray:Array=obj.info;
		this._repairItem.categoryMap.clear();
		this._currentCategory.clear();
		this._currentItem.clear();
		for(var i:int=0;i<categoryArray.length;i++)
		{
		var tempCateObj:CategoryObject=CategoryObject.parse(categoryArray[i]);
		var itemArray:Array=categoryArray[i].item;
		for(var j:int=0;j<itemArray.length;j++)
		{
		var tempItemobj:ItemObject=ItemObject.parse(itemArray[j]);
		tempCateObj.itemMap.put(tempItemobj.itemId,tempItemobj);
		}
		this._repairItem.categoryMap.put(tempCateObj.cateId,tempCateObj);
		}
		this.refreshTree();
		}
		/**
		*点击单个修理项 解析
		* 把解析后的数据存储在_repairItem中
		*/	
		//{seq:"",content:"",ships:[{id:””,name:””,equips:[{id:””,na:””,wcs:[{id:””,level:””,owner:””},{}]}, {}] },{}};
		/*
		public function onHandleSingleRepairItem(jasonStr:String):void{
		var obj:Object = BlmJSON.decode(jasonStr); if(obj == null){return;}
		if(obj.eid)//发生请求错误 
		return;
		if(obj.seq!=this._currentItem.itemId)//发生延时，返回的不是当前点的项目
		return;
		this._repairItem.categoryMap.getValue(this._currentCategory.cateId).itemMap.getValue(this._currentItem.itemId).content=obj.content;
		var shipArray:Array=obj.ships;
		for(var i:int=0;i<shipArray.length;i++)
		{
		var tempShip:ShipObject=ShipObject.parse(shipArray[i]);
		var tempEquipArray:Array=shipArray[i].equips;
		for(var j:int=0;j<tempEquipArray.length;j++)
		{
		var tempEquip:EquipObject=EquipObject.parse(tempEquipArray[j]);
		var tempWorkCardArray:Array=tempEquipArray[j].wcs;
		for(var k:int=0;k<tempWorkCardArray.length;k++)
		{
		var tempWorkCrad:WorkCardObject=WorkCardObject.parse(tempWorkCardArray[k]);
		tempEquip.workCardMap.put(tempWorkCrad.workCardId,tempWorkCrad);
		}
		tempShip.equipMap.put(tempEquip.equiqId,tempEquip);
		}
		this._repairItem.categoryMap.getValue(this._currentCategory.cateId).itemMap.getValue(this._currentItem.itemId).shipMap.put(tempShip.shipId,tempShip);
		this.refreshRepairItem();
		}
		}
		*/
		
		/**
		 * 请求修改 修理项Item
		 * 设置currentItem，原来的数据存在_beforeEditItem
		 * @author zhoucd
		 */ 
		public function reqEditItem(cateid:String, itemid:String, itemn:String, content:String):void{
			_beforeEditItem.clear();
			_beforeEditItem.content	=_currentItem.content;
			_beforeEditItem.itemId	=_currentItem.itemId;
			_beforeEditItem.itemName=_currentItem.itemName;
			_currentItem.clear();
			_currentItem.content=content;
			_currentItem.itemId=itemid;
			_currentItem.itemName=itemn;
			RepairModel.Instance.reqModRepairItem(2,cateid,itemid,itemn,content);//申请修改
		}
		/**
		 * 请求新增 修理项Item
		 * 设置currentItem
		 * @author zhoucd
		 */ 
		public function reqADDItem(cateid:String, itemid:String, itemn:String, content:String):void{
			_currentItem.clear();
			_currentItem.content=content;
			_currentItem.itemId=itemid;
			_currentItem.itemName=itemn;
			RepairModel.Instance.reqModRepairItem(1,cateid,itemid,itemn,content);//申请新建
		}
		/**
		 *新建或者修改修理项，增加船舶列表 解析
		 * 把解析后的数据存储在_repairItem中
		 */	
		//		{eid：0，seq：“”，type：“”，cateid：“”，itemid：“”，shipid：“g10|g11”}
		public function onHandleModRepairItem(jasonStr:String):void{
			var obj:Object = BlmJSON.decode(jasonStr); 
			if(obj == null){return;}
			var tempItemArray:Array;
			if(obj.eid==0 && obj.etype==1){//失败：修理项代码已经存在
				this._currentItem.clear();
				//				tempItemArray=this._repairItem.categoryMap.getValue(this._currentCategory.cateId).itemMap.getValues;
				//				this._currentItem=tempItemArray[0];	//获取当前类别第一个修理项
				this.refreshRepairItemRepeat();//处理重复提交
			}
			if(obj.eid!=0){//操作失败
				switch(obj.seq)
				{
					case "1"://新增失败 刷新原itemmap 的第一项
						this._currentItem.clear();
						tempItemArray=this._repairItem.categoryMap.getValue(this._currentCategory.cateId).itemMap.getValues;
						this._currentItem=tempItemArray[0];
						refreshRepairItem_FailADD();
						break;
					case "2"://修改失败
						_currentItem.clear();
						_currentItem=_beforeEditItem;
						refreshRepairItem_FailEdit();
						break;
				}
				
			}else{//obj.eid=0 操作成功
				switch(obj.seq)
				{
					case "1"://新增修理项，注意使用之前刷新_currentItem 并将新增的名字存入。使用set函数
						(this._repairItem.categoryMap.getValue(this._currentCategory.cateId) as CategoryObject).itemMap.put(this._currentItem.itemId,this._currentItem);
						refreshRepairItem_ADD();
						break;
					case "2"://修改修理项，注意使用之前刷新_currentItem 并将新增的名字存入。使用set函数
						this._repairItem.categoryMap.getValue(this._currentCategory.cateId).itemMap.remove(this._beforeEditItem.itemId);
						this._repairItem.categoryMap.getValue(this._currentCategory.cateId).itemMap.put(this._currentItem.itemId,this._currentItem);
						refreshRepairItem_Edit();
						break;
				}
			}
		}
		/**
		 *请求可添加工作卡
		 *把可添加的工作卡 存在 _addableWorkCardMap
		 */	
		//		{seq:”",wcs:[{ id:””,level:””,owner:””},{}]}
		public function onHandleAddable(jasonStr:String):void{
			var obj:Object = BlmJSON.decode(jasonStr); 
			if(obj == null){return;}
			if(obj.eid)//发生请求错误 
				return;
			var tempWcsArray:Array=obj.wcs;
			for(var i:int=0;i<tempWcsArray.length;i++)
			{
				var tempWcsObj:WorkCardObject=WorkCardObject.parse(tempWcsArray[i]);
				this._addableWorkCardMap.put(tempWcsObj.workCardId,tempWcsObj);
			}
			repairItemView.SendWorkCards(_addableWorkCardMap);
			/*			switch(obj.type)
			{
			case "1":
			this._addableShipMap.clear();
			var shipArray:Array=obj.ships;
			for(var i:int=0;i<shipArray.length;i++)
			{
			var tempShip:ShipObject=ShipObject.parse(shipArray[i]);
			this._addableShipMap.put(tempShip.shipId,tempShip);
			//						显示可增加的船舶列表
			}
			break;
			case "2":
			this._addableEquipMap.clear();
			var equipArray:Array=obj.equips;
			for(var j:int=0;j<equipArray.length;j++)
			{
			var tempEquip:EquipObject=EquipObject.parse(equipArray[j]);
			this._addableEquipMap.put(tempEquip.equiqId,tempEquip);
			//						显示可增加的设备列表
			}
			break;
			case "3":
			this._addableWorkCardMap.clear();
			var workArray:Array=obj.wcs;
			for(var k:int=0;k<workArray.length;k++)
			{
			var tempWork:WorkCardObject=WorkCardObject.parse(workArray[k]);
			this._addableWorkCardMap.put(tempWork.workCardId,tempWork);
			}
			//					显示可增加的工作卡列表
			break;
			}*/
		}
		
		/**
		 *增加或者删除船舶
		 */	
		//		{seq:””，eid: }
		public function onHandleAddDelShip(jasonStr:String):void
		{
			var obj:Object = BlmJSON.decode(jasonStr); 
			if(obj == null){return;}
			if(obj.eid!=0)//发生请求错误 
			{
				if(obj.seq=="1"){//添加失败
					this.refreshADDShipListFail();				
				}else if(obj.ser=="2"){//删除失败
					this.refreshDELShipListFail();
				}
				return;
			}
			if(obj.seq=="1")//添加船舶
			{
				for(var i:int=0;i<this._addDelShipVec.length;i++)
					((this._repairItem.categoryMap.getValue(this._currentCategory.cateId) as CategoryObject).itemMap.getValue(this._currentItem.itemId) as ItemObject).shipMap.put(_addDelShipVec[i].shipId,_addDelShipVec[i]);
				this.refreshADDShipListSuccess();	
			}else if(obj.seq=="2")//删除船舶
			{
				for(var j:int=0;j<_addDelShipVec.length;j++)
					((this._repairItem.categoryMap.getValue(this._currentCategory.cateId) as CategoryObject).itemMap.getValue(this._currentItem.itemId) as ItemObject).shipMap.remove(_addDelShipVec[j].shipId);//remove key
				//				this._currentShip=this._repairItem.categoryMap.getValue(this._currentCategory.cateId).itemMap.getValue(this._currentItem.itemId).shipMap.getValues[0];
				this.refreshDELShipListSuccess();
			}
		}
		
		/**
		 * 这是当前选中的船舶
		 * 在control中设置当前船舶，并返回船舶详细信息
		 * @author zhoucd
		 */ 
		public function setcurrentShip(shipID:String):void{
			//			_currentCategory=_repairItem.categoryMap.getValue(cateID) as CategoryObject;
			//			_currentItem=_currentCategory.itemMap.getValue(itemID) as ItemObject;	
			_currentShip=_currentItem.shipMap.getValue(shipID);
		}
		
		/**
		 *增加或者删除设备  由于设备是单个删除或者增加 所以可以单个操作 不用刷新
		 */	
		//		{seq:””，eid：}
		public function onHandleAddDelEquip(jasonStr:String):void
		{
			var obj:Object = BlmJSON.decode(jasonStr); 
			if(obj == null){return;}
			if(obj.eid!=0)//发生请求错误  不进行操作
				return;
			if(obj.seq=="1")//新建
			{
				this._addDelCwbt.equipName=obj.na;
				this._repairItem.categoryMap.getValue(this._currentCategory.cateId).itemMap.getValue(this._currentItem.itemId).shipMap.getValue(this._currentShip.shipId).equipMap.put(_addDelCwbt.equiqId,_addDelCwbt);
				repairItemView.ADDEquipSucess(_addDelCwbt);
				//可以直接操作增加 不刷新
			}else if(obj.seq=="2")//删除
			{
				this._repairItem.categoryMap.getValue(this._currentCategory.cateId).itemMap.getValue(this._currentItem.itemId).shipMap.getValue(this._currentShip.shipId).equipMap.remove(_addDelCwbt.equiqId);
				repairItemView.DelEquipSucess();
				// 可以直接删除 不刷新
			}
		}
		/**
		 * 设置当前设备
		 * @author zhoucd
		 */ 
		public function setCurrentEquip(equipID:String):void{
			_currentEquip.equiqId=equipID;
		}
		/**
		 *增加或者删除工作卡
		 */	
		public function onHandleAddDelWorkCard(jasonStr:String):void
		{
			var obj:Object = BlmJSON.decode(jasonStr); 
			if(obj == null){return;}
			if(obj.eid!=0){//发生请求错误 
				if(obj.seq=="1"){
					repairItemView.ADDWorkCardFail();
				}else if(obj.seq=="2"){
					repairItemView.DelWorkCardFail();
				}
				return;
			}
			if(obj.seq=="1")
			{
				for(var i:int=0;i<_addDelWorkCardVec.length;i++)
					((((this._repairItem.categoryMap.getValue(this._currentCategory.cateId) as CategoryObject).itemMap.getValue(this._currentItem.itemId) as ItemObject).shipMap.getValue(this._currentShip.shipId) as ShipObject).equipMap.getValue(this._currentEquip.equiqId) as EquipObject).workCardMap.put(_addDelWorkCardVec[i].workCardId,_addDelWorkCardVec[i]);
				//添加成功,返回新的工作卡列表			
				repairItemView.ADDWorkCardSucess(((((this._repairItem.categoryMap.getValue(this._currentCategory.cateId) as CategoryObject).itemMap.getValue(this._currentItem.itemId) as ItemObject).shipMap.getValue(this._currentShip.shipId) as ShipObject).equipMap.getValue(this._currentEquip.equiqId) as EquipObject).workCardMap);
			}else if(obj.seq=="2"){
				for(var j:int=0;j<_addDelWorkCardVec.length;j++)
					this._repairItem.categoryMap.getValue(this._currentCategory.cateId).itemMap.getValue(this._currentItem.itemId).shipMap.getValue(this._currentShip.shipId).equipMap.getValue(this._currentEquip.equiqId).workCardMap.remove(_addDelWorkCardVec[j].workCardId);
				repairItemView.DelWorkCardSucess(((((this._repairItem.categoryMap.getValue(this._currentCategory.cateId) as CategoryObject).itemMap.getValue(this._currentItem.itemId) as ItemObject).shipMap.getValue(this._currentShip.shipId) as ShipObject).equipMap.getValue(this._currentEquip.equiqId) as EquipObject).workCardMap);
			}
		}
		
		/**
		 *删除修理项
		 * 把解析后的数据从_repairItem中删除
		 * 之前已把要删除的修理项赋值给currentItem
		 */	
		public function onHandleDelRepairItem(jasonStr:String):void
		{
			var obj:Object = BlmJSON.decode(jasonStr); 
			if(obj == null){return;}			
			if(obj.eid!=0){//----删除失败
				this.refreshRepairItem_FailDEL();
				return;
			}
			(this._repairItem.categoryMap.getValue(this._currentCategory.cateId) as CategoryObject).itemMap.remove(this._currentItem.itemId);
			this._currentItem.clear();
			this.refreshRepairItem_DEL();
		}
		
		//-------------------------------获得数据后的相关操作------------------------------------
		/**
		 *刷新页面
		 * @author 
		 */	
		/**
		 *刷新修理项管理类别
		 * 转换数据为XML，为树提供数据
		 */	
		private function refreshRepairCategory():void
		{ 
			var treeXmllist:XMLListCollection=new XMLListCollection();
			var root:XML=<root></root>;
			var RepairItemCategory:Array = _repairItem.categoryMap.getValues();
			while(RepairItemCategory.length){
				var category:CategoryObject=RepairItemCategory.pop() as CategoryObject;
				var xml:XML=RepairItemTreeUtils.CategoryObjectToXML(category);
				root.appendChild(xml);						
			}
			treeXmllist.source=root.elements();
			repairItemView.getRepairCategory(treeXmllist);	
		}
		/**
		 *刷新修理项管理修理项名称
		 * 转换数据为XML
		 */	
		private function refreshRepairItemName():void
		{
			var root:XML=<root></root>;
			var RepairItemList:Array = _currentCategory.itemMap.getValues();
			RepairItemList.sort(RepairItemTreeUtils.sortByItemCode);		
			while(RepairItemList.length){
				var item:ItemObject=RepairItemList.pop() as ItemObject;
				var xml:XML=RepairItemTreeUtils.ItemObjectToXML(item);
				root.appendChild(xml);						
			}
			var xmlCollection:XMLListCollection=new XMLListCollection();
			xmlCollection.source=root.elements();
			repairItemView.getRepairItemList(xmlCollection);			
		}
		
		/**
		 *刷新修理项管理具体修理项
		 * 传递获取到的最新的信息
		 */
		private function refreshRepairItemDetail():void
		{
			repairItemView.getItemInfo(this._currentItem);
			
		}
		/**
		 * 修理项重复
		 * 返回
		 */ 
		private function refreshRepairItemRepeat():void{
			repairItemView.RepeatTreeNode();
		}
		/**
		 * 修理项修改成功
		 */ 
		private function refreshRepairItem_Edit():void{
			var xml:XML=RepairItemTreeUtils.ItemObjectToXML(_currentItem);
			repairItemView.EditTreeNodeSucess(xml);
		}
		/**
		 * 修理项修改失败
		 */ 
		private function refreshRepairItem_FailEdit():void{
			repairItemView.EditTreeNodeFail();
		}
		/**
		 * 修理项新增成功
		 */ 
		private function refreshRepairItem_ADD():void{
			var xml:XML=RepairItemTreeUtils.ItemObjectToXML(_currentItem);
			repairItemView.AddTreeNodeSuccess(xml);			
		}
		/**
		 * 修理项新增失败
		 */ 
		private function refreshRepairItem_FailADD():void{
			repairItemView.AddTreeNodeFail();
		}
		/**
		 * 修理项删除成功
		 */ 
		private function refreshRepairItem_DEL():void{
			repairItemView.DeleteRepairItemSuccess();		
		}
		/**
		 * 修理项删除失败
		 */ 
		private function refreshRepairItem_FailDEL():void{
			repairItemView.DeleteRepairItemFail();
		}
		
		
		private function refreshTree():void
		{
			
		}
		/**
		 *刷新修理项列表，类别列表不动
		 * 若currentitem isclear() 则刷新第一个item。
		 */	
		private function refreshRepairItem():void
		{
			
		}
		/**
		 * 刷新船舶列表 
		 * 添加成功
		 */
		private function refreshADDShipListSuccess():void
		{
			repairItemView.ADDShipSucess(((this._repairItem.categoryMap.getValue(this._currentCategory.cateId) as CategoryObject).itemMap.getValue(this._currentItem.itemId) as ItemObject).shipMap);
		}
		/**
		 * 刷新船舶列表
		 * 添加失败
		 */
		private function refreshADDShipListFail():void
		{
			repairItemView.ADDShipFail();
		}
		/**
		 * 刷新船舶列表 
		 * 删除成功
		 */
		private function refreshDELShipListSuccess():void
		{
			repairItemView.DeleteShipVecSucess(((this._repairItem.categoryMap.getValue(this._currentCategory.cateId) as CategoryObject).itemMap.getValue(this._currentItem.itemId) as ItemObject).shipMap);
		}
		/**
		 * 刷新船舶列表
		 * 删除失败
		 */
		private function refreshDELShipListFail():void
		{
			repairItemView.DeleteShipFail();
		}
		/**
		 * 刷新设备
		 */
		private function refreshEquipList():void
		{
		}
		//----------------------------------------------------------
		/**
		 *点击赋值
		 * @author lisicong
		 */
		public function repairItemClickHandler(tempItemObj:ItemObject):void//每次点击具体修理项的时候 先把原来修理项的内容删除，更新内存
		{
			((this._repairItem.categoryMap.getValue(this._currentCategory.cateId) as CategoryObject).itemMap.getValue(this._currentItem.itemId) as ItemObject).clear();
			this._currentItem=tempItemObj;
			RepairModel.Instance.reqDetailRepairItem(this._currentItem.itemId);
		}
		
		
		public function set currentCategory(value:CategoryObject):void
		{
			_currentCategory = value;
		}
		
		public function set currentItem(value:ItemObject):void
		{
			_currentItem = value;
		}
		
		public function set currentShip(value:ShipObject):void
		{
			_currentShip = value;
		}	
		public function set addDelShipVec(value:Vector.<ShipObject>):void
		{
			_addDelShipVec = value;
		}
		
		public function set addDelCwbt(value:EquipObject):void
		{
			_addDelCwbt = value;
		}
		
		public function set addDelWorkCardVec(value:Vector.<WorkCardObject>):void
		{
			_addDelWorkCardVec = value;
		}
	}
}