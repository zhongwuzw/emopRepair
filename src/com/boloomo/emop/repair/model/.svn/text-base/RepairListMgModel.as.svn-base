package com.boloomo.emop.repair.model
{
	import com.boloomo.common.Network;
	import com.boloomo.emop.repair.control.RepairListManagerControl;
	import com.boloomo.util.StringUtils;
	
	public class RepairListMgModel
	{
		
		
		private static var g_Instance:RepairListMgModel = null;
		
		public function RepairListMgModel()
		{
			if(g_Instance){
				throw new Error("error....");
			}
		}
		
		public static function get Instance():RepairListMgModel
		{
			if(g_Instance == null)
				g_Instance = new RepairListMgModel();
			return g_Instance;
		}
		//请求修理单列表数据
		public function reqApplyList(seq:String,uid:String,shipid:String,tp:String,deparid:String,proc:String,link:String,st:String):void
		{
			var requestStr:String = StringUtils.sprintf("{seq:\"%s\",uid:\"%s\",shipid:\"%s\",tp:\"%s\",deparid:\"%s\",proc:\"%s\",link:\"%s\",st:\"%s\"}",seq,uid,shipid,tp,deparid,proc,link,st);
			Network.Instance.SendPacket(0x6311,requestStr);	
		}
		
		//请求修理单详细数据
		public function reqDetailsList(seq:String,applyid:String):void
		{
//			var temp:String='{seq:"seq12",item:{itemid:"G-101",itemna:"船舶进/出坞",content:"船舶进/出坞（）次，供岸电：440/380V，60/50Hz，250/300/350A 修理期间供应淡水 M3，供应海水（压载水）船舶出坞供压载水M3 供应冰机冷却水（海水）接/解水管，供应空调冷却水（海水）接/解水管费，消防水龙  接/解水管",info:[{cwbt:"as-100-1-1",na:"测试",wcs:[{id:"001",level:"1",owner:"答复"},{id:"002",level:"2",owner:"的典范"}]}]}}';
//			RepairListManagerControl.Instance.onApplyDetailPacket(temp); 
			var requestStr:String = StringUtils.sprintf("{seq:\"%s\",applyid:\"%s\"}",seq,applyid);
			
			Network.Instance.SendPacket(0x6312,requestStr);	
		}
		//添加修理单数据
		public function addDetailsList(seq:String,distype:int,applyid:String,shipid:String,deparid:String,type:String,self:int,comid:String,comna:String,adate:String,bdate:String,fdate:String,loc:String,rbdate:String,rfdate:String,itemid:String):void
		{
			var requestStr:String = StringUtils.sprintf("{seq:\"%s\",distype:\%d\,applyid:\"%s\",shipid:\"%s\",deparid:\"%s\",type:\"%s\",self:\%d\,comid:\"%s\",comna:\"%s\",adate:\"%s\",bdate:\"%s\",fdate:\"%s\",loc:\"%s\",rbdate:\"%s\",rfdate:\"%s\",itemid:\"%s\"}",seq,distype,applyid,shipid,deparid,type,self,comid,comna,adate,bdate,fdate,loc,rbdate,rfdate,itemid);
			Network.Instance.SendPacket(0x6313,requestStr);	
		}
		
		//保存修改后的修理单数据
		public function saveDetailsList(seq:String,distype:int,applyid:String,shipid:String,deparid:String,type:String,self:int,comid:String,comna:String,adate:String,bdate:String,fdate:String,loc:String,rbdate:String,rfdate:String,itemid:String):void
		{
			var requestStr:String = StringUtils.sprintf("{seq:\"%s\",distype:\%d\,applyid:\"%s\",shipid:\"%s\",deparid:\"%s\",type:\"%s\",self:\%d\,comid:\"%s\",comna:\"%s\",adate:\"%s\",bdate:\"%s\",fdate:\"%s\",loc:\"%s\",rbdate:\"%s\",rfdate:\"%s\",itemid:\"%s\"}",seq,distype,applyid,shipid,deparid,type,self,comid,comna,adate,bdate,fdate,loc,rbdate,rfdate,itemid);
			Network.Instance.SendPacket(0x6313,requestStr);	
		}
		//请求工程代码和工程名称
		public function reqProjectInfo(seq:String,shipid:String):void
		{
			var requestStr:String = StringUtils.sprintf("{seq:\"%s\",shipid:\"%s\"}",seq,shipid);
			Network.Instance.SendPacket(0x6314,requestStr);	
		}
		//
		public function DelDetailsList(seq:String,applyid:String):void
		{
			var requestStr:String = StringUtils.sprintf("{seq:\"%s\",applyid:\"%s\"}",seq,applyid);
			Network.Instance.SendPacket(0x6316,requestStr);	
		}
		//申请状态变化
		public function changeState(seq:String,uid:String,applyid:String,proc:String,link:String,st:int,remark:String):void
		{
			var requestStr:String = StringUtils.sprintf("{seq:\"%s\",uid:\"%s\",applyid:\"%s\",proc:\"%s\",link:\"%s\",st:\%d\,,remark:\"%s\"}",seq,uid,applyid,proc,link,st,remark);
			Network.Instance.SendPacket(0x6315,requestStr);	
		}
		public function repProjectList(seq:String,itemid:String):void
		{
			var requestStr:String = StringUtils.sprintf("{seq:\"%s\",itemid:\"%s\"}",seq,itemid);
			Network.Instance.SendPacket(0x6303,requestStr);	
		}
//		
//		public function addNewRepairList(seq:String,itemid:String):void
//		{
//			var requestStr:String = StringUtils.sprintf("{seq:\"%s\",itemid:\"%s\"}",seq,itemid);
//			Network.Instance.SendPacket(0x6303,requestStr);	
//		}
//		
//		public function onFinishListInfoFun(seq:String,applyid:String,startdt:String,enddt:String):void
//		{
//			var requestStr:String = StringUtils.sprintf("{seq:\"%s\",applyid:\"%s\",startdt:\"%s\",enddt:\"%s\",}",seq,applyid,startdt,enddt);
//			Network.Instance.SendPacket(0x6325,requestStr);	
//		}
//		
//		public function onReqCwbtInfo(seq:String,ishipid:String,cwbt:String):void
//		{
//			var requestStr:String = StringUtils.sprintf("{seq:\"%s\",ishipid:\"%s\",cwbt:\"%s\"}",seq,ishipid,cwbt);
//			Network.Instance.SendPacket(0x6305,requestStr);	
//		}
		
		public function onAddCwbtInfo(seq:String,itemid:String,shipid:String,type:int,cwbts:String):void
		{
			var requestStr:String = StringUtils.sprintf("{seq:\"%s\",itemid:\"%s\",shipid:\"%s\",type:\%d\,cwbts:\"%s\"}",seq,itemid,shipid,type,cwbts);
			Network.Instance.SendPacket(0x6307,requestStr);	
		}

	}
}