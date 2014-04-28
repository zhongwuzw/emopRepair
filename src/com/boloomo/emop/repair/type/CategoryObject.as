package com.boloomo.emop.repair.type
{
	import com.boloomo.util.maps.HashMap;

/**
 * 修理项管理页面
	*   修理项中的修理类别类
	*   包含修理项map
	*   @author lisicong
	*/
	public class CategoryObject
	{
		private var _cateId:String="";
		private var _cateName:String="";
		private var _nChild:int=0;
		private var _itemMap:HashMap=new HashMap();

		public static function parse(val:Object):CategoryObject{
			var obj:CategoryObject=new CategoryObject();
			obj.cateId=val.cateid;
			obj.cateName=val.caten;
			obj._nChild=val.nchild;
			return obj;
		}
		public function CategoryObject()
		{
		}
		public function clear():void
		{
			this.cateId="";
			this.cateName="";
			this._nChild=0;
			this._itemMap.clear();
		}
		public function isClear():Boolean
		{
			if(this.cateId==""&&this.cateName==""&&this.itemMap.isEmpty()&&this._nChild==0)
				return true;
			else
				return false;
		}

		public function get cateId():String
		{
			return _cateId;
		}

		public function set cateId(value:String):void
		{
			_cateId = value;
		}

		public function get cateName():String
		{
			return _cateName;
		}

		public function set cateName(value:String):void
		{
			_cateName = value;
		}

		public function get itemMap():HashMap
		{
			return _itemMap;
		}

		public function set itemMap(value:HashMap):void
		{
			_itemMap = value;
		}
		public function get nChild():int
		{
			return _nChild;
		}
		
		public function set nChild(value:int):void
		{
			_nChild = value;
		}


	}
}