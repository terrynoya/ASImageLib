package com.terrynoya.io
{
	import flash.utils.ByteArray;

	public class BufferedByteReader
	{
		private var _buffer:ByteArray;
		
		private var _source:ByteArray;
		
		public function BufferedByteReader(endian:String,source:ByteArray)
		{
			this._buffer = new ByteArray();
			this._source = source;
			this._source.endian = this._buffer.endian = endian;
		}
		
		public function get source():ByteArray
		{
			return _source;
		}
		
		public function get bytesAvailable():uint 
		{
			return this._source.bytesAvailable;
		}

		public function read(length:int):ByteArray
		{
			this._buffer.clear();
			this._source.readBytes(this._buffer,0,length);
			this._buffer.position = 0;
			return this._buffer;
		}
		
		public function appendRead(length:int):ByteArray
		{
			this._source.readBytes(this._buffer,this._buffer.length,length);
			this._buffer.position = 0;
			return this._buffer;
		}
		
		public function set position(value:int):void 
		{
			this._source.position = value;
		}
		
		public function readMultiByte(length:int,charset:String):String
		{
			return this._source.readMultiByte(length,charset);
		}
		
		public function readUnsignedInt():uint
		{
			return this._source.readUnsignedInt();
		}
		
		public function readByte():int
		{
			return this._source.readByte();
		}
		
		public function readUnsignedByte():int
		{
			return this._source.readUnsignedByte();
		}
		
		public function readUnsignedShort():int
		{
			return this._source.readUnsignedShort();
		}
		
		public function readShort():int
		{
			return this._source.readShort();
		}
		
		public function get position():int 
		{
			return this._source.position;
		}
		
		public function readInt():int
		{
			return this._source.readInt();
		}
	}
}