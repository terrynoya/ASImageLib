package com.terrynoya.image.PNG
{
	import com.terrynoya.common.color.ColorInfo;
	import com.terrynoya.common.color.ColorUtil;
	import com.terrynoya.image.BMP.BitmapInfo;
	import com.terrynoya.image.PNG.chunk.IHDR;
	import com.terrynoya.image.PNG.chunk.PLTE;
	import com.terrynoya.image.PNG.enums.PNGEnterlacing;
	import com.terrynoya.image.PNG.enums.PNGRowFilterMode;
	import com.terrynoya.image.PNG.rowFilter.AverageFilter;
	import com.terrynoya.image.PNG.rowFilter.NoFilter;
	import com.terrynoya.image.PNG.rowFilter.PaethFilter;
	import com.terrynoya.image.PNG.rowFilter.SubFilter;
	import com.terrynoya.image.PNG.rowFilter.UpFilter;
	import com.terrynoya.io.BufferedByteReader;
	import com.terrynoya.io.ByteUtil;
	
	import flash.display.BitmapData;
	import flash.utils.ByteArray;

	public class PNGDataProcessor
	{
		private var _image:BitmapData;
		private var _decoder:PNGDecoder;
		
		public function PNGDataProcessor(decoder:PNGDecoder)
		{
			this._decoder = decoder;
		}
		
		public function decode(bytes:ByteArray,ihdr:IHDR):BitmapInfo
		{
			bytes.uncompress();
			if(ihdr.interLaceMode == PNGEnterlacing.ADAM_7_INTERLACING)
			{
				bytes = this.doInterlacing(bytes);			
			}
			var imageBytes:ByteArray = this.doFiltering(bytes,ihdr.width,ihdr.height,ihdr.bpp);	
			return this.bytesToImage(imageBytes,ihdr);
		}
		
		private function bytesToImage(bytes:ByteArray,ihdr:IHDR):BitmapInfo
		{
			if((ihdr.bitDepth == 16 || ihdr.bitDepth == 8) && ihdr.colorType == PNGColorType.RGB_ALPHA)
			{
				return rgbaToImage(bytes,ihdr.width,ihdr.height);
			}
			else if(ihdr.colorType == PNGColorType.GRAY_SCALE && ihdr.bitDepth == 16)
			{
				this.grayScale16ToImage(bytes,ihdr.width,ihdr.height,ihdr.bitDepth);
			}
			else if(ihdr.colorType == PNGColorType.GRAY_SCALE_ALPHA && ihdr.bitDepth == 16)
			{
				return this.grayScaleAlpha16ToImage(bytes,ihdr.width,ihdr.height,ihdr.bitDepth);
			}
			else if(ihdr.colorType == PNGColorType.GRAY_SCALE_ALPHA && ihdr.bitDepth == 8)
			{
				return this.grayScaleAlpha8BitToImage(bytes,ihdr.width,ihdr.height,ihdr.bitDepth);
			}
			else if(ihdr.colorType == PNGColorType.PALETTE)
			{
				return this.paletteToImage(bytes,ihdr.width,ihdr.height,this._decoder.palette);
			}
			return null; 
		}
		
		private function grayScale16ToImage(bytes:ByteArray,width:int,height:int,bitDepth:int):BitmapInfo
		{
			var bmpInfo:BitmapInfo = new BitmapInfo(width,height);
			var colors:Array = new Array();
			var grayPalette:GrayScalePalette = new GrayScalePalette();
			grayPalette.make(bitDepth);
			for (var i:int = 0; i < height; i++) 
			{
				for (var j:int = 0; j < width; j++) 
				{
					var colorInfo:ColorInfo = new ColorInfo();
					colorInfo.x = j;
					colorInfo.y = i;
					var index:uint = bytes.readUnsignedShort();
					var alpha:uint = bytes.readUnsignedShort();
					colorInfo.color = grayPalette.getColorAt(index) | alpha << 24;
					colors.push(colorInfo);
				}
			}
			bmpInfo.colors = colors;
			return bmpInfo;
		}
		
		private function grayScaleAlpha8BitToImage(bytes:ByteArray,width:int,height:int,bitDepth:int):BitmapInfo
		{
			var bmpInfo:BitmapInfo = new BitmapInfo(width,height);
			var colors:Array = new Array();
			var grayPalette:GrayScalePalette = new GrayScalePalette();
			grayPalette.make(bitDepth);
			for (var i:int = 0; i < height; i++) 
			{
				for (var j:int = 0; j < width; j++) 
				{
					var colorInfo:ColorInfo = new ColorInfo();
					colorInfo.x = j;
					colorInfo.y = i;
					var index:uint = bytes.readUnsignedByte();
					var alpha:uint = bytes.readUnsignedByte();
					colorInfo.color = grayPalette.getColorAt(index) | (alpha << 24);
					colors.push(colorInfo);
				}
			}
			bmpInfo.colors = colors;
			return bmpInfo;
		}
		
		private function grayScaleAlpha16ToImage(bytes:ByteArray,width:int,height:int,bitDepth:int):BitmapInfo
		{
			var bmpInfo:BitmapInfo = new BitmapInfo(width,height);
			var colors:Array = new Array();
			var grayPalette:GrayScalePalette = new GrayScalePalette();
			grayPalette.make(bitDepth);
			for (var i:int = 0; i < height; i++) 
			{
				for (var j:int = 0; j < width; j++) 
				{
					var colorInfo:ColorInfo = new ColorInfo();
					colorInfo.x = j;
					colorInfo.y = i;
					var index:uint = bytes.readUnsignedShort();
					var alpha:uint = bytes.readUnsignedShort();
					colorInfo.color = grayPalette.getColorAt(index) | alpha << 24;
					colors.push(colorInfo);
				}
			}
			bmpInfo.colors = colors;
			return bmpInfo;
		}
		
		private function paletteToImage(bytes:ByteArray,width:int,height:int,palette:PLTE):BitmapInfo
		{
			var bmpInfo:BitmapInfo = new BitmapInfo(width,height);
			var colors:Array = new Array();
			for (var i:int = 0; i < height; i++) 
			{
				for (var j:int = 0; j < width; j++) 
				{
					var colorInfo:ColorInfo = new ColorInfo();
					colorInfo.x = j;
					colorInfo.y = i;
					var index:uint = bytes.readUnsignedByte();
					colorInfo.color = palette.getColorAt(index);
					colors.push(colorInfo);
				}
			}
			bmpInfo.colors = colors; 
			return bmpInfo;
		}
		
		private function rgbaToImage(bytes:ByteArray,width:int,height:int):BitmapInfo
		{
			var bmpInfo:BitmapInfo = new BitmapInfo(width,height);
			var colors:Array = new Array();
			for (var i:int = 0; i < height; i++) 
			{
				for (var j:int = 0; j < width; j++) 
				{
					var colorInfo:ColorInfo = new ColorInfo();
					colorInfo.x = j;
					colorInfo.y = i;
					var red:uint = bytes.readUnsignedByte();
					var green:uint = bytes.readUnsignedByte();
					var blue:uint = bytes.readUnsignedByte();
					var alpha:uint = bytes.readUnsignedByte();
					colorInfo.color = ColorUtil.getColor(red,green,blue,alpha);
					colors.push(colorInfo);
				}
			}
			bmpInfo.colors = colors;
			return bmpInfo;
		}
		
		private function doFiltering(bytes:ByteArray,width:int,height:int,bpp:int):ByteArray
		{
			var colorBytes:ByteArray = new ByteArray();
			
			var preLine:ByteArray;
			var currentLine:ByteArray = new ByteArray();
			var byteLen:int = width * bpp; 
			
			var reader:BufferedByteReader = new BufferedByteReader(bytes.endian,bytes);
			var rowBytes:ByteArray;
			for (var y:int = 0; y < height; y++) 
			{
				var filter:int = bytes.readUnsignedByte();
				rowBytes = reader.read(byteLen);
				ByteUtil.clear(currentLine);
				if(filter == PNGRowFilterMode.SUB_FILTER)
				{
					SubFilter.decode(rowBytes,bpp,currentLine,preLine);
				}
				else if(filter == PNGRowFilterMode.UP_FILTER)
				{
					UpFilter.decode(rowBytes,bpp,currentLine,preLine);
				}
				else if(filter == PNGRowFilterMode.AVERAGE_FILTER)
				{
					AverageFilter.decode(rowBytes,bpp,currentLine,preLine);
				}
				else if(filter == PNGRowFilterMode.PAETH_FILTER)
				{
					PaethFilter.decode(rowBytes,bpp,currentLine,preLine);
				}
				else
				{
					NoFilter.decode(rowBytes,bpp,currentLine,preLine);
				}
				preLine = ByteUtil.clone(currentLine);
				ByteUtil.copy(preLine,colorBytes);
			}
			return colorBytes;
		}
		
		private function getColorByRow(bytes:ByteArray,row:int):Array
		{
			var rlt:Array = new Array();
			var len:int = bytes.length / 4
			for (var i:int = 0; i < len; i++) 
			{
				var color:ColorInfo = new ColorInfo();
				var r:uint = bytes.readUnsignedByte();
				var g:uint = bytes.readUnsignedByte();
				var b:uint = bytes.readUnsignedByte();
				var a:uint = bytes.readUnsignedByte();
				color.color = ColorUtil.getColor(r,g,b);
				color.y = row;
				color.x = i;
				rlt.push(color);
			}
			return rlt;
			
		}
		
		private function doInterlacing(bytes:ByteArray):ByteArray
		{
			return bytes;
		}
	}
}