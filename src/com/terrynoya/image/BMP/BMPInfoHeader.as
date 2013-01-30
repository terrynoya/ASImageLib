package com.terrynoya.image.BMP
{
	import flash.utils.ByteArray;

	/**
	 *  
	 * @author terrynoya
	 * 
	 */	
	public class BMPInfoHeader
	{
		private var _size:int;
		private var _width:int;
		private var _height:int;
		private var _planes:int;
		private var _bitCount:int;
		private var _compression:int;
		private var _sizeImage:int;
		private var _xPelsPerMeter:int;
		private var _yPelsPerMeter:int;
		private var _clrUsed:int;
		private var _clrImportant:int;
		
		public function BMPInfoHeader()
		{
			
		}
		
		public function get clrImportant():int
		{
			return _clrImportant;
		}

		public function get clrUsed():int
		{
			return _clrUsed;
		}

		public function get yPelsPerMeter():int
		{
			return _yPelsPerMeter;
		}

		public function get xPelsPerMeter():int
		{
			return _xPelsPerMeter;
		}

		public function get sizeImage():int
		{
			return _sizeImage;
		}

		/**
		 * RGB mode is most case,other not implement 
		 * @return 
		 * 
		 */		
		public function get compression():int
		{
			return _compression;
		}

		public function get bitCount():int
		{
			return _bitCount;
		}

		public function get planes():int
		{
			return _planes;
		}

		public function get height():int
		{
			return _height;
		}

		public function get width():int
		{
			return _width;
		}

		public function get size():int
		{
			return _size;
		}

		/**
		 * bitCount 1/4/8 need palette
		 * @return 
		 * 
		 */		
		public function get isPaletteNeeded():Boolean 
		{
			return this._bitCount == 1 || this._bitCount == 4 || this._bitCount == 8;
		}
		
		public function decode(bytes:ByteArray):void
		{
			this._size = bytes.readInt();
			this._width = bytes.readInt();
			this._height = bytes.readInt();
			this._planes = bytes.readShort();
			this._bitCount = bytes.readShort();
			this._compression = bytes.readInt();
			this._sizeImage = bytes.readInt();
			this._xPelsPerMeter = bytes.readInt();
			this._yPelsPerMeter = bytes.readInt();
			this._clrUsed = bytes.readInt();
			this._clrImportant = bytes.readInt();
		}
	}
}