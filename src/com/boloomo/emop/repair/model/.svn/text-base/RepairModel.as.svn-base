package com.boloomo.emop.repair.model
{
	/**
	 *修船管理控制类 
	 * @author liuyl
	 * 
	 */	
	import com.boloomo.common.Network;
	import com.boloomo.emop.repair.control.RepairItemControl;
	import com.boloomo.emop.repair.type.EquipObject;
	import com.boloomo.emop.repair.type.FactoryRepairObject;
	import com.boloomo.emop.repair.type.ProjectOrderObject;
	import com.boloomo.emop.repair.type.RepairOrderObject;
	import com.boloomo.emop.repair.type.ShipObject;
	import com.boloomo.emop.repair.type.WorkCardObject;
	import com.boloomo.util.StringUtils;
	import com.boloomo.util.TimeUtil;
	
	
	
	public class RepairModel
	{
		private static var g_Instance:RepairModel = null;	
		
		public function RepairModel()
		{
		}
		public static function get Instance():RepairModel
		{
			if(g_Instance==null)
				g_Instance = new RepairModel();
			return g_Instance;
		}
		/**
		 *修船管理请求 
		 * @author lisicong
		 */	
		
		/**
		 *修理项请求类别
		 */	
		public function reqRepairItemCategory():void{
			var requestStr:String='{seq:"11"}';//requestStr = "{seq:"11"}"
			Network.Instance.SendPacket(0x6301,requestStr);
			
//			var temp:String="";
//			RepairControl.Instance.onHandleRepairItemCate(temp);
		}
		/**
		 *修理项数据请求接口
		 */	
		public function reqRepairItem(cateid:String):void{
			var requestStr:String=StringUtils.sprintf('{seq:"%s",cateid:"%s"}',cateid,cateid);
			Network.Instance.SendPacket(0x6302,requestStr);//requestStr = "{seq:"11",cateid:"D"}"
//			var temp:String="";
//			RepairControl.Instance.onHandleRepairItem(temp);
		}
		/**
		 *单个修理项详细数据请求接口
		 */	
		public function reqDetailRepairItem(itemid:String):void{
			var requestStr:String=StringUtils.sprintf('{seq:"11",itemid:"%s"}',itemid);
			Network.Instance.SendPacket(0x6303,requestStr);//requestStr = "{seq:"11",itemid:"D-100"}"
			
//			var temp:String="";
//			RepairControl.Instance.onHandleDetailRepairItem(temp);
		}
		
/*
		/**
		 *修理项数据请求
		 */	
	/*	public function reqAllRepairItem(uid:String):void{
			var requestStr:String=StringUtils.sprintf('{seq:"11",uid:"%s"}',uid);
//			{seq：“”，info：[{cateid：“”，caten：“”，item：[{itemid：“”，itemn：“”},{ itemid：“”，itemn：“”}]},{},{}]};
	/*		var temp:String='{seq:"11",info:[{cateid:"c01",caten:"一般服务",item:[{itemid:"G-101",itemn:"船舶进/出邬",' +
				'itemc:"1.船舶进/出坞各一次，拖轮协助，提供引水服务，配合船舶带；解缆。2.船舶出坞供压载水。3.按施工要求，提供临时消防器材，并接妥消防水，保持水压（24小时不间断）。4.接拆电缆供岸电（24小时）。5.安装临时落水孔泄水铁皮，（以方便油漆）。6.坞内供空调和冰机冷却水。7.保持不间断的保安和消防值班。",ships:"s01|s02|s03|s04|s05|s06"},{itemid:"G-201",itemn:"垃圾等杂项",' +
				'itemc:"8.提供垃圾箱两个,(首尾各一个)供船上搁放生活垃圾。9.高架车配合。",ships:"s01|s02|s03|s04|s05|s06"},{itemid:"G-301",itemn:"坞内望光 倾斜试验",' +
				'itemc:"坞内望光 倾斜试验。船舶载货进坞时- 共带         吨货，为船舶进/出坞（厂）提供拖轮，需     条拖轮，船舶进/出坞（厂）所需引水。",ships:"s01|s02|s03|s04|s05|s06"}]},{cateid:"c02",caten:"坞修工程",item:[{itemid:"D-100",itemn:"坞修工程说明",' +
				'itemc:"坞修工程应包括:（1）坞壁车、坞底升降平台和移动式吊臂车等的使用（2）安装排水孔护罩（3）拉接临时照明4）提供船体极板、测深仪及船速仪护罩。水下及干舷部分防护面漆的涂装工程包括以下项目： 水线标志、艏艉船名、船籍港、载重线标志、IMO标志; 艏/艉侧推标志、船体干舷两面"CHINA SHIPPING"字母;集装箱行（BAY）数码、船舶提供油漆。",ships:"s01|s02|s03|s04|s05|s06"},{itemid:"D-200",itemn:"船体表面处理",' +
				'itemc:"淡水冲洗，驱除污物:平底部分，施工面积 M2，轻重载水线间部分，施工面积 M2。干舷部分，施工面积 M2，高压淡水冲洗 最低 Mpa。平底部分，施工面积 M2，轻重载水线间部分，施工面积 M2。干舷部分，施工面积 M2，对船体损坏 / 锈蚀处实施 Mpa的水喷处理。"},{itemid:"D-201",itemn:"动力磨轮清洁",' +
				'itemc:" 动力磨轮清洁,平底部分，施工面积 M2，轻重载水线间部分，施工面积 M2，干舷部分，施工面积 M2。",ships:"s01|s02|s03|s04|s05|s06"}]},{cateid:"c03",caten:"甲板工程",item:[{itemid:"H-301",itemn:"起锚机",' +
				'itemc:"起锚机   台,制造厂：电动马达  台，齿轮箱 个，考比林连接二端.最大拉力 速度：     吨      m/min.用船供/厂供材料换新刹车带.刹车鼓除锈，刹车系统连接结构加油、活络.滑动式离合器,检查工作状况,刹车系统修理.",ships:"s01|s02|s03|s04|s05|s06"},{itemid:"H-302",itemn:"绞缆机",' +
				'itemc:"绞缆机   台,制造厂：电/液驱动,刹车带用船供/厂供材料换新刹车带刹车鼓除锈，刹车系统连接结构加油、活络刹车系统修理",ships:"s01|s02|s03|s04|s05|s06"}]},{cateid:"c04",caten:"轮机工程",item:[{itemid:"M-102",itemn:"主机调速器",' +
				'itemc:"主机调速器 制造厂： 型号： 出厂编号：主机调速器[调速执行器]及升压器拆卸，送专业厂拆检；各密封件和磨损部件换新（备件厂供），并进行平台调试；装船后实船调试；损坏记录、调试报告等一式三份交船；",ships:"s01|s02|s03|s04|s05|s06"},{itemid:"M-109",itemn:"主机拐挡差",' +
				'itemc:"主机拐挡差：主机修理前后测取拐挡差，记录交船",ships:"s01|s02|s03|s04|s05|s06"},{itemid:"M-204",itemn:"副机空冷器",' +
				'itemc:"副机空冷器 NO1/2...4空冷器拆下，从机舱运到船厂车间；对气面进行化学剂浸泡、清洗；水侧面管子、管板检查、组装后按说明书要求泵压；完工后运回船上装复；检修报告交船；",ships:"s01|s02|s03|s04|s05|s06"}]},{cateid:"c05",caten:"电气工程",item:[{itemid:"E-102",itemn:"轴带发电机",' +
				'itemc:"轴带发电机.制造厂：                出厂编号：型号：电压：  V，电流：  A，功率：  KVA发电机拆卸，拆、装前后测量绝缘及定转子间隙各一次并将记录交船。发电机送车间解体，发电机转子、定子和冷却风叶清洁，检查。发电机定子 / 转子线圈浸绝缘漆并烘干。发电机轴承、轴封和滤网换新后装复（备件船供）。发电机送船装复后，应会同船方作绝缘测量并作记录；空载试运行2小时后，做各种负荷的工况试验。各种试验记录一式三份交船方。",ships:"s01|s02|s03|s04|s05|s06"},{itemid:"E-201",itemn:"电动马达",' +
				'itemc:"电动马达,船厂车间检修：拆下马达，运到车间进行检修。 解体、清洁所有部件。定子浸漆、烘烤，转子拉出清洁，用船供备件换新轴承。组装后，回船装复。马达名称和部位  马达功率合计马达数量。 ",ships:"s01|s02|s03|s04|s05|s06"},{itemid:"E-301",itemn:"自动化设备修理",' +
				'itemc:"自动化设备修理：安排主机电气遥控系统/主机工况监测系统电气工程师登船检修。",ships:"s01|s02|s03|s04|s05|s06"}]}]}';*/
			/*var temp:String='{seq:"11",info:[{cateid:"c01",caten:"Electroic service",item:[{itemid:"G01",itemn:"import"},{itemid:"G02",itemn:"export"}]},{cateid:"c02",caten:"Electroic service1",item:[{itemid:"G02",itemn:"import1"},{itemid:"G02",itemn:"export1"}]}]}';
			RepairControl.Instance.onHandleRepairItem(temp); 
		}
		public function reqSingleRepairItem(itemId:String):void{
			var requestStr:String=StringUtils.sprintf('{seq:"%s",itemid:"%s"}',itemId,itemId);
//			{seq：““，content:"",ships:[{id:””,name:””,equips:[{id:””,na:””,wcs:[{id:””,level:””,owner:””},{}]}, {}] },{}};
			var temp:String=StringUtils.sprintf('{seq:"%s",content:"lalalalala",ships:[{id:"s01",name:"firstShip,equips:[{id:"e01",na:"firstEquip",wcs:[{id:"w01",level:"one",owner:"petter"},{id:"w02",level:"two",owner:"russo"}]}]"}]}',itemId);
			RepairControl.Instance.onHandleSingleRepairItem(temp);
		}*/
		/**
		 *	新建或者修改修理项，增加船舶列表请求
		 * 接口功能区分1.新建修理项。2.修改修理项。
		 */	
		public function reqModRepairItem(type:Number,cateid:String,itemid:String,itemn:String,content:String):void{
			var requestStr:String=StringUtils.sprintf('{seq:"%d",type:%d,cateid:"%s",itemid:"%s",itemn:"%s",content:"%s"}',type,type,cateid,itemid,itemn,content);
			Network.Instance.SendPacket(0x6304,requestStr);//requestStr = "{seq:1,type:1,cateid:"D",itemid:"D-3805",itemn:"修理项的名字",content:""}"
//			requestStr = "{seq:"2",type:2,cateid:"D",itemid:"D-100",itemn:"坞修工程说明1111",content:"坞修工程应包括（1）坞壁车、坞底升降平台和移动式吊臂车等的使用（2）安装排水孔护罩（3）拉接临时照明(4）提供船体极板、测深仪及船速仪护罩水下及干舷部分防护面漆的涂装工程包括以下项目水线标志、艏艉船名、船籍港、载重线标志、IMO标志艏/艉侧推标志、船体干舷两面字母集装箱行（BAY）数码、船舶提供油漆1111111111"}"
//			{eid：0，seq：“”，type：“”，cateid：“”，itemid：“”，shipid：“g01|g02”}
		//	var temp:String=StringUtils.sprintf('{eid:0,seq:"22",type:"%s",cateid:"%s",itemid:"%s",shipid:"%s"}',type,cateid,itemid,shipArray.join("|"));
//			var temp:String=StringUtils.sprintf('{eid:0,etype:0,seq:"%s"}',type);
//			RepairControl.Instance.onHandleModRepairItem(temp);
		}
		/**
		 *		请求可添加工作卡
		 */	
		public function reqAddable(shipId:String,equipId:String):void
		{
//			{seq：““，type：”“，itemid ：”“，shipid：”“，equipid：”“}
			var requestStr:String=StringUtils.sprintf('{seq:"33",shipid:"%s",cwbt:"%s"}',shipId,equipId);
			Network.Instance.SendPacket(0x6305,requestStr);//requestStr = "{seq:"33",shipid:"0001001",cwbt:"AS-102-152-001"}"
//			{seq:””type:””,ships:[{ id:””,name:””},{}],equips:[{ id:””,na:””},{}],wcs:[{ id:””,level:””,owner:””},{}]}
			//var temp:String=StringUtils.sprintf('{seq:"33",type:"%s",ships:[{id:"s03",name:"fireShip"},{id:"s04",name:"rubbishShip"}],equips:[{id:"e04",na:"equipOne"},{id:"e05",na:"equipTwo"}],wcs:[{id:"w03",level:"One",owner:"Steve"},{id:"w04",level:"two",owner:"Martin"}]}');
//			var temp:String="";
//			RepairControl.Instance.onHandleAddable(temp);
		}
		/**
		 *	增加或者删除船舶
		 */
		public function reqAddDelShip(itemId:String,type:Number,shipId:Vector.<ShipObject>):void
		{
//			{seq：““，itemid：”“，type：”“，shipid：”s01|s02“}
			var tempArray:Array=new Array();
			for(var i:int=0;i<shipId.length;i++)
				tempArray.push(shipId[i].shipId);
			var requestStr:String=StringUtils.sprintf('{seq:"%d",itemid:"%s",type:%d,shipids:"%s"}',type,itemId,type,tempArray.join("|"));
//			{seq:””，eid：,type:””,shipids:” s01|s02” }
		//	var temp:String=StringUtils.sprintf('{seq:"11",eid:0,type:"%s",shipids:"%s"}',type,shipId.join("|"));
			RepairItemControl.Instance.addDelShipVec=shipId;
			Network.Instance.SendPacket(0x6306,requestStr);//requestStr = "{seq:2,itemid:"D-100",type:2,shipids:"0001001"}"
			//requestStr = "{seq:1,itemid:"D-100",type:1,shipids:"0001009"}"//requestStr = "{seq:2,itemid:"D-100",type:2,shipids:"0001009"}"
			
//			var temp:String=StringUtils.sprintf('{seq:"%s",eid:0}',type);
//			RepairControl.Instance.onHandleAddDelShip(temp);
		}
		/**
		 *	增加或者删除设备
		 */
		public function reqAddDelEquip(itemId:String,type:Number,shipId:String,equipObj:EquipObject):void
		{
//			{seq：““，itemid：”“，shipid：”“，type：”“，equipids：”e01|e02“}
			var requestStr:String=StringUtils.sprintf('{seq:"%d",itemid:"%s",shipid:"%s",type:%d,cwbts:"%s"}',type,itemId,shipId,type,equipObj.equiqId);
//			{seq:””，eid：,type:””,equipids:” e01|e02” }
			RepairItemControl.Instance.addDelCwbt=equipObj;
			Network.Instance.SendPacket(0x6307,requestStr);//requestStr = "{seq:"33",itemid:"D-100",shipid:"0001022",type:"1",cwbts:"AS-102-152-002"}"//requestStr = "{seq:"1",itemid:"D-100",shipid:"0001001",type:1,cwbts:"AS-102-152-003"}"
//			var temp:String=StringUtils.sprintf('{seq:"%s",eid:0}',type);
//			RepairControl.Instance.onHandleAddDelEquip(temp);
		}
		/**
		 *	增加或者删除工作卡
		 * 1为增加的工作卡id，
		 * 2为删除的工作卡id
		 */
		public function reqAddDelWorkCard(itemId:String,type:Number,shipId:String,equipId:String,wcId:Vector.<WorkCardObject>):void
		{
//			{seq：““，itemid：”“，shipid：”“，equipid：”“，type：”“，wcsids：”w01|w02“}
			var tempArray:Array=new Array();
			for(var i:int=0;i<wcId.length;i++)
				tempArray.push(wcId[i].workCardId);
			var requestStr:String=StringUtils.sprintf('{seq:"%d",itemid:"%s",shipid:"%s",type:%d,cwbt:"%s",wcsids:"%s"}',type,itemId,shipId,type,equipId,tempArray.join("|"));
			RepairItemControl.Instance.addDelWorkCardVec=wcId;//requestStr = "{seq:"2",itemid:"D-100",shipid:"0001001",type:2,cwbt:"AS-102-152-001",wcsids:"JBS000100100000"}"
			Network.Instance.SendPacket(0x6308,requestStr);//requestStr = "{seq:"NaN",itemid:"0001001",shipid:"2",type:NaN,cwbt:"JBS000100100000",wcsids:"undefined"}"
//			var temp:String=StringUtils.sprintf('{seq:"11",eid:0}',type);
//			RepairControl.Instance.onHandleAddDelWorkCard(temp);
		}
		/**
		 *	删除修理项
		 */	
		public function reqDelRepairItem(itemid:String):void
		{
			var requestStr:String=StringUtils.sprintf('{seq:"33",itemid:"%s"}',itemid);
//			var temp:String='{seq:"33",eid:0}';
//			RepairControl.Instance.onHandleDelRepairItem(temp);
			Network.Instance.SendPacket(0x6309,requestStr);//requestStr = "{seq:"33",uid:"11",itemid:"D-100"}"//requestStr = "{seq:"33",itemid:"D-380"}
		}
		/**
		 *修理单管理请求 
		 * @author lisicong
		 */	
		
		/**
		 *请求修理单数据   
		 */
		public function reqRepairOrder(uid:String):void
		{
			var requestStr:String=StringUtils.sprintf('{seq:"44",uid:"%s",shipid:"",tp:"",deparid:"",proc:"",link:"",st:""}',uid);
           //		{seq：“”，info：[{applyid：“”，shipid：“”，depart：“”，type：“”，state：“”，com：“”，date：，day：“”，loc：“”，proid：“”，ad: [{id:””,na:”附件1.jpg”},{id:””,na:”附件1.jpg”}]，itinfo：[{itemid：“”，itemn：“”，content：“”},{ itemid：“”，itemn：“”，content：“”}] },{}]}
	/*		var temp:String='{seq:"44",info:[{applyid:"XS11110001",shipid:"s01",depart:"电气",type:"0",state:"0",com:"大连造船厂",date:9000000000,day:"4",loc:"天津",proid:"p11110111",ad:[{id:"f01",na:"附件1.jpg"},{id:"f02",na:"附件2.jpg"}],itinfo:[{itemid:"G-101",itemn:"船舶进/出邬",content:"1.船舶进/出坞各一次，拖轮协助，提供引水服务，配合船舶带；解缆。2.船舶出坞供压载水。3.按施工要求，提供临时消防器材，并接妥消防水，保持水压（24小时不间断）。4.接拆电缆供岸电（24小时）。5.安装临时落水孔泄水铁皮，（以方便油漆）。6.坞内供空调和冰机冷却水。7.保持不间断的保安和消防值班。"},{itemid:"G-301",itemn:"坞内望光 倾斜试验",content:"坞内望光 倾斜试验。船舶载货进坞时- 共带         吨货，为船舶进/出坞（厂）提供拖轮，需     条拖轮，船舶进/出坞（厂）所需引水。"},{itemid:"D-100",itemn:"坞修工程说明",content:"坞修工程应包括:（1）坞壁车、坞底升降平台和移动式吊臂车等的使用（2）安装排水孔护罩（3）拉接临时照明4）提供船体极板、测深仪及船速仪护罩。水下及干舷部分防护面漆的涂装工程包括以下项目： 水线标志、艏艉船名、船籍港、载重线标志、IMO标志; 艏/艉侧推标志、船体干舷两面CHINA SHIPPING字母;集装箱行（BAY）数码、船舶提供油漆。"}]},' +
				'{applyid:"XS11110002",shipid:"s01",depart:"甲板",type:"1",state:"1",com:"大连造船厂",date:9000000066,day:"5",loc:"天津",proid:"p11110111",ad:[{id:"f01",na:"附件1.jpg"},{id:"f02",na:"附件2.jpg"}],itinfo:[{itemid:"G-101",itemn:"船舶进/出邬",content:"1.船舶进/出坞各一次，拖轮协助，提供引水服务，配合船舶带；解缆。2.船舶出坞供压载水。3.按施工要求，提供临时消防器材，并接妥消防水，保持水压（24小时不间断）。4.接拆电缆供岸电（24小时）。5.安装临时落水孔泄水铁皮，（以方便油漆）。6.坞内供空调和冰机冷却水。7.保持不间断的保安和消防值班。"},{itemid:"G-301",itemn:"坞内望光 倾斜试验",content:"坞内望光 倾斜试验。船舶载货进坞时- 共带         吨货，为船舶进/出坞（厂）提供拖轮，需     条拖轮，船舶进/出坞（厂）所需引水。"},{itemid:"D-100",itemn:"坞修工程说明",content:"坞修工程应包括:（1）坞壁车、坞底升降平台和移动式吊臂车等的使用（2）安装排水孔护罩（3）拉接临时照明4）提供船体极板、测深仪及船速仪护罩。水下及干舷部分防护面漆的涂装工程包括以下项目： 水线标志、艏艉船名、船籍港、载重线标志、IMO标志; 艏/艉侧推标志、船体干舷两面CHINA SHIPPING字母;集装箱行（BAY）数码、船舶提供油漆。"}]},' +
				'{applyid:"XS11110003",shipid:"s01",depart:"轮机",type:"0",state:"2",com:"大连造船厂",date:9000000500,day:"9",loc:"天津",proid:"p11110112",ad:[{id:"f01",na:"附件1.jpg"},{id:"f02",na:"附件2.jpg"}],itinfo:[{itemid:"G-101",itemn:"船舶进/出邬",content:"1.船舶进/出坞各一次，拖轮协助，提供引水服务，配合船舶带；解缆。2.船舶出坞供压载水。3.按施工要求，提供临时消防器材，并接妥消防水，保持水压（24小时不间断）。4.接拆电缆供岸电（24小时）。5.安装临时落水孔泄水铁皮，（以方便油漆）。6.坞内供空调和冰机冷却水。7.保持不间断的保安和消防值班。"},{itemid:"G-301",itemn:"坞内望光 倾斜试验",content:"坞内望光 倾斜试验。船舶载货进坞时- 共带         吨货，为船舶进/出坞（厂）提供拖轮，需     条拖轮，船舶进/出坞（厂）所需引水。"},{itemid:"D-100",itemn:"坞修工程说明",content:"坞修工程应包括:（1）坞壁车、坞底升降平台和移动式吊臂车等的使用（2）安装排水孔护罩（3）拉接临时照明4）提供船体极板、测深仪及船速仪护罩。水下及干舷部分防护面漆的涂装工程包括以下项目： 水线标志、艏艉船名、船籍港、载重线标志、IMO标志; 艏/艉侧推标志、船体干舷两面CHINA SHIPPING字母;集装箱行（BAY）数码、船舶提供油漆。"}]},' +
				'{applyid:"XS11110004",shipid:"s01",depart:"电气",type:"0",state:"2",com:"大连造船厂",date:9000000230,day:"9",loc:"青岛",proid:"p11110110",ad:[{id:"f01",na:"附件1.jpg"},{id:"f02",na:"附件2.jpg"}],itinfo:[{itemid:"G-101",itemn:"船舶进/出邬",content:"1.船舶进/出坞各一次，拖轮协助，提供引水服务，配合船舶带；解缆。2.船舶出坞供压载水。3.按施工要求，提供临时消防器材，并接妥消防水，保持水压（24小时不间断）。4.接拆电缆供岸电（24小时）。5.安装临时落水孔泄水铁皮，（以方便油漆）。6.坞内供空调和冰机冷却水。7.保持不间断的保安和消防值班。"},{itemid:"G-301",itemn:"坞内望光 倾斜试验",content:"坞内望光 倾斜试验。船舶载货进坞时- 共带         吨货，为船舶进/出坞（厂）提供拖轮，需     条拖轮，船舶进/出坞（厂）所需引水。"},{itemid:"D-100",itemn:"坞修工程说明",content:"坞修工程应包括:（1）坞壁车、坞底升降平台和移动式吊臂车等的使用（2）安装排水孔护罩（3）拉接临时照明4）提供船体极板、测深仪及船速仪护罩。水下及干舷部分防护面漆的涂装工程包括以下项目： 水线标志、艏艉船名、船籍港、载重线标志、IMO标志; 艏/艉侧推标志、船体干舷两' +
                    '面CHINA SHIPPING字母;集装箱行（BAY）数码、船舶提供油漆。"}]}]}';
			var temp:String='{seq:"44",info:[' +
				'{applyid:"XS11110001",shipid:"0001022",sn:"新海口",did:"DE000000000001001004",depart:"电气",type:"0",state:"0",com:"",adate:9000000000,bdate:9000000000,fdate:9172800000,pland:90000000000,maded:90000000000,day:"4",loc:"天津",proid:"p11110111",taskId:"11",taskName:"申请",stepId:"1",stepName:"申请",status:1,statusName:"未提交",pstate:"0",ad:[{id:"f01",na:"附件1.jpg"},{id:"f02",na:"附件2.jpg"}],itinfo:{itemid:"G-101",itemn:"船舶进/出邬",content:"1.船舶进/出坞各一次，拖轮协助，提供引水服务，配合船舶带；解缆。2.船舶出坞供压载水。3.按施工要求，提供临时消防器材，并接妥消防水，保持水压（24小时不间断）。4.接拆电缆供岸电（24小时）。5.安装临时落水孔泄水铁皮，（以方便油漆）。6.坞内供空调和冰机冷却水。7.保持不间断的保安和消防值班。"}},' +
				'{applyid:"XS11110002",shipid:"0001001",sn:"新厦门",did:"DE000000000001001001",depart:"轮机",type:"1",state:"1",com:"自修",adate:9000000000,bdate:9000000000,fdate:9086400000,pland:90000000000,maded:90000000000,day:"5",loc:"天津",proid:"p11110111",taskId:"11",taskName:"申请",stepId:"1",stepName:"申请",status:1,statusName:"未提交",pstate:"1",ad:[{id:"f01",na:"附件1.jpg"},{id:"f02",na:"附件2.jpg"}],itinfo:{itemid:"G-101",itemn:"船舶进/出邬",content:"1.船舶进/出坞各一次，拖轮协助，提供引水服务，配合船舶带；解缆。2.船舶出坞供压载水。3.按施工要求，提供临时消防器材，并接妥消防水，保持水压（24小时不间断）。4.接拆电缆供岸电（24小时）。5.安装临时落水孔泄水铁皮，（以方便油漆）。6.坞内供空调和冰机冷却水。7.保持不间断的保安和消防值班。"}},' +
				'{applyid:"XS11110003",shipid:"0001025",sn:"新长沙",did:"DE000000000001001002",depart:"甲板",type:"0",state:"2",com:"大连造船厂",adate:9000000000,bdate:9000000000,fdate:9172800000,pland:90000000000,maded:90000000000,day:"9",loc:"天津",proid:"p11110112",taskId:"11",taskName:"申请",stepId:"1",stepName:"申请",status:1,statusName:"未提交",pstate:"2",ad:[{id:"f01",na:"附件1.jpg"},{id:"f02",na:"附件2.jpg"}],itinfo:{itemid:"G-101",itemn:"船舶进/出邬",content:"1.船舶进/出坞各一次，拖轮协助，提供引水服务，配合船舶带；解缆。2.船舶出坞供压载水。3.按施工要求，提供临时消防器材，并接妥消防水，保持水压（24小时不间断）。4.接拆电缆供岸电（24小时）。5.安装临时落水孔泄水铁皮，（以方便油漆）。6.坞内供空调和冰机冷却水。7.保持不间断的保安和消防值班。"}},' +
				'{applyid:"XS11110004",shipid:"0001022",sn:"新海口",did:"DE000000000001001004",depart:"电气",type:"0",state:"2",com:"大连造船厂",adate:9000000000,bdate:9000000000,fdate:9086400000,pland:90000000000,maded:90000000000,day:"9",loc:"青岛",proid:"p11110110",taskId:"11",taskName:"申请",stepId:"1",stepName:"申请",status:1,statusName:"未提交",pstate:"0",ad:[{id:"f01",na:"附件1.jpg"},{id:"f02",na:"附件2.jpg"}],itinfo:{itemid:"G-101",itemn:"船舶进/出邬",content:"1.船舶进/出坞各一次，拖轮协助，提供引水服务，配合船舶带；解缆。2.船舶出坞供压载水。3.按施工要求，提供临时消防器材，并接妥消防水，保持水压（24小时不间断）。4.接拆电缆供岸电（24小时）。5.安装临时落水孔泄水铁皮，（以方便油漆）。6.坞内供空调和冰机冷却水。7.保持不间断的保安和消防值班。"}}' +
				']}';
			RepairListManagerControl.Instance.onApplylistPacket(temp);*/
			Network.Instance.SendPacket(0x6311,requestStr);
			trace(requestStr);
		
		}
		/**
		 *请求修理单详细数据
		 */
		public function reqDetailRepairOrder(applyid:String):void
		{
			var requestStr:String=StringUtils.sprintf('{seq:"44",applyid:"%s"}',applyid);
			/*var temp:String="";
			RepairControl.Instance.onHandleDetailRepairOrder(temp);*/
			Network.Instance.SendPacket(0x6312,requestStr);
			trace(requestStr);
		}
		/**
		 *新建或者修改修理单
		 */
		public function reqAddModRepairOrder(distype:Number,repairOrder:RepairOrderObject):void
		{
			var requestStr:String;
			if(repairOrder.itemObj.isClear())
				requestStr=StringUtils.sprintf('{seq:"%d",distype:%d,applyid:"%s",shipid:"%s",deparid:"%s",type:"%s",self:%d,comid:"%s",comna:"%s",' +
					'adate:%d,bdate:%d,fdate:%d,loc:"%s",rbdate:%d,rfdate:%d}',distype,distype,repairOrder.applyId,repairOrder.shipId,repairOrder.departId,repairOrder.type,repairOrder.self,repairOrder.companyId,repairOrder.company,
					repairOrder.adate,repairOrder.bdate,repairOrder.fdate,repairOrder.location,repairOrder.rbdate,repairOrder.rfdate);
			else if(repairOrder.itemObj.equipMap.isEmpty())
				requestStr=StringUtils.sprintf('{seq:"%d",distype:%d,applyid:"%s",shipid:"%s",deparid:"%s",type:"%s",self:%d,comid:"%s",comna:"%s",' +
					'adate:%d,bdate:%d,fdate:%d,loc:"%s",rbdate:%d,rfdate:%d,item:{iid:"%s",ina:"%s",icon:"%s"}}',distype,distype,repairOrder.applyId,repairOrder.shipId,repairOrder.departId,repairOrder.type,repairOrder.self,repairOrder.companyId,repairOrder.company,
					repairOrder.adate,repairOrder.bdate,repairOrder.fdate,repairOrder.location,repairOrder.rbdate,repairOrder.rfdate,repairOrder.itemObj.itemId,repairOrder.itemObj.itemName,repairOrder.itemObj.content);
			else if(!repairOrder.itemObj.equipMap.isEmpty())
			{
				var tempArray:Array=repairOrder.itemObj.equipMap.getValues();
				var str:String="";
				for(var i:int=0;i<tempArray.length;i++)
				{
					if(!tempArray[i].workCardMap.isEmpty())
					{
						var tempWorkArray:Array=tempArray[i].workCardMap.getValues();
						var strTemp:String="";
						for(var j:int=0;j<tempWorkArray.length;j++)
							strTemp+=StringUtils.sprintf('{id:"%s",level:"%s",owner:"%s"},',tempWorkArray[j].workCardId,tempWorkArray[j].level,tempWorkArray[j].owner)
						strTemp=strTemp.substr(0,strTemp.length-1);
						str+=StringUtils.sprintf('{cwbt:"%s",na:"%s",wcs:[%s]},',tempArray[i].equiqId,tempArray[i].equipName,strTemp);
					}
						str+=StringUtils.sprintf('{cwbt:"%s",na:"%s"},',tempArray[i].equiqId,tempArray[i].equipName)
				}
				str=str.substr(0,str.length-1);	
				requestStr=StringUtils.sprintf('{seq:"%d",distype:%d,applyid:"%s",shipid:"%s",deparid:"%s",type:"%s",self:%d,comid:"%s",comna:"%s",' +
					'adate:%d,bdate:%d,fdate:%d,loc:"%s",rbdate:%d,rfdate:%d,item:{iid:"%s",ina:"%s",icon:"%s",info:[%s]}}',distype,distype,repairOrder.applyId,repairOrder.shipId,repairOrder.departId,repairOrder.type,repairOrder.self,repairOrder.companyId,repairOrder.company,
					repairOrder.adate,repairOrder.bdate,repairOrder,repairOrder.location,repairOrder.rbdate,repairOrder.rfdate,repairOrder.itemObj.itemId,repairOrder.itemObj.itemName,repairOrder.itemObj.content,str);
			}
			/*	var temp:String="";
//			{eid：0，seq：“”，type：“”，applyid：“”, item：{ina：”“，icon：”“，ldate：，lname：”“， info：[{cwbt:””,na:””,wcs:[{id:””,level:””,owner:””},{}]}, {}]]}}
//			var temp:String=StringUtils.sprintf('{eid:0,seq:"55",type:"%s",applyid:"%s"}',distype,repairOrder.applyId);
			RepairControl.Instance.onHandleAddModRepairOrder(temp);*/
			
			Network.Instance.SendPacket(0x6313,requestStr);
			trace(requestStr);
		}
		/**
		 *申请船舶修理项列表
		 */
		public function reqRepairItemList(shipid:String):void
		{//{seq：“”，uid：“”，shipid：“”}
			var requestStr:String=StringUtils.sprintf('{seq:"66",shipid:"%s"}',shipid);
//			{seq：“”，info：[{itemid：“”，itemn：“”，content：“”},{ itemid：“”，itemn：“”，content：“”}]}
//			var temp:String='{seq:"66",info:[{itemid:"G-109",itemn:"船舶进/出邬",content:"1.船舶进/出坞各一次，拖轮协助，提供引水服务，配合船舶带；解缆。2.船舶出坞供压载水。3.按施工要求，提供临时消防器材，并接妥消防水，保持水压（24小时不间断）。4.接拆电缆供岸电（24小时）。"},{itemid:"D-100",itemn:"坞修工程说明",content:"坞修工程应包括:（1）坞壁车、坞底升降平台和移动式吊臂车等的使用（2）安装排水孔护罩（3）拉接临时照明4）提供船体极板、测深仪及船速仪护罩。水下及干舷部分防护面漆的涂装工程包括以下项目： 水线标志、艏艉船名、船籍港、载重线标志、IMO标志; 艏/艉侧推标志、船体干舷两面CHINA SHIPPING字母;集装箱行（BAY）数码、船舶提供油漆。"},{itemid:"H-301",itemn:"起锚机",itemc:"起锚机   台,制造厂：电动马达  台，齿轮箱 个，考比林连接二端.最大拉力 速度：     吨      m/min.用船供/厂供材料换新刹车带.刹车鼓除锈，刹车系统连接结构加油、活络.滑动式离合器,检查工作状况,刹车系统修理."},{itemid:"K-100"，itemn:"主机调速器"，content:"主机调速器 制造厂： 型号： 出厂编号：主机调速器[调速执行器]及升压器拆卸，送专业厂拆检；各密封件和磨损部件换新（备件厂供），并进行平台调试；装船后实船调试；损坏记录、调试报告等一式三份交船；"},{itemid:"M-108",itemn:"舷梯",content:"舷梯：左/右舷梯吊厂作全面检查，作负荷试验并取得船级社证书，完工后装回复位。上转盘支架拆厂解体修理，完工后装回复位。扶手立柱- 原地修理， 换新，扶手导杆- 原地修理，换新,"}]}'
/*			var temp:String="";
			RepairControl.Instance.onHandleRepairItemList(temp);*/
			
			Network.Instance.SendPacket(0x6314,requestStr);
			trace(requestStr);
		}
		/**
		 *修改修理项
		 */
	/*	public function reqModRepairItemList(uid:String,applyid:String,itemidArray:Array):void
		{//{seq：“”，uid:"",applyid：“”，itemid：“i01|i02|i03”}
			var requestStr:String=StringUtils.sprintf('{seq:"77",uid:"%s",applyid:"%s",itemid:"%s"}',uid,applyid,itemidArray.join("|"));
			var temp:String='{seq:"77",eid:0}';
			RepairControl.Instance.onHandleModRepairItemList(temp);
		}*/
		/**
		 *申请状态变化
		 */	
		public function reqChangeState(applyid:String,uid:String,proc:String,link:String,st:Number,remark:String):void
		{//{seq：“”，applyid：“”,proc:””,link:””,st:”"}
			var requestStr:String=StringUtils.sprintf('{seq:"88",uid:"%s",applyid:"%s",proc:"%s",link:"%s",st:%d,remark:"%s"}',uid,applyid,proc,link,st,remark);
	/*		if(fn!=""||fc!=""||ft!=0||fr!=""||fs!="")
			{
				var tempProcess:ProcessObject=new ProcessObject();
				tempProcess.uname=fn;
				tempProcess.action=fc;
				tempProcess.utime=ft;
				tempProcess.remark=fr;
				tempProcess.state=fs;
				RepairControl.Instance.addChangeState(tempProcess);
			}*/
		/*	var temp:String="";
			RepairControl.Instance.onHandleChangeState(temp);*/
			Network.Instance.SendPacket(0x6315,requestStr);
			trace(requestStr);
		}
		/**
		 *删除申请单
		 */	
		public function reqDelRepairOrder(applyid:String):void
		{//{seq：“”，uid：“”，applyid：“”}
			var requestStr:String=StringUtils.sprintf('{seq:"11",applyid:"%s"}',applyid);
	/*		var temp:String='{seq:"99",eid:0}';
			RepairControl.Instance.onHandleDelRepairOrder(temp);*/
			
			Network.Instance.SendPacket(0x6316,requestStr);
			trace(requestStr);
		}
		
		
		
		
		/**
		 *工程单管理请求 
		 * @author lisicong
		 */	
		
		/**
		 *请求工程单
		 */	
//		 {seq：“”，info：[{proid：“”，shipid：“”，type：“”，state：“”，loc：“”，date：，day：“”，bday：，fday：，com：“”，plan：“”，alert：“”，illu：“a|b|c|d”，applyid：“a01|a02|a03”，avapplyid：“a07|a08|a09”，itinfo：[{itemid：“”，itemn：“”，content：“”},{ itemid：“”，itemn：“”，content：“”}]},{}]}
		public function reqProjectOrder(uid:String):void
		{
		//	var requestStr:String;
		//	requestStr=StringUtils.sprintf('{seq:"10",uid:"%s"}',uid);
	/*		var temp:String='{seq:"10",info:[{proid:"CG22220001",shipid:"s01",type:"2",state:"2",loc:"天津",date:200000000,day:"3",bday:200000000,fday:3000000000,com:"中海电信有限公司",plan:"没有计划哦",alert:"请注意",illu:"a|b|f|e",applyid:"XS11110001|XS11110002|XS11110003",avapplyid:"XS11110004|XS11110005|XS11110006",itinfo:[{itemid:"G-109",itemn:"船舶进/出邬",content:"1.船舶进/出坞各一次，拖轮协助，提供引水服务，配合船舶带；解缆。2.船舶出坞供压载水。3.按施工要求，提供临时消防器材，并接妥消防水，保持水压（24小时不间断）。4.接拆电缆供岸电（24小时）。"},{itemid:"D-100",itemn:"坞修工程说明",content:"坞修工程应包括:（1）坞壁车、坞底升降平台和移动式吊臂车等的使用（2）安装排水孔护罩（3）拉接临时照明4）提供船体极板、测深仪及船速仪护罩。水下及干舷部分防护面漆的涂装工程包括以下项目： 水线标志、艏艉船名、船籍港、载重线标志、IMO标志; 艏/艉侧推标志、船体干舷两面CHINA SHIPPING字母;集装箱行（BAY）数码、船舶提供油漆。"},{itemid:"H-301",itemn:"起锚机",itemc:"起锚机   台,制造厂：电动马达  台，齿轮箱 个，考比林连接二端.最大拉力 速度：     吨      m/min.用船供/厂供材料换新刹车带.刹车鼓除锈，刹车系统连接结构加油、活络.滑动式离合器,检查工作状况,刹车系统修理."}]},{proid:"CG22220002",shipid:"s01",type:"3",state:"3",loc:"青岛",date:200000001,day:"4",bday:200000010,fday:3008000020,com:"中海电信有限公司",plan:"没有计划哦",alert:"请注意",illu:"a|b|c|e",applyid:"XS11110002|XS11110005|XS11110003",avapplyid:"XS11110006|XS11110007|XS11110009",itinfo:[{itemid:"G-109",itemn:"船舶进/出邬",content:"1.船舶进/出坞各一次，拖轮协助，提供引水服务，配合船舶带；解缆。2.船舶出坞供压载水。3.按施工要求，提供临时消防器材，并接妥消防水，保持水压（24小时不间断）。4.接拆电缆供岸电（24小时）。"},{itemid:"D-100",itemn:"坞修工程说明",content:"坞修工程应包括:（1）坞壁车、坞底升降平台和移动式吊臂车等的使用（2）安装排水孔护罩（3）拉接临时照明4）提供船体极板、测深仪及船速仪护罩。水下及干舷部分防护面漆的涂装工程包括以下项目： 水线标志、艏艉船名、船籍港、载重线标志、IMO标志; 艏/艉侧推标志、船体干舷两面CHINA SHIPPING字母;集装箱行（BAY）数码、船舶提供油漆。"},{itemid:"H-301",itemn:"起锚机",itemc:"起锚机   台,制造厂：电动马达  台，齿轮箱 个，考比林连接二端.最大拉力 速度：     吨      m/min.用船供/厂供材料换新刹车带.刹车鼓除锈，刹车系统连接结构加油、活络.滑动式离合器,检查工作状况,刹车系统修理."}]},{proid:"CG22220001",shipid:"s03",type:"2",state:"3",loc:"天津",date:200000900,day:"1",bday:200000800,fday:3000000700,com:"上海星星救生消防设备服务有限公司",plan:"没有计划哦",alert:"请注意",illu:"a|i|j|k",applyid:"XS11110003|XS11110004|XS11110009",avapplyid:"XS11110019|XS11110014|XS11110013",itinfo:[{itemid:"G-109",itemn:"船舶进/出邬",content:"1.船舶进/出坞各一次，拖轮协助，提供引水服务，配合船舶带；解缆。2.船舶出坞供压载水。3.按施工要求，提供临时消防器材，并接妥消防水，保持水压（24小时不间断）。4.接拆电缆供岸电（24小时）。"},{itemid:"D-100",itemn:"坞修工程说明",content:"坞修工程应包括:（1）坞壁车、坞底升降平台和移动式吊臂车等的使用（2）安装排水孔护罩（3）拉接临时照明4）提供船体极板、测深仪及船速仪护罩。水下及干舷部分防护面漆的涂装工程包括以下项目： 水线标志、艏艉船名、船籍港、载重线标志、IMO标志; 艏/艉侧推标志、船体干舷两面CHINA SHIPPING字母;集装箱行（BAY）数码、船舶提供油漆。"},{itemid:"H-301",itemn:"起锚机",itemc:"起锚机   台,制造厂：电动马达  台，齿轮箱 个，考比林连接二端.最大拉力 速度：     吨      m/min.用船供/厂供材料换新刹车带.刹车鼓除锈，刹车系统连接结构加油、活络.滑动式离合器,检查工作状况,刹车系统修理."}]},{proid:"CG22220001",shipid:"s02",type:"3",state:"2",loc:"上海",date:200000500,day:"5",bday:200000400,fday:3000000400,com:"上海申颜电机有限公司",plan:"没有计划哦",alert:"请注意",illu:"a|n|m|o",applyid:"XS11110002|XS11110003|XS11110004",avapplyid:"XS11110011|XS11110010|XS11110009",itinfo:[{itemid:"G-109",itemn:"船舶进/出邬",content:"1.船舶进/出坞各一次，拖轮协助，提供引水服务，配合船舶带；解缆。2.船舶出坞供压载水。3.按施工要求，提供临时消防器材，并接妥消防水，保持水压（24小时不间断）。4.接拆电缆供岸电（24小时）。"},{itemid:"D-100",itemn:"坞修工程说明",content:"坞修工程应包括:（1）坞壁车、坞底升降平台和移动式吊臂车等的使用（2）安装排水孔护罩（3）拉接临时照明4）提供船体极板、测深仪及船速仪护罩。水下及干舷部分防护面漆的涂装工程包括以下项目： 水线标志、艏艉船名、船籍港、载重线标志、IMO标志; 艏/艉侧推标志、船体干舷两面CHINA SHIPPING字母;集装箱行（BAY）数码、船舶提供油漆。"},{itemid:"H-301",itemn:"起锚机",itemc:"起锚机   台,制造厂：电动马达  台，齿轮箱 个，考比林连接二端.最大拉力 速度：     吨      m/min.用船供/厂供材料换新刹车带.刹车鼓除锈，刹车系统连接结构加油、活络.滑动式离合器,检查工作状况,刹车系统修理."}]}]}';*/

	//		var temp:String = '{seq:"10",info:[{proid:"CG22220001",shipid:"s01",shipna:"新厦门",tp:"1",st:"1",loc:"天津",comid:"01",comna:"天津船修集团公司",facid:"01",facna:"计划没有",psday:100,pfday:100000000,asday:200000000,afday:400000000}]}';
		//	requestStr=StringUtils.sprintf('{seq:"10",uid:"%s"}',uid);

		//	RepairControl.Instance.onHandleProjectOrder(temp);
//			var temp:String='{seq:"10",info:[{proid:"CG22220001",shipid:"s01",type:"2",state:"2",loc:"天津",date:200000000,day:"3",bday:200000000,fday:3000000000,com:"中海电信有限公司",plan:"没有计划哦",alert:"请注意",illu:"a|b|f|e",applyid:"XS11110001|XS11110002|XS11110003",avapplyid:"XS11110004|XS11110005|XS11110006",itinfo:[{itemid:"G-109",itemn:"船舶进/出邬",content:"1.船舶进/出坞各一次，拖轮协助，提供引水服务，配合船舶带；解缆。2.船舶出坞供压载水。3.按施工要求，提供临时消防器材，并接妥消防水，保持水压（24小时不间断）。4.接拆电缆供岸电（24小时）。"},{itemid:"D-100",itemn:"坞修工程说明",content:"坞修工程应包括:（1）坞壁车、坞底升降平台和移动式吊臂车等的使用（2）安装排水孔护罩（3）拉接临时照明4）提供船体极板、测深仪及船速仪护罩。水下及干舷部分防护面漆的涂装工程包括以下项目： 水线标志、艏艉船名、船籍港、载重线标志、IMO标志; 艏/艉侧推标志、船体干舷两面CHINA SHIPPING字母;集装箱行（BAY）数码、船舶提供油漆。"},{itemid:"H-301",itemn:"起锚机",itemc:"起锚机   台,制造厂：电动马达  台，齿轮箱 个，考比林连接二端.最大拉力 速度：     吨      m/min.用船供/厂供材料换新刹车带.刹车鼓除锈，刹车系统连接结构加油、活络.滑动式离合器,检查工作状况,刹车系统修理."}]},{proid:"CG22220002",shipid:"s01",type:"3",state:"3",loc:"青岛",date:200000001,day:"4",bday:200000010,fday:3008000020,com:"中海电信有限公司",plan:"没有计划哦",alert:"请注意",illu:"a|b|c|e",applyid:"XS11110002|XS11110005|XS11110003",avapplyid:"XS11110006|XS11110007|XS11110009",itinfo:[{itemid:"G-109",itemn:"船舶进/出邬",content:"1.船舶进/出坞各一次，拖轮协助，提供引水服务，配合船舶带；解缆。2.船舶出坞供压载水。3.按施工要求，提供临时消防器材，并接妥消防水，保持水压（24小时不间断）。4.接拆电缆供岸电（24小时）。"},{itemid:"D-100",itemn:"坞修工程说明",content:"坞修工程应包括:（1）坞壁车、坞底升降平台和移动式吊臂车等的使用（2）安装排水孔护罩（3）拉接临时照明4）提供船体极板、测深仪及船速仪护罩。水下及干舷部分防护面漆的涂装工程包括以下项目： 水线标志、艏艉船名、船籍港、载重线标志、IMO标志; 艏/艉侧推标志、船体干舷两面CHINA SHIPPING字母;集装箱行（BAY）数码、船舶提供油漆。"},{itemid:"H-301",itemn:"起锚机",itemc:"起锚机   台,制造厂：电动马达  台，齿轮箱 个，考比林连接二端.最大拉力 速度：     吨      m/min.用船供/厂供材料换新刹车带.刹车鼓除锈，刹车系统连接结构加油、活络.滑动式离合器,检查工作状况,刹车系统修理."}]},{proid:"CG22220001",shipid:"s03",type:"2",state:"3",loc:"天津",date:200000900,day:"1",bday:200000800,fday:3000000700,com:"上海星星救生消防设备服务有限公司",plan:"没有计划哦",alert:"请注意",illu:"a|i|j|k",applyid:"XS11110003|XS11110004|XS11110009",avapplyid:"XS11110019|XS11110014|XS11110013",itinfo:[{itemid:"G-109",itemn:"船舶进/出邬",content:"1.船舶进/出坞各一次，拖轮协助，提供引水服务，配合船舶带；解缆。2.船舶出坞供压载水。3.按施工要求，提供临时消防器材，并接妥消防水，保持水压（24小时不间断）。4.接拆电缆供岸电（24小时）。"},{itemid:"D-100",itemn:"坞修工程说明",content:"坞修工程应包括:（1）坞壁车、坞底升降平台和移动式吊臂车等的使用（2）安装排水孔护罩（3）拉接临时照明4）提供船体极板、测深仪及船速仪护罩。水下及干舷部分防护面漆的涂装工程包括以下项目： 水线标志、艏艉船名、船籍港、载重线标志、IMO标志; 艏/艉侧推标志、船体干舷两面CHINA SHIPPING字母;集装箱行（BAY）数码、船舶提供油漆。"},{itemid:"H-301",itemn:"起锚机",itemc:"起锚机   台,制造厂：电动马达  台，齿轮箱 个，考比林连接二端.最大拉力 速度：     吨      m/min.用船供/厂供材料换新刹车带.刹车鼓除锈，刹车系统连接结构加油、活络.滑动式离合器,检查工作状况,刹车系统修理."}]},{proid:"CG22220001",shipid:"s02",type:"3",state:"2",loc:"上海",date:200000500,day:"5",bday:200000400,fday:3000000400,com:"上海申颜电机有限公司",plan:"没有计划哦",alert:"请注意",illu:"a|n|m|o",applyid:"XS11110002|XS11110003|XS11110004",avapplyid:"XS11110011|XS11110010|XS11110009",itinfo:[{itemid:"G-109",itemn:"船舶进/出邬",content:"1.船舶进/出坞各一次，拖轮协助，提供引水服务，配合船舶带；解缆。2.船舶出坞供压载水。3.按施工要求，提供临时消防器材，并接妥消防水，保持水压（24小时不间断）。4.接拆电缆供岸电（24小时）。"},{itemid:"D-100",itemn:"坞修工程说明",content:"坞修工程应包括:（1）坞壁车、坞底升降平台和移动式吊臂车等的使用（2）安装排水孔护罩（3）拉接临时照明4）提供船体极板、测深仪及船速仪护罩。水下及干舷部分防护面漆的涂装工程包括以下项目： 水线标志、艏艉船名、船籍港、载重线标志、IMO标志; 艏/艉侧推标志、船体干舷两面CHINA SHIPPING字母;集装箱行（BAY）数码、船舶提供油漆。"},{itemid:"H-301",itemn:"起锚机",itemc:"起锚机   台,制造厂：电动马达  台，齿轮箱 个，考比林连接二端.最大拉力 速度：     吨      m/min.用船供/厂供材料换新刹车带.刹车鼓除锈，刹车系统连接结构加油、活络.滑动式离合器,检查工作状况,刹车系统修理."}]}]}';
//			var requestStr:String=StringUtils.sprintf('{seq:"10",uid:"%s"}',uid);
//			RepairControl.Instance.onHandleProjectOrder(temp);
//			Network.Instance.SendPacket(0x6321,requestStr);
			var requestStr:String=StringUtils.sprintf('{seq:"10",uid:"%s",shipid:"",st:"",tp:""}',uid);
			Network.Instance.SendPacket(0x6321,requestStr);
			
		}
		
		public function reqDetailProjectOrder(proId:String):void
		{
			/*var requestStr:String=StringUtils.sprintf('{seq:"10",proid:"%s"}',proId);
			var temp:String='{seq:"10",proid:"CG22220001",shipid:"s01",shipna:"新厦门",tp:"1",st:"1",loc:"天津",comid:"01",comna:"天津船修集团公司",facid:"检验名称1",facna:"计划没有",psday:100,pfday:100000000,asday:200000000,afday:400000000,pdays:1.1,adays:2.1,alert:"没有什么",illu:"1|2|3|4",applyinfo:[{applyid:"01000034",itemid:"A-1023",itemn:"项目名称1",adate:100,bdate:100,fdate:100,st:0},{applyid:"01000035",itemid:"A-1023",itemn:"项目名称1",adate:100,bdate:100,fdate:100,st:1},{applyid:"01000036",itemid:"A-1023",itemn:"项目名称1",adate:100,bdate:100,fdate:100,st:2}]}';
			RepairControl.Instance.onHandleDetailProjectOrder(temp);*/
			var requestStr:String=StringUtils.sprintf('{seq:"10",proid:"%s"}',proId);
			trace(requestStr);
			Network.Instance.SendPacket(0x6322,requestStr);
		}
		/**
		 *新建或者修改工程单
		 */
//	{seq：“”，uid：“”，dis：“”，proid：“”，shipid：“”，type：“”，state：“”，loc：“”，psday：，pfday：，comid：“”，comna:””，alert：“”，illu：“1|2|3|4”，applyid：“a01|a02|a03” }dis为区别位：“0”为新增，“1”为修改，其他同上。新增时proid为空

		public function reqAddModProjectOrder(uid:String,dis:String,projectOrder:ProjectOrderObject):void
		{
			//var state:int = projectOrder.state as int;
			var type:int = projectOrder.type as int;
			trace(requestStr);
			var requestStr:String=StringUtils.sprintf('{seq:"%s",uid:"%s",dis:"%s",proid:"%s",shipid:"%s",type:%d,loc:"%s",psday:%d,pfday:%d,asday:%d,afday:%d,comid:"%s",comna:"%s",alert:"%s",illu:"%s",applyid:"%s"}',dis,uid,dis,projectOrder.proId,projectOrder.shipId,type,projectOrder.location,projectOrder.psday.time,projectOrder.pfday.time,projectOrder.asday.time,projectOrder.afday.time,projectOrder.companyId,projectOrder.company,projectOrder.alert,projectOrder.illuArray.join("|"),projectOrder.applyMap.getKeys().join("|"));
			Network.Instance.SendPacket(0x6323,requestStr);
			
		/*	var requestStr:String=StringUtils.sprintf('{seq:"11",uid:"%s",dis:"%s",proid:"%s",shipid:"%s",type:"%s",state:"%s",loc:"%s",psday:%d,pfday:%d,comid:"%s",comna:"%s",alert:"%s",illu:"%s",applyid:"%s"}',uid,dis,projectOrder.proId,projectOrder.shipId,projectOrder.type,
				projectOrder.state,projectOrder.location,projectOrder.psday.time,projectOrder.pfday.time,projectOrder.companyId,projectOrder.company,projectOrder.alert,projectOrder.illuArray.join("|"));
			var temp:String=StringUtils.sprintf('{seq:"11",eid:0,dis:"%s",proid:"%s"}',dis,projectOrder.proId);
			RepairControl.Instance.onHandleAddModProjectOrder(temp);*/
//			Network.Instance.SendPacket(0x6323,requestStr);//requestStr = "{seq:"11",uid:"admin",dis:"0",proid:"null",shipid:"null",type:"null",state:"null",loc:"null",psday:1397035000233,pfday:1397035000233,comid:"11",comna:"fasdfas",alert:"sdasdf",illu:"1",applyid:"undefined"}"
		//	trace(requestStr);
		}//requestStr = "{seq:"11",uid:"admin",dis:"0",proid:"R08",shipid:"0001004",type:1,state:1,loc:"",psday:0,pfday:0,comid:"",comna:"",alert:"",illu:"",applyid:""}"
		
		/**
		 *某船舶的未派工程单的且状态为未开始的修理单列表
		 */
		public function reqApplyObject(shipId:String,tp:int):void
		{

			var requestStr:String=StringUtils.sprintf('{seq:"22",shipid:"%s",tp:"%d"}',shipId,tp);
//			var temp:String="";
//			RepairControl.Instance.onHandleApplyList(temp);
			trace(requestStr);
			Network.Instance.SendPacket(0x6324,requestStr);
			trace(requestStr);
		}
		/**
		 *工程单状态改变
		 */
	/*	public function reqProjectChangeState(uid:String,proid:String,state:String,fn:String,fc:String,ft:Number,fr:String,fs:String):void
		{
			var requestStr:String=StringUtils.sprintf('{seq:"11",uid:"%s",proid:"%s",state:"%s",fn:"%s",fc:"%s",ft:%d,fr:"%s",fs:"%s"}',uid,proid,state,fn,fc,ft,fr,fs);
		if(fn!=""||fc!=""||ft!=0||fr!=""||fs!="")
		{
			var tempProcess:ProcessObject=new ProcessObject();
			tempProcess.uname=fn;
			tempProcess.action=fc;
			tempProcess.utime=ft;
			tempProcess.remark=fr;
			tempProcess.state=fs;
			RepairControl.Instance.addProjectChangeState(tempProcess);
		}
			var temp:String=StringUtils.sprintf('{eid:0,seq:"11",state:"%s"}',state);
			RepairControl.Instance.onHandleProjectChangeState(temp);
		}*/
		/**
		 *完成工程单
		 */
		public function reqFufillProjectOrder(applyid:String,startdt:Date,enddt:Date):void
		{
			var startdtstr:String = TimeUtil.getTimeStr(startdt,"YYYY-MM-DD");
			var enddtstr:String = TimeUtil.getTimeStr(enddt,"YYYY-MM-DD");
			var requestStr:String=StringUtils.sprintf('{seq:"%s",applyid:"%s",startdt:"%s",enddt:"%s"}',applyid,applyid,startdtstr,enddtstr);
//			var temp:String="";
//			RepairControl.Instance.onHandleApplyList(temp);
			Network.Instance.SendPacket(0x6325,requestStr);
			trace("abcdefghijklmn");
			trace(requestStr);
		}
		
		/**
		 *删除工程单
		 */
		public function reqDelProjectOrder(uid:String,proid:String):void
		{
			var requestStr:String=StringUtils.sprintf('{seq:"11",uid:"%s",proid:"%s"}',uid,proid);
			var temp:String='{seq:"11",eid:0}';
			Network.Instance.SendPacket(0x6326,requestStr);
			trace(requestStr);
		}
		
		
		
		/**
		 *厂修管理请求 
		 * @author lisicong
		 */	
		/**
		 *请求厂修管理数据
		 */
//	 {seq：“”，info：[{facid：“”，shipid：“”，state：“”，pin：，pout：，rin：，rout：，cont：“”，com：“”，ptime：“”，rtime：“”，port：“”，pro：[{proid：“”，shipid：“”，state：“”，fday：}，{}]，allproid：“p01|p02|p03“}，{}，{}]}
		public function reqFactoryRepair(uid:String):void
		{
			var requestStr:String=StringUtils.sprintf('{seq:"11",uid:"%s",shipid:"",year:"",state:""}',uid);
/*			var temp:String='{seq:"11",info:[{facid:"01",shipna:"新厦门",ccs:"船级社",certdt:40000000,shipid:"s01",state:"2",pin:30000000,pout:300000001,rin:300000002,rout:300000003,cont:[{id:"1",na:"年检"}],comna:"华海设备工程有限公司",ptime:"2",rtime:"3",port:"天津",pro:[{proid:"CG22220001",shipna:"新厦门",shipid:"s01",state:"1",sday:30000000,fday:30000000},{proid:"CG22220031",shipna:"新厦门",shipid:"s01",state:"1",sday:30000000,fday:30000700},{proid:"CG22220011",shipna:"新厦门",shipid:"s01",state:"1",sday:30000000,fday:30000040},{proid:"CG22220005",shipna:"新厦门",shipid:"s01",state:"0",sday:30000000,fday:30003000}],allproid:"CG22220003|CG22220004|CG22220005|CG22220008"},' +
				'{facid:"02",shipna:"新长沙",ccs:"船级社",certdt:40000000,shipid:"s02",state:"1",pin:30030000,pout:300050001,rin:300200002,rout:308000003,cont:[{id:"1",na:"年检"}],comna:"上海申颜电机有限公司",ptime:"4",rtime:"3",port:"青岛",pro:[{proid:"CG22220003",shipna:"新长沙",shipid:"s02",state:"1",sday:30000000,fday:30400000},{proid:"CG22220231",shipna:"新长沙",shipid:"s02",state:"0",sday:30000000,fday:30010700},{proid:"CG22220091",shipna:"新长沙",shipid:"s02",state:"1",sday:30000000,fday:30100040},{proid:"CG22120005",shipna:"新长沙",shipid:"s02",state:"0",sday:30000000,fday:30003000}],allproid:"CG42220003|CG42220004|CG42220005|CG42220008"},' +
				'{facid:"03",shipna:"新海口",ccs:"船级社",certdt:40000000,shipid:"s03",state:"1",pin:35000000,pout:380000001,rin:340000002,rout:390000003,cont:[{id:"1",na:"年检"}],comna:"中海电信有限公司",ptime:"1",rtime:"5",port:"厦门",pro:[{proid:"CG22220001",shipna:"新海口",shipid:"s03",state:"1",sday:30000000,fday:30009000},{proid:"CG12220031",shipna:"新海口",shipid:"s03",state:"1",sday:30000000,fday:30700700},{proid:"CG22120011",shipna:"新海口",shipid:"s03",state:"0",sday:30000000,fday:39000040},{proid:"CG22221005",shipna:"新海口",shipid:"s03",state:"0",sday:30000000,fday:39003000}],allproid:"CG32220003|CG32220004|CG32220005|CG32220008"},' +
				'{facid:"04",shipna:"新厦门",ccs:"船级社",certdt:40000000,shipid:"s04",state:"0",pin:40000000,pout:400000001,rin:400000002,rout:400000003,cont:[{id:"1",na:"年检"}],comna:"华海设备工程有限公司",ptime:"1",rtime:"3",port:"台湾",pro:[{proid:"CG12220001",shipna:"新厦门",shipid:"s04",state:"1",sday:30000000,fday:40000000},{proid:"CG22220031",shipna:"新厦门",shipid:"s01",state:"1",sday:30000000,fday:30000700},{proid:"CG12220011",shipna:"新厦门",shipid:"s04",state:"1",sday:30000000,fday:40000040},{proid:"CG12220005",shipna:"新厦门",shipid:"s04",state:"1",sday:30000000,fday:40003000}],allproid:"CG12220003|CG12220004|CG12220005|CG12220008"}]}';
			RepairControl.Instance.onHandleFactoryRepair(temp);*/
			Network.Instance.SendPacket(0x6331,requestStr);
			trace(requestStr);
			
		}
		/**
		 *请求某船舶下所有未开始的未被分配的的工程单
		 */	
		public function reqUnassignProjectOrder(shipid:String):void
		{
			var requestStr:String=StringUtils.sprintf('{seq:"10",shipid:"%s"}',shipid);
		/*	var temp:String="";
			if(shipid=="s01")
				temp='{seq:"11",info:[{proid:"CG32220001",shipid:"s01",sday:30000000,fday:30000000},{proid:"CG32220031",shipid:"s01",sday:30000000,fday:30000700},{proid:"CG32220011",shipid:"s01",sday:30000000,fday:30000040},{proid:"CG32220005",shipid:"s01",sday:30000000,fday:30003000}]}'
			if(shipid=="s02")
				temp='{seq:"11",info:[{proid:"CG32220003",shipid:"s02",sday:30000000,fday:30400000},{proid:"CG32220231",shipid:"s02",sday:30000000,fday:30010700},{proid:"CG32220091",shipid:"s02",sday:30000000,fday:30100040},{proid:"CG32120005",shipid:"s02",sday:30000000,fday:30003000}]}'
			if(shipid=="s03")
				temp='{seq:"11",info:[{proid:"CG32220001",shipid:"s03",sday:30000000,fday:30009000},{proid:"CG42220031",shipid:"s03",sday:30000000,fday:30700700},{proid:"CG32120011",shipid:"s03",sday:30000000,fday:39000040},{proid:"CG32221005",shipid:"s03",sday:30000000,fday:39003000}]}'
			if(shipid=="s04")
				temp='{seq:"11",info:[{proid:"CG12220001",shipna:"新厦门",shipid:"s04",state:"1",sday:30000000,fday:40000000},{proid:"CG22220031",shipna:"新厦门",shipid:"s01",state:"1",sday:30000000,fday:30000700},{proid:"CG12220011",shipna:"新厦门",shipid:"s04",state:"1",sday:30000000,fday:40000040},{proid:"CG12220005",shipna:"新厦门",shipid:"s04",state:"1",sday:30000000,fday:40003000}]}'
			RepairControl.Instance.onHandleUnassignProjectOrder(temp);*/
			Network.Instance.SendPacket(0x6332,requestStr);
			trace(requestStr);

		}

		/**

		 *请求某船舶下所有未开始的未被分配的的工程单
		 */
/*		public function reqCheckOutList(shipid:String):void
		{
			var requestStr:String=StringUtils.sprintf('{seq:"10",shipid:"%s"}',shipid);
			var temp:String="";
			RepairControl.Instance.onHandleUnassignProjectOrder(temp);
		}
		*/
		/**
		 *厂修管理请求某船舶下检验列表
		 *
		 */

		public function reqCheckOutList1(shipid:String):void
		{
			var requestStr:String=StringUtils.sprintf('{seq:"10",shipid:"%s"}',shipid);
	/*		var temp:String="";
			RepairControl.Instance.onHandleCheckOutList(temp);*/
			Network.Instance.SendPacket(0x6333,requestStr);
			trace(requestStr);
			//{seq：“”，info：[{suvid：“”，suvna:””}，{}]}
		

		}

		/**
		 *新建或者修改厂修卡
		 */
//		{seq：“”，uid：“”，type：“”，facid：“”，shipid：“”，state：“”，pin：，pout：，rin：，rout：，cont：[{id:“”,na:””},{}…]，comid：“”，comna:””, ptime：“”，rtime：“”，port：“”，ccs:””,certdt:}
		public function reqAddModFactoryRepair(uid:String,type:Number,factoryRepair:FactoryRepairObject):void
		{
		var tempContent:String="";
			if(!factoryRepair.contOrder.isEmpty())
			{
				var tempArray:Array=factoryRepair.contOrder.getValues();
				var array:Array = new Array();
				for(var i:int=0;i<tempArray.length;i++)
				{
					array.push(tempArray[i].id);
					
				}
				tempContent=array.join("|");
			}
			var requestStr:String=StringUtils.sprintf('{seq:"11",type:%d,facid:"%s",shipid:"%s",state:%s,pin:%d,pout:%d,rin:%d,rout:%d,cont:"%s",comid:"%s",comna:"%s",ptime:%s,rtime:%s,port:"%s",ccs:"%s",certdt:%d}',type,factoryRepair.factoryId,factoryRepair.shipId,factoryRepair.state,factoryRepair.planIn.time/1000,factoryRepair.planOut.time/1000,factoryRepair.realIn.time/1000,factoryRepair.realOut.time/1000,tempContent,factoryRepair.companyId,factoryRepair.company,factoryRepair.planTime,factoryRepair.realTime,factoryRepair.port,factoryRepair.ccs,factoryRepair.certdt.time/1000);
	/*		var temp:String=StringUtils.sprintf('{seq:"11",eid:0,type:"%s",facid:"09"}',type);
			RepairControl.Instance.onHandleAddModFactoryRepair(temp);*/
			//requestStr =StringUtils.sprintf('{seq:"11",uid:"admin",type:0,facid:"",shipid:"",state:"0",pin:1396281600000,pout:1398787200000,rin:1396281600000,rout:1398787200000,cont:"",comid:"null",comna:"s",ptime:29.00,rtime:29.00,port:"sa",ccs:"",certdt:1398787200000}');
			Network.Instance.SendPacket(0x6334,requestStr);
			trace(requestStr);
		//	var requestStr:String=StringUtils.sprintf('{seq:"11",uid:"%s",type:"%s",facid:"%s",shipid:"%s",state:"%s",pin:%d,pout:%d,rin:%d,rout:%d,cont:[%s],comid:"%s",comna:"%s",ptime:"%s",rtime:"%s",port:"%s",ccs:"%s",certdt:%d}',uid,type,factoryRepair.factoryId,factoryRepair.shipId,factoryRepair.state,factoryRepair.planIn.time,factoryRepair.planOut.time,factoryRepair.realIn.time,factoryRepair.realOut.time,tempContent,factoryRepair.companyId,factoryRepair.company,factoryRepair.planTime,factoryRepair.realTime,factoryRepair.port,factoryRepair.ccs,factoryRepair.certdt.time);

		}
		/**
		 *删除厂修卡
		 */
		public function reqDelFactoryRepair(uid:String,facid:String):void
		{
			var requestStr:String=StringUtils.sprintf('{seq:"11",uid:"%s",facid:"%s"}',uid,facid);
/*			var temp:String='{seq:"11",eid:0}';
			RepairControl.Instance.onHandleDelFactoryRepair(temp);*/
			Network.Instance.SendPacket(0x6335,requestStr);
			trace(requestStr);

		}
		/**
		 *新增或者删除厂修卡中的工程单
		 */
		public function reqAddFactoryRepairProject(type:Number,facid:String,proid:Array):void
		{//{seq：““，uid：”“，facid：”“，proid：”p01|p02“}
			var requestStr:String=StringUtils.sprintf('{seq:"%s",type:%d,facid:"%s",proid:"%s"}',proid.join("|"),type,facid,proid.join("|"));
//			var temp:String=StringUtils.sprintf('{seq:"%s",eid:0}',proid.join("|"));
			
//				{seq：““，eid：info：[{proid：“”，shipid：“”，state：“”，fday：}，{}]}
			Network.Instance.SendPacket(0x6336,requestStr);
			trace(requestStr);

		}
		/**
		 *删除厂修卡中的工程单
		 */
	/*	public function reqDelFactoryRepairProject(uid:String,facid:String,proid:Array):void
		{//{seq：““，uid：”“，facid：”“，proid：”p01“}
 			var requestStr:String=StringUtils.sprintf('{seq:"%s",uid:"%s",facid:"%s",proid:"%s"}',proid.join("|"),uid,facid,proid.join("|"));
			var temp:String=StringUtils.sprintf('{seq:"%s",eid:0}',proid.join("|"));
			RepairFactoryControl.Instance.onHandleDelFactoryRepairProject(temp);
		}*/
		
		public function jsonDecode(array:Array):String
		{
			var str:String;
			str=StringUtils.sprintf('[');
			for(var i:int;i<array.length;i++)
			{
			var str1:String =array[i].proId;
			var str2:String =array[i].shipName;
			var str3:String =array[i].sday.time;
			var str4:String =array[i].fday.time;
			str=str+StringUtils.sprintf('{proid:"%s",shipna:"%s",sday:%s,fday:%s},',str1,str2,str3,str4);
			}
			if(array.length>0)
			{
			str=str.substr(0,str.length-1);
			str=str+"]";
			}
			else
				str=str+"]";
				return str;
		}

	}
}