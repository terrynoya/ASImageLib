package com.terrynoya.image.PNG.rowFilter
{
	import flash.utils.ByteArray;

	public class PaethFilter
	{
		public function PaethFilter()
		{
			
		}
		
		public static function decode(rowBytes:ByteArray,bpp:int,currentLine:ByteArray,preLine:ByteArray):void
		{
			for (var i:int = 0; i < rowBytes.length; i++) 
			{
				var paeth:int = rowBytes.readUnsignedByte();
				var left:int = i - bpp < 0 ? 0 : currentLine[i - bpp];
				var above:int = preLine == null ? 0 : preLine[i];
				var upperLeft:int = 0;
				if(preLine != null && (i - bpp) >= 0)
				{
					upperLeft = preLine[i - bpp];	
				}
				var rltByte:int = (paeth + paethPredictor(left,above,upperLeft)) % 256;
				currentLine.writeByte(rltByte);
			}
		}
		
		public static function paethPredictor(a:int,b:int,c:int):int
		{
			var p:int = a+b-c;
			var pa:int = Math.abs(p-a);
			var pb:int = Math.abs(p-b);
			var pc:int = Math.abs(p-c);
			if(pa <= pb && pa <= pc)
			{
				return a;
			}
			else if(pb <= pc)
			{
				return b;
			}
			else
			{
				return c;
			}
		}
	}
}