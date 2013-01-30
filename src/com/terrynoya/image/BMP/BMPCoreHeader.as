package com.terrynoya.image.BMP
{
	import flash.utils.ByteArray;

	/**
	 * OS/2 header info, not implement yet
	 * @author terrynoya
	 */
	public class BMPCoreHeader
	{
		private var _size:int;
		private var _width:int;
		private var _height:int;
		private var _planes:int;
		private var _bitCount:int;
		
		/**
		 * 
		 */
		public function BMPCoreHeader()
		{
			
		}
		
		/**
		 * 
		 * @param bytes
		 */
		public function decode(bytes:ByteArray):void
		{
			this._size = bytes.readInt();
			this._width = bytes.readShort();
			this._height = bytes.readShort();
			this._planes = bytes.readShort();
			this._bitCount = bytes.readShort();
		}
	}
}