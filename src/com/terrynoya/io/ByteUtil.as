package com.terrynoya.io
{
	import flash.utils.ByteArray;

	public class ByteUtil
	{
		public function ByteUtil()
		{
			
		}
		
		public static function printBytes(bytes:ByteArray):String
		{
			var rlt:String = "";
			var len:int = bytes.length;
			for (var i:int = 0; i < len; i++) 
			{
				var byte:int = bytes[i];
				var byteStr:String = byte.toString(16);
				rlt += byteStr + ",";
			}
			return rlt;
		}
		
		public static function clone(source:ByteArray):ByteArray
		{
			var cloned:ByteArray = new ByteArray();
			var len:int = source.length;
			for (var i:int = 0; i < len; i++) 
			{
				cloned[i] = source[i];
			}
			return cloned;
		}
		
		public static function clear(value:ByteArray):ByteArray
		{
			value.position = 0;
			value.length = 0;
			return value;
		}
		
		public static function copy(src:ByteArray,dest:ByteArray):ByteArray
		{
			src.position = 0;
			src.readBytes(dest,dest.length,src.bytesAvailable);
			src.position = 0;
			return dest;
		}
	}
}