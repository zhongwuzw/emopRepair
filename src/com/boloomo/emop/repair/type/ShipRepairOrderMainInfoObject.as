package com.boloomo.emop.repair.type
{
	import com.boloomo.emop.component.process.ProcessObject;
	import com.boloomo.emop.repair.type.ShipRepairOrderMaterialInfoObject;
	
	public class ShipRepairOrderMainInfoObject
	{
		protected var _shipName:String;//船舶
		protected var _priceNo:String;//询价单号
		
		protected var _deparment:int;//部门
		protected var _purchaseKind:int;//采购类别
		protected var _internalKind:int;//内部分类
		protected var _port:String;//需供货港口
		
		protected var _provideDate:String;//需供货时间
		protected var _purchaseReason:String;//采购原因
		protected var _purchaseNo:String;//采购单号
		protected var _provider:String;//供应商
		protected var _confirmNo:String;//确认单号
		protected var _confirmDate:String;//确认时间
		
		protected var _provideShipDate:String;//供船时间
		protected var _provideLocation:String;//供船地点
		protected var _currency:int;//币种
		protected var _transportFee:Number;//运费
		
		protected var _serviceFee:Number;//服务费
		protected var _otherFee:Number;//其他费用
		protected var _totalFee:Number;//总价
		protected var _toRMB:Number;//合RMB
		
		protected var _orderNo:String;//订购单号
		private var _process:Vector.<ProcessObject>;//流程信息
		
		private var _material:Vector.<ShipRepairOrderMaterialInfoObject>;						//订购订单内容
		
		public static function parse(obj:Object):ShipRepairOrderMainInfoObject
		{
			var order:ShipRepairOrderMainInfoObject = new ShipRepairOrderMainInfoObject();
			//			order.id = String(obj.id);						//订单ID
			order.orderNo = String(obj.sid);					//订购单号
			//			order = String(obj.ship);					//船舶ID
			order.deparment = obj.part;					//部门ID
			//			order. = String(obj.state);				//状态ID
			order.purchaseNo = String(obj.pid);					//采购单号
			order.priceNo = String(obj.eid);					//询价单号
			order.confirmNo = String(obj.cid);					//确认单号
			
			order.provider = obj.provider;
			order.confirmDate = obj.confirmDate;
			order.provideShipDate = obj.provideShipDate;				//送船日期
			order.provideLocation = String(obj.provideLocation);			//送船地点
			
			order.currency = obj.currency;			//币种
			order.serviceFee = obj.serviceFee;			//币种
			order.transportFee = obj.transportFee;			//运费
			order.otherFee = obj.otherFee;				//其他费用
			order.totalFee = obj.totalFee;				//总价
			order.toRMB = obj.toRMB;
			//			order.process = ProcessFunc(obj.process);		//流程信息；
			//			order.material = materialFunc(obj.material);				//子订单列表；
			return order;
		}
		
		public static function ProcessFunc(arr:Array):Vector.<ProcessObject>
		{
			var vec:Vector.<ProcessObject> = new Vector.<ProcessObject>();
			for(var i:int = 0;i < arr.length;i++)
			{
				var obj:ProcessObject = new ProcessObject();
				obj.uname = String(arr[i].nm);
				obj.action = String(arr[i].ac);
				obj.utime = Number(arr[i].tm);
				obj.remark = String(arr[i].rm);
				obj.state = Boolean(arr[i].st);
				vec.push(obj);
			}
			return vec;
		}
		
		public static function materialFunc(arr:Array):Vector.<ShipRepairOrderMaterialInfoObject>
		{
			var vec:Vector.<ShipRepairOrderMaterialInfoObject> = new Vector.<ShipRepairOrderMaterialInfoObject>();
			for(var i:int = 0;i < arr.length;i++)
			{
				var obj:ShipRepairOrderMaterialInfoObject = new ShipRepairOrderMaterialInfoObject();
				obj.materialNo = String(arr[i].materialNo);
				obj.materialKind = String(arr[i].materialKind);
				obj.materialName = String(arr[i].materialName);
				obj.providerNo = arr[i].providerNo;
				obj.purchaseKind = arr[i].purchaseKind;
				obj.location = arr[i].location;
				obj.shipStoreNum = Number(arr[i].store);
				obj.unit = String(arr[i].unit);
				obj.norm = String(arr[i].norm);
				obj.unitPrice = Number(arr[i].pr);
				obj.norm = arr[i].norm;
				obj.num = arr[i].num;
				//				obj.discount = Number(arr[i].cu);
				//				obj.materialKind = Number(arr[i].materialKind)+"";
				//				obj.remark = String(arr[i].rm);
				obj.purchaseKind = arr[i].purchaseKind;
				vec.push(obj);
			}
			return vec;
			
		}
		public function ShipRepairOrderMainInfoObject()
		{
			super();
		}
		
		
		public function get deparment():int
		{
			return _deparment;
		}
		
		public function set deparment(value:int):void
		{
			_deparment = value;
		}
		
		public function get purchaseKind():int
		{
			return _purchaseKind;
		}
		
		public function set purchaseKind(value:int):void
		{
			_purchaseKind = value;
		}
		
		public function get internalKind():int
		{
			return _internalKind;
		}
		
		public function set internalKind(value:int):void
		{
			_internalKind = value;
		}
		
		public function get port():String
		{
			return _port;
		}
		
		public function set port(value:String):void
		{
			_port = value;
		}
		
		public function get provideDate():String
		{
			return _provideDate;
		}
		
		public function set provideDate(value:String):void
		{
			_provideDate = value;
		}
		
		public function get purchaseReason():String
		{
			return _purchaseReason;
		}
		
		public function set purchaseReason(value:String):void
		{
			_purchaseReason = value;
		}
		
		public function get purchaseNo():String
		{
			return _purchaseNo;
		}
		
		public function set purchaseNo(value:String):void
		{
			_purchaseNo = value;
		}
		
		public function get provider():String
		{
			return _provider;
		}
		
		public function set provider(value:String):void
		{
			_provider = value;
		}
		
		public function get confirmNo():String
		{
			return _confirmNo;
		}
		
		public function set confirmNo(value:String):void
		{
			_confirmNo = value;
		}
		
		public function get confirmDate():String
		{
			return _confirmDate;
		}
		
		public function set confirmDate(value:String):void
		{
			_confirmDate = value;
		}
		
		public function get provideShipDate():String
		{
			return _provideShipDate;
		}
		
		public function set provideShipDate(value:String):void
		{
			_provideShipDate = value;
		}
		
		public function get provideLocation():String
		{
			return _provideLocation;
		}
		
		public function set provideLocation(value:String):void
		{
			_provideLocation = value;
		}
		
		public function get currency():int
		{
			return _currency;
		}
		
		public function set currency(value:int):void
		{
			_currency = value;
		}
		
		public function get transportFee():Number
		{
			return _transportFee;
		}
		
		public function set transportFee(value:Number):void
		{
			_transportFee = value;
		}
		
		public function get serviceFee():Number
		{
			return _serviceFee;
		}
		
		public function set serviceFee(value:Number):void
		{
			_serviceFee = value;
		}
		
		public function get otherFee():Number
		{
			return _otherFee;
		}
		
		public function set otherFee(value:Number):void
		{
			_otherFee = value;
		}
		
		public function get totalFee():Number
		{
			return _totalFee;
		}
		
		public function set totalFee(value:Number):void
		{
			_totalFee = value;
		}
		
		public function get toRMB():Number
		{
			return _toRMB;
		}
		
		public function set toRMB(value:Number):void
		{
			_toRMB = value;
		}
		
		public function get shipName():String
		{
			return _shipName;
		}
		
		public function set shipName(value:String):void
		{
			_shipName = value;
		}
		
		public function get priceNo():String
		{
			return _priceNo;
		}
		
		public function set priceNo(value:String):void
		{
			_priceNo = value;
		}
		
		public function get process():Vector.<ProcessObject>
		{
			return _process;
		}
		
		public function set process(value:Vector.<ProcessObject>):void
		{
			_process = value;
		}
		
		public function get material():Vector.<ShipRepairOrderMaterialInfoObject>
		{
			return _material;
		}
		
		public function set material(value:Vector.<ShipRepairOrderMaterialInfoObject>):void
		{
			_material = value;
		}
		
		public function get orderNo():String
		{
			return _orderNo;
		}
		
		public function set orderNo(value:String):void
		{
			_orderNo = value;
		}
		
		
	}
}