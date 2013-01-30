package com.terrynoya.image.BMP.palette
{
	import flash.utils.ByteArray;

	public class BMPColorPalette
	{
		private var _colors:Vector.<RGBQuad>;
		private var _quadLength:int;
		
		public function BMPColorPalette(bitCount:int)
		{
			this._colors = new Vector.<RGBQuad>();
			this._quadLength = Math.pow(2,bitCount);
		}
		
		public function get size():int 
		{
			return this._quadLength * RGBQuad.size;
		}
		
		public function getPaletteAt(index:int):RGBQuad
		{
			return this._colors[index];
		}
		
		public function decode(bytes:ByteArray):void
		{
			for (var i:int = 0; i < this._quadLength; i++) 
			{
				var quadData:RGBQuad = new RGBQuad();
				quadData.decode(bytes);
				this._colors.push(quadData);
			}
		}
	}
}