package com.boloomo.emop.repair.type
{/**
 * 修理项管理页面
	*   修理项中的修理项类
	*   包含船舶map
	*   @author lisicong
	*/
	import com.boloomo.util.maps.HashMap;
	
	import mx.collections.ArrayCollection;

	public class ItemObj
	{private var _itemId:String="";
		private var _itemName:String="";
		private var _content:String="";
		private var _shipMap:HashMap=new HashMap();//存放船舶
		private var _equipMap:HashMap=new HashMap();//存放设备
		
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

		public static function parse(val:Object):ItemObj{
			var obj:ItemObj=new ItemObj();
			obj.itemId= val.itemid == null? val.iid : val.itemid ;
			obj.itemName= val.itemn == null? val.ina : val.itemn;
			obj.content= val.content == null? val.icon :val.content;
			var arr:Array = new Array();
			arr = val.info;
			obj.equipMap.put(obj.itemId,arr);
			return obj;
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
		public function ItemObj()
		{
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

	}
}