package com.terrynoya.image.BMP
{
	import com.terrynoya.common.color.ColorUtil;
	import com.terrynoya.io.BufferedByteReader;

	public class BMP24Data
	{
		public function BMP24Data()
		{
		}
		
		public static function decode(bytesReader:BufferedByteReader,bmpInfoHeader:BMPInfoHeader):BitmapInfo
		{
			var bmpInfo:BitmapInfo = new BitmapInfo(bmpInfoHeader.width,bmpInfoHeader.height);
			
			var bmpHeight:int = bmpInfoHeader.height;
			var bmpWidth:int = bmpInfoHeader.width;
			var bitCount:int = bmpInfoHeader.bitCount;
			
			var padding:int = bmpWidth % 4;
			var pixels:Vector.<uint> = new Vector.<uint>(bmpWidth * bmpHeight, true);
			
			for(var i:int = 0; i < bmpHeight; i++)
			{
				for(var k:int = 0; k < bmpWidth; k++)
				{
					var position:int = (bmpHeight - 1 - i) * bmpWidth + k;
					var blue:uint = bytesReader.readUnsignedByte();
					var green:uint = bytesReader.readUnsignedByte();
					var red:uint = bytesReader.readUnsignedByte();
					var color:uint = ColorUtil.getColor(red,green,blue);
					pixels[position] = color;
				}
				bytesReader.position += padding;
			}
			
			bmpInfo.pixels = pixels;
			return bmpInfo;
		}
	}
}