package com.terrynoya.image.BMP.palette
{
	import flash.utils.ByteArray;

	/**
	 * color palette stucture on OS/2 not implement yet 
	 * @author terrynoya
	 * 
	 */	
	public class RGBTriple
	{
		public static const size:int = 3;
		
		private var _blue:uint;
		private var _green:uint;
		private var _red:uint;
		
		public function RGBTriple()
		{
			
		}
		
		public function decode(bytes:ByteArray):void
		{
			this._blue = bytes.readByte();
			this._green = bytes.readByte();
			this._red = bytes.readByte();
		}
	}
}