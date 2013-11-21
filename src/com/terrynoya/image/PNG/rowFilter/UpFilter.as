package com.terrynoya.image.PNG.rowFilter
{
	import flash.utils.ByteArray;
	
	public class UpFilter
	{
		public function UpFilter()
		{
			
		}
		
		public static function decode(rowBytes:ByteArray,bpp:int,currentRow:ByteArray,prevRow:ByteArray):void
		{
			for (var i:int = 0; i < rowBytes.length; i++) 
			{
				var up:int = rowBytes.readUnsignedByte();
				var prevByte:int = 0;
				if(prevRow != null)
				{
					prevByte = prevRow[i];
				}
				var rltByte:int = (up + prevByte) & 0xff;
				currentRow.writeByte(rltByte);
			}
		}
	}
}