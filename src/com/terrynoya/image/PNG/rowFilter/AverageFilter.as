package com.terrynoya.image.PNG.rowFilter
{
	import flash.utils.ByteArray;

	public class AverageFilter
	{
		public function AverageFilter()
		{
			
		}
		
		public static function decode(rowBytes:ByteArray,bpp:int,currentLine:ByteArray,preLine:ByteArray):void
		{
			var rawByte:uint;
			var preByte:uint;
			for (var i:int = 0; i < rowBytes.length; i++) 
			{
				var averageByte:int = rowBytes.readUnsignedByte();
				preByte = preLine[i];
				rawByte = i-bpp < 0 ? 0 : currentLine[i-bpp]; 
				rawByte = (averageByte + Math.floor((rawByte + preByte)/2)) & 0xff;
				currentLine.writeByte(rawByte);
			}
		}
	}
}