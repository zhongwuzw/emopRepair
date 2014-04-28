package com.boloomo.emop.repair.utils
{
	import com.boloomo.emop.repair.type.CategoryObject;
	import com.boloomo.emop.repair.type.ItemObject;
	
	import mx.collections.XMLListCollection;

	public class RepairItemTreeUtils
	{
		public function RepairItemTreeUtils()
		{
		}
		/**
		 * 添加XMLListCollection虚拟根节点 
		 * @param xml
		 */
		public static function addVirtualRootNode(xml:XMLListCollection):void{
			var myData4:XML=new XML('<root><node type="" id="01" name="新新"></node></root>');
			var tempRoot:XMLListCollection=new XMLListCollection();			
		}		
		/**
		 * 添加XMLListCollection虚拟节点 
		 * @param xml
		 */
		public static function addVirtualNode(xml:XML):void{
			var vNode:String='<node id="vir" nc="正在请求数据,请稍等..."></node>';
			xml.appendChild(new XML(vNode));
		}	
		
		/**按照分类code排序*/
		public static function sortByItemCode(o1:ItemObject,o2:ItemObject):int{
			trace(Number(o2.itemId.substring(2,5)));
			trace(Number(o1.itemId.substring(2,5)));
			return Number(o2.itemId.substring(2,5))-Number(o1.itemId.substring(2,5));			
		}
		
		/**
		 * 将类别对象CategoryObject转换成XML
		 * @param cateObj
		 * @return XML
		 */
		public static function CategoryObjectToXML(cateObj:CategoryObject):XML{
			var node:String='<node label="'+cateObj.cateName+'" ' +
				'level="'+1+'" cateID="'+cateObj.cateId+'" ' +
				'nchild="'+cateObj.nChild+'" '+
				'itemMap="'+cateObj.itemMap+'"></node>';
			return new XML(node);
		}
		
		/**
		 * 将修理项类 ItemObject转换成XML
		 * @param cateObj
		 * @return XML
		 */
		public static function ItemObjectToXML(cateObj:ItemObject):XML{
			var node:String='<node label="'+cateObj.itemId+' '+cateObj.itemName+'" ' +
				'level="'+2+'" '+
				'code="'+cateObj.itemId+'" '+
				'name="'+cateObj.itemName+'" '+
				'shipMap="'+cateObj.shipMap+'" '+
				'equipMap="'+cateObj.equipMap+'" '+
				"text='"+cateObj.content+"'></node>";
			trace(node);
			return new XML(node);
		}
	}
}