package com.boloomo.emop.repair.type
{
	import com.boloomo.util.maps.HashMap;

	/**
	 * 修理项管理页面
	 *   修理项中的设备类
	 * 储存在shipObject中
	 *   @author lisicong
	 */
	public class EquipObject
	{
		private var _equiqId:String="";
		private var _equipName:String="";
		private var _workCardMap:HashMap=new HashMap();
		public function EquipObject()
		{
		}
		public static function parse(val:Object):EquipObject{
			var obj:EquipObject=new EquipObject();
			obj.equiqId=val.idcwbt;
			obj.equipName=val.na;
			return obj;
		}
		public function clear():void
		{
			this.equipName="";
			this._equiqId="";
			this.workCardMap.clear();
		}
		public function isClear():Boolean
		{
			if(this.equipName==""&&this.equiqId==""&&this.workCardMap.isEmpty())
				return true;
			else
				return false;
		}

		
		public function get equiqId():String
		{
			return _equiqId;
		}

		public function set equiqId(value:String):void
		{
			_equiqId = value;
		}

		public function get equipName():String
		{
			return _equipName;
		}

		public function set equipName(value:String):void
		{
			_equipName = value;
		}

		public function get workCardMap():HashMap
		{
			return _workCardMap;
		}

		public function set workCardMap(value:HashMap):void
		{
			_workCardMap = value;
		}


	}
}