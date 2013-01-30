package com.terrynoya.image.BMP
{
	import flash.utils.ByteArray;

	public class BMPFileHeader
	{
		public static const SIGNATURE:String = "BM";
		
		//sig must be "BM" for all BMP file
		private var _sig:String;
		private var _size:int;
		private var _dataOffset:int;
		//reserv1 and reserv2 must be 0
		private var _bfReserved1:int;
		private var _bfReserved2:int;
		
		public function BMPFileHeader()
		{
			
		}
		
		public function get dataOffset():int
		{
			return _dataOffset;
		}

		public function get fileSize():int
		{
			return _size;
		}

		public function decode(bytes:ByteArray):void
		{
			this._sig = bytes.readMultiByte(2,"us-ascii");
			this._size = bytes.readInt();
			this._bfReserved1 = bytes.readShort();
			this._bfReserved2 = bytes.readShort();
			this._dataOffset = bytes.readInt();
		}
		
		/**
		 * valid if file is bmp 
		 * @return 
		 * 
		 */		
		public function get isValid():Boolean 
		{
			return this._bfReserved1 == 0 && this._bfReserved2 == 0 && this._sig == SIGNATURE;
		}
	}
}