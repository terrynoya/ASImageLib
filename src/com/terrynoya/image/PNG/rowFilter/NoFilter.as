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
			currentRow.writeBytes(rowBytes);
		}
	}
}