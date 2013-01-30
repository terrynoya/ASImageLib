package com.terrynoya.image.PNG.chunk
{
	import com.terrynoya.common.color.ColorUtil;
	import com.terrynoya.image.PNG.Chunk;
	
	import flash.utils.ByteArray;

	public class PLTE
	{
		private var _colors:Vector.<uint>;
		
		public function PLTE()
		{
			super();
			this._colors = new Vector.<uint>();
		}
		
		public function decode(bytes:ByteArray):void
		{
			var colorLen:int = bytes.length / 3;
			for (var i:int = 0; i < colorLen; i++) 
			{
				var red:uint = bytes.readUnsignedByte();
				var green:uint = bytes.readUnsignedByte();
				var blue:uint = bytes.readUnsignedByte();
				var alpha:uint = i == 0 ? 0 : 255;
				this._colors.push(ColorUtil.getColor(red,green,blue,alpha));
			}
		}
		
		public function getColorAt(index:int):uint
		{
			return this._colors[index];
		}
	}
}
