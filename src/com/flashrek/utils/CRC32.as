package com.flashrek.utils
{
	import flash.utils.ByteArray;

	/**
	 * CRC 32位 校验类
	 * 与JAVA的CRC32类似
	 * 算法参考自 as3corelib http://code.google.com/p/as3corelib/
	 * 的 PNGEncoder.as 中CRC算法部分
	 * @author Telds[KingFo]
	 * @version 0.0.1
	 * @example
	 * var bytes:ByteArray = new ByteArray();
	 * var crc32:CRC32 = new CRC32();
	 * var str:String="kingfo";
	 * bytes.writeUTFBytes(str);
	 * crc32.update(bytes);
	 * trace(crc32);
	 */
	public class CRC32
	{
		public static const POLYNOMIAL:uint=0xEDB88320;

		private static var _instance:CRC32;
		
		private static function getInstance():CRC32
		{
			if(_instance == null)
			{
				_instance = new CRC32();
			}
			return _instance;
		}
		
		/**
		 * 创建获取CRC表
		 * @return
		 */
		public static function getCrcTable():Array
		{
			/* Make the table for a fast CRC. */
			if (!crcTableComputed)
			{
				crcTable=new Array(256);
				var c:uint;
				for (var i:uint=0; i < 256; i++)
				{
					c=i;
					for (var j:uint=0; j < 8; j++)
					{
						c=(c & 1) ? (c >>> 1) ^ POLYNOMIAL : (c >>> 1);
					}
					crcTable[i]=c;
				}
				crcTableComputed=true;
			}
			return crcTable;
		}

		public static function getHash(bytes:ByteArray,offset:int,length:int):uint
		{
			getInstance().reset();
			getInstance().update(bytes,offset,length);
			return getInstance().getValue();
		}
		
		/**
		 * 构造函数，实例化同时产生CRC表
		 */
		public function CRC32()
		{
			getCrcTable();
		}

		/**
		 * 更新CRC
		 * @param   bytes                   指定更新的字节流
		 * @param   offset                  偏移量，默认从 bytes.position=0 开始
		 * @param   length                  长度,默认为0，即指定更新的字节流的长度
		 */
		public function update(bytes:ByteArray, offset:int=0, length:int=0):void
		{
			length=length > 0 ? length : bytes.length;
			var c:uint=~value;
			for (var i:int=offset; i < offset + length; i++)
			{
				c=crcTable[(c ^ bytes[i]) & 0xFF] ^ (c >>> 8);
			}
			value=~c;
		}

		/**
		 * 获取结果
		 * @return
		 */
		public function getValue():uint
		{
			return value & 0xFFFFFFFF;
		}

		/**
		 * 重置结果
		 */
		public function reset():void
		{
			value=0x00000000;
		}

		public function toString():String
		{
			var v:uint=getValue();
			return "0x" + v.toString(16).toUpperCase();
		}



		private var value:uint=0x00000000;
		/* Table of CRCs of all 8-bit messages. */
		private static var crcTable:Array;
		/* Flag: has the table been computed? Initially false. */
		private static var crcTableComputed:Boolean=false;


	}

}
