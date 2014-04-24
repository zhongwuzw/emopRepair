package com.boloomo.emop.repair.type
{
	import com.boloomo.util.maps.HashMap;

/**
 * 修理项管理页面
	 *   修理项中的船舶类
	 *   @author lisicong
	 */
	public class ShipObject
	{
		private var _shipId:String="";
		private var _shipName:String="";
		private var _equipMap:HashMap=new HashMap();
		
		public static function parse(val:Object):ShipObject{
			var obj:ShipObject=new ShipObject();
			obj.shipId=val.id;
			obj.shipName=val.name;
			return obj;
		}
		public function clear():void
		{
			this.shipId="";
			this.shipName="";
			this.equipMap.clear();
		}
		public function isClear():Boolean
		{
			if(this.shipId==""&&this.shipName==""&&this.equipMap.isEmpty())
				return true;
			else
				return false;
		}
		public function get shipId():String
		{
			return _shipId;
		}

		public function set shipId(value:String):void
		{
			_shipId = value;
		}

		public function get shipName():String
		{
			return _shipName;
		}

		public function set shipName(value:String):void
		{
			_shipName = value;
		}

		public function get equipMap():HashMap
		{
			return _equipMap;
		}

		public function set equipMap(value:HashMap):void
		{
			_equipMap = value;
		}

		
		public function ShipObject(){
			
		}
		
	}
}