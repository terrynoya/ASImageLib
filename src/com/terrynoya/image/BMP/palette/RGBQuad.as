package com.terrynoya.image.BMP.palette
{
	import com.terrynoya.common.color.ColorUtil;
	
	import flash.utils.ByteArray;

	public class RGBQuad
	{
		public static const size:int = 4;
		
		private var _blue:uint;
		private var _green:uint;
		private var _red:uint;
		private var _reserved:uint;
		
		public function RGBQuad()
		{
			
		}
		
		public function decode(bytes:ByteArray):void
		{
			this._red = bytes.readUnsignedByte();
			this._green = bytes.readUnsignedByte();
			this._blue = bytes.readUnsignedByte();
			this._reserved = bytes.readUnsignedByte();
		}
		
		public function get color():uint 
		{
			return ColorUtil.getColor(this._red,this._green,this._blue);
		}
	}
}