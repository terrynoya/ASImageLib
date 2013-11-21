package com.terrynoya.image.PNG
{
	import com.terrynoya.image.BMP.BitmapInfo;
	import com.terrynoya.image.PNG.chunk.Chunk_pHYs;
	import com.terrynoya.image.PNG.chunk.Chunk_sBIT;
	import com.terrynoya.image.PNG.chunk.Chunk_tEXt;
	import com.terrynoya.image.PNG.chunk.IHDR;
	import com.terrynoya.image.PNG.chunk.PLTE;
	import com.terrynoya.image.PNG.chunk.Chunk_tRNS;
	import com.terrynoya.io.BufferedByteReader;

	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	public class PNGDecoder
	{
		public static const SIGNATURE:Array = [137,80,78,71,13,10,26,10];

		private var _headerInfo:IHDR;
		private var _palette:PLTE;
		private var _phys:Chunk_pHYs;
		private var _sbit:Chunk_sBIT;
		private var _tEXt:Chunk_tEXt;
		private var _tRNS:Chunk_tRNS;

		private var _imageData:ByteArray;

		public function PNGDecoder()
		{

		}

		public function get headerInfo():IHDR
		{
			return _headerInfo;
		}

		public function get palette():PLTE
		{
			return _palette;
		}

		public function get tRNS():Chunk_tRNS {
			return _tRNS;
		}

		public function decode(bytes:ByteArray):BitmapData
		{
			this._imageData = new ByteArray();
			var reader:BufferedByteReader = new BufferedByteReader(Endian.BIG_ENDIAN,bytes);
			this.validateHeader(reader.read(8));
			while(reader.bytesAvailable)
			{
				var ck:Chunk = Chunk.decode(reader);
				this.decodeChunkData(ck);
			}
			var bmpInfo:BitmapInfo = new PNGDataProcessor(this).decode(this._imageData,this._headerInfo);
			return bmpInfo.make();

		}

		private function decodeChunkData(chunk:Chunk):void
		{
			var bytes:ByteArray = chunk.data;
			switch(chunk.type)
			{
				case ChunkType.IHDR:
				{
					this._headerInfo = new IHDR();
					this._headerInfo.decode(bytes);
					break;
				}
				case ChunkType.PLTE:
				{
					this._palette = new PLTE();
					this._palette.decode(bytes);
					break;
				}
				case ChunkType.IDAT:
				{
					var srcData:ByteArray = chunk.data;
					srcData.readBytes(this._imageData,this._imageData.length,srcData.length);
					break;
				}
				case ChunkType.pHYs:
				{
					this._phys = new Chunk_pHYs();
					this._phys.decode(bytes);
					break;
				}
				case ChunkType.sBIT:
				{
					this._sbit = new Chunk_sBIT();
					this._sbit.decode(bytes);
					break;
				}
				case ChunkType.tEXt:
				{
					this._tEXt = new Chunk_tEXt();
					this._tEXt.decode(bytes);
					break;
				}
				case ChunkType.tRNS:
				{
					_tRNS = new Chunk_tRNS();
					_tRNS.decode(bytes, _headerInfo != null ? _headerInfo.colorType : -1);
					break;
				}
				default:
					//Logger.log("No decoder defined for chunk: " + chunk.type);
					break;
			}
		}

		/**
		 * validate png header
		 * @param bytes
		 * @return
		 *
		 */
		private function validateHeader(bytes:ByteArray):Boolean
		{
			var rlt:Boolean = true;
			for (var i:int = 0; bytes.bytesAvailable; i++)
			{
				var byte:int = bytes.readUnsignedByte();
				if(byte != SIGNATURE[i])
				{
					rlt = false;
					break;
				}
			}
			return rlt;
		}
	}
}