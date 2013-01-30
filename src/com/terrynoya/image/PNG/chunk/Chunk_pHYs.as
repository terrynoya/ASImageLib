package com.terrynoya.image.PNG.chunk
{
	import flash.utils.ByteArray;
	
	public class Chunk_pHYs
	{
		private var _xPixelsPerUnit:int;
		private var _yPixelsPerUnit:int;
		/**
		 * 0	x y is ratio
		 * 1	unit is meters 
		 */		
		private var _unitSpecify:int;
		
		public function Chunk_pHYs()
		{
		}
		
		public function decode(bytes:ByteArray):void
		{
			this._xPixelsPerUnit = bytes.readInt();
			this._yPixelsPerUnit = bytes.readInt();
			this._unitSpecify = bytes.readByte();
		}
	}
}