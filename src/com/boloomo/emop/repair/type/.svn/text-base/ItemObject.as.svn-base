package com.boloomo.emop.repair.type
{/**
 * 修理项管理页面
	*   修理项中的修理项类
	*   包含船舶map
	*   @author lisicong
	*/
	import com.boloomo.util.maps.HashMap;

	public class ItemObject
	{
		private var _itemId:String="";
		private var _itemName:String="";
		private var _content:String="";
		private var _shipMap:HashMap=new HashMap();//存放船舶
		private var _equipMap:HashMap=new HashMap();//存放设备
		
		public static function parseDetail(val:Object):ItemObject{
			var obj:ItemObject=new ItemObject();
			obj.itemId=val.itemid;
			obj.itemName=val.itemna;//onHandleDetailRepairItem prase
			obj.content=val.content;
			return obj;
		}
		public static function parse(val:Object):ItemObject{
			var obj:ItemObject=new ItemObject();
			obj.itemId=val.itemid;
			obj.itemName=val.itemn;//onHandleRepairItem prase
			obj.content=val.content;
			return obj;
		}
		public static function TreeNodeparse(val:Object):ItemObject{
			var obj:ItemObject=new ItemObject();
			obj.itemId=val.itemid;
			obj.itemName=val.itemn;
			return obj;
		}
		
		public function ItemObject()
		{
		}
		
		public function clear():void
		{
			this.itemId="";
			this.itemName="";
			this.content="";
			this._shipMap.clear();
		}
		public function isClear():Boolean
		{
			if(this.itemId==""&&this.itemName==""&&this.content==""&&this.shipMap.isEmpty())
				return true;
			else 
				return false;
		}

		public function get itemId():String
		{
			return _itemId;
		}

		public function set itemId(value:String):void
		{
			_itemId = value;
		}

		public function get itemName():String
		{
			return _itemName;
		}

		public function set itemName(value:String):void
		{
			_itemName = value;
		}

		public function get content():String
		{
			return _content;
		}

		public function set content(value:String):void
		{
			_content = value;
		}

		public function get shipMap():HashMap
		{
			return _shipMap;
		}

		public function set shipMap(value:HashMap):void
		{
			_shipMap = value;
		}

		public function get equipMap():HashMap
		{
			return _equipMap;
		}

		public function set equipMap(value:HashMap):void
		{
			_equipMap = value;
		}


	}
}