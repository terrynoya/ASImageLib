package com.terrynoya.image.BMP
{
	import com.terrynoya.common.color.ColorUtil;
	import com.terrynoya.io.BufferedByteReader;

	public class BMP16Data
	{
		public function BMP16Data()
		{
		}
		
		public static function decode(bytesReader:BufferedByteReader,bmpInfoHeader:BMPInfoHeader):BitmapInfo
		{
			var bmpInfo:BitmapInfo = new BitmapInfo(bmpInfoHeader.width,bmpInfoHeader.height);
			
			var bmpHeight:int = bmpInfoHeader.height;
			var bmpWidth:int = bmpInfoHeader.width;
			var bitCount:int = bmpInfoHeader.bitCount;
			
			var padding:int = (bmpWidth % 2 ) * 2;
			
			var pixels:Vector.<uint> = new Vector.<uint>(bmpWidth * bmpHeight, true);
			
			for(var i:int = 0; i < bmpHeight; i++)
			{
				for(var k:int = 0; k < bmpWidth; k++)
				{
					var position:int = (bmpHeight - 1 - i) * bmpWidth + k;
					var twoByte:int = bytesReader.readShot();
					pixels[position] = getColorByShort(twoByte);
				}
				bytesReader.position += padding;
			}
			bmpInfo.pixels = pixels;
			return bmpInfo;
		}
		
		private static function getColorByShort(color16:int):uint
		{
			// 5 bit for each color, msb is reserved
			var red:uint = color16 & 0x1F;
			var blue:uint = (color16 >> 5) & 0x1F;
			var green:uint = (color16 >> 10) & 0x1F;
			return ColorUtil.getColor(
				change5BitTo32Color(red),
				change5BitTo32Color(green),
				change5BitTo32Color(blue)
			);
		}
		
		private static function change5BitTo32Color(colorIn5Bit:uint):uint
		{
			return colorIn5Bit * 255 / 32;
		}
	}
}