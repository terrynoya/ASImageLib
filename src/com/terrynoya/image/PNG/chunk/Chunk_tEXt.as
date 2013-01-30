package com.terrynoya.image.PNG.chunk
{
	import com.terrynoya.charset.Charset;
	
	import flash.utils.ByteArray;

	public class Chunk_tEXt
	{
		private var _keyWord:String;
		
		public function Chunk_tEXt()
		{
			
		}
		
		public function decode(bytes:ByteArray):void
		{
			var str:String = bytes.readMultiByte(bytes.bytesAvailable,Charset.ASCII);	
		}
	}
}