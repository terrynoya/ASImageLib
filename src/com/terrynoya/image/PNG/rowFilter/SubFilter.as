package com.terrynoya.image.PNG.rowFilter
{
	import com.terrynoya.io.ByteUtil;
	
	import flash.utils.ByteArray;

	public class SubFilter
	{
		public function SubFilter()
		{
		}
		
		public static function decode(rowBytes:ByteArray,bpp:int,currentRow:ByteArray,prevRow:ByteArray):void
		{
			for (var i:int = 0; i < rowBytes.length; i++) 
			{
				var sub:int = rowBytes.readUnsignedByte();
				var bvalue:int = 0;
				if(i - bpp >= 0)
				{
					bvalue = currentRow[i-bpp];
				}
				var rltByte:int = (sub + bvalue) & 0xFF;
				currentRow.writeByte(rltByte);
			}
		}
	}
}