package com.terrynoya.image.PNG.rowFilter
{
	import flash.utils.ByteArray;

	public class NoFilter
	{
		public function NoFilter()
		{
			
		}
		
		public static function decode(rowBytes:ByteArray,bpp:int,currentRow:ByteArray,prevRow:ByteArray):void
		{
			for (var j:int = 0; j < rowBytes.length; j++) 
			{
				currentRow.writeByte(rowBytes.readByte());
			}
		}
	}
}