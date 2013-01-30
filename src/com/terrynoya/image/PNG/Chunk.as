package com.terrynoya.image.PNG
{
	import com.flashrek.utils.CRC32;
	import com.terrynoya.charset.Charset;
	import com.terrynoya.image.PNG.chunk.Chunk_pHYs;
	import com.terrynoya.image.PNG.chunk.Chunk_sBIT;
	import com.terrynoya.image.PNG.chunk.IHDR;
	import com.terrynoya.image.PNG.chunk.PLTE;
	import com.terrynoya.io.BufferedByteReader;
	
	import flash.utils.ByteArray;

	public class Chunk
	{
		private var _length:int;
		private var _type:String;
		private var _crc:uint;
		private var _dataCRC:uint;
		private var _data:ByteArray;
		
		public function Chunk()
		{
			
		}
		
		public function get data():ByteArray
		{
			return _data;
		}

		public function get type():String
		{
			return _type;
		}
		
		public static function decode(reader:BufferedByteReader):Chunk
		{
			var chunk:Chunk =  new Chunk();
			chunk.decode(reader);
			return chunk;
		}

		public function decode(reader:BufferedByteReader):void
		{
			this._length = reader.readUnsignedInt();
			this._type = reader.readMultiByte(4,Charset.ASCII);
			this._data = reader.read(this._length);
			trace(this._type);
			trace("isCritical chunk:",ChunkNameValidator.isCriticalChunk(this._type));
			if(this._length == 0 && reader.bytesAvailable == 0)
			{
				return;
			}
			var checkLen:int = this._length + 4;
			this._dataCRC = CRC32.getHash(reader.source,reader.position - checkLen,checkLen);
			this._crc = reader.readUnsignedInt();
			trace("data crc:",this._dataCRC.toString(16)," embed crc:",this._crc.toString(16));
		}
		
		public function get isCRCMatch():Boolean 
		{
			return this._dataCRC == this._crc;
		}
	}
}