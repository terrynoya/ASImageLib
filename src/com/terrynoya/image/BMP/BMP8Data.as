package com.terrynoya.image.BMP
{
	import com.terrynoya.image.BMP.palette.BMPColorPalette;
	import com.terrynoya.io.BufferedByteReader;

	public class BMP8Data
	{
		public function BMP8Data()
		{
			
		}
		
		public static function decode(bytesReader:BufferedByteReader,bmpInfoHeader:BMPInfoHeader,colorPalette:BMPColorPalette):BitmapInfo
		{
			var bmpInfo:BitmapInfo = new BitmapInfo(bmpInfoHeader.width,bmpInfoHeader.height);
			
			var bmpHeight:int = bmpInfoHeader.height;
			var bmpWidth:int = bmpInfoHeader.width;
			var bitCount:int = bmpInfoHeader.bitCount;
			
			var padding:int = bmpWidth % 2;
			var pixels:Vector.<uint> = new Vector.<uint>(bmpWidth * bmpHeight, true);
			
			for(var i:int = 0; i < bmpHeight; i++)
			{
				for(var k:int = 0; k < bmpWidth; k++)
				{
					var index:uint = bytesReader.readUnsignedByte();
					var position:int = (bmpHeight - 1 - i) * bmpWidth + k;
					var color:uint = colorPalette.getPaletteAt(index).color;
					pixels[position] = color;
				}
				bytesReader.position += padding;
			}
			bmpInfo.pixels = pixels;
			return bmpInfo;
		}
	}
}