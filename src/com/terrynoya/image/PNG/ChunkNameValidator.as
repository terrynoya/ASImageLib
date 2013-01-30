package com.terrynoya.image.PNG
{
	public class ChunkNameValidator
	{
		public function ChunkNameValidator()
		{
			
		}
		
		public static function isCriticalChunk(value:String):Boolean
		{
			var str:String = value.charAt(0);
			return str.toUpperCase() == str;
		}
	}
}