package com.boloomo.emop.repair.util
{
	import com.boloomo.emop.repair.type.process.ProcessStepObject;
	import com.boloomo.emop.repair.type.process.ProcessTaskObject;

	public class PurchaseUtil
	{
		private static var _isShip:Boolean = false;	
//		private static var _curreny:ApplyInfoObject=null;							//当前申请单
		public function PurchaseUtil()
		{
		}
		
		public static function nextStep(step:String,taskobj:ProcessTaskObject):Object
		{
			var vec:Vector.<ProcessStepObject> = taskobj.stepVector;
			var obj:Object = new Object();
			for(var i:int = 0;i < vec.length;i++)
			{
				var temp:ProcessStepObject = vec[i];
				if(temp.stepId == step)
				{
					if(temp.end)
					{
						obj.status = 1;
						obj.stepId = temp.stepId;
					}else{
						obj.status = 0;
						obj.stepId = vec[i+1].stepId;
					}
					break;
				}
			}
			return obj;
		}
		public static function prevStep(step:String,taskobj:ProcessTaskObject):Object
		{
			if(step == "2" || step == "3"){
			step = (parseInt(step)-1).toString();
			}
			var vec:Vector.<ProcessStepObject> = taskobj.stepVector;
			var obj:Object = new Object();
			for(var i:int = 0;i < vec.length;i++)
			{
				var temp:ProcessStepObject = vec[i];
				if(temp.stepId == step)
				{
					if(i == 0)
					{
						obj.status = 0;
						obj.back = true;
						obj.stepId = temp.stepId;
					}else{
						obj.status = 2;
						obj.stepId = vec[i-1].stepId;
						obj.back = false;
					}
					break;
				}
			}
			return obj;
		}

		/**
		 *是否为点击船舶出现列表 false不是;true 是; 
		 */
		public static function get isShip():Boolean
		{
			return _isShip;
		}

		/**
		 * @private
		 */
		public static function set isShip(value:Boolean):void
		{
			_isShip = value;
		}

//		public static function get curreny():ApplyInfoObject
//		{
//			return _curreny;
//		}
//
//		public static function set curreny(value:ApplyInfoObject):void
//		{
//			_curreny = value;
//		}


	}
}