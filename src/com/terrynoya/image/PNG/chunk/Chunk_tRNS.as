package com.terrynoya.image.PNG.chunk {
	import com.terrynoya.image.PNG.PNGColorType;

	import flash.utils.ByteArray;

	public class Chunk_tRNS {

		private var _alphas:Vector.<uint>;

		public function Chunk_tRNS() {
			_alphas = new Vector.<uint>();
		}

		public function decode(bytes:ByteArray, colorType : int):void{
			if(colorType == PNGColorType.PALETTE){
				var alphasLen:int = bytes.length;
				for (var i:int = 0; i < alphasLen; i++)
				{
					var alpha:uint = bytes.readUnsignedByte();
					_alphas.push(alpha);
				}
			}
		}

		public function getAlphaAt(index : int) : uint {
			return _alphas[index];
		}

	}
}
