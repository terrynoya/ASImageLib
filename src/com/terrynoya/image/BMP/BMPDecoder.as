package com.terrynoya.image.BMP
{
	import com.terrynoya.common.color.ColorUtil;
	import com.terrynoya.image.BMP.palette.BMPColorPalette;
	import com.terrynoya.image.BMP.palette.RGBQuad;
	import com.terrynoya.io.BufferedByteReader;
	
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	/**
	 * Data Structure in ByteArray
	 * File Header
	 * Image Header
	 * Color Table
	 * Pixel Data 
	 * @author terrynoya
	 * 
	 */
	public class BMPDecoder
	{
		public static const HEADER_LENGTH:int = 14;
		public static const BMP_INFO_HEADER_LENGTH:int = 40;
		public static const BMP_CORE_HEADER_LENGTH:int = 12;
		
		private var _header:BMPFileHeader;
		private var _bmpInfoHeader:BMPInfoHeader;
		private var _bmpCoreHeader:BMPCoreHeader;
		private var _colorPalette:BMPColorPalette;
		
		public function BMPDecoder()
		{
			this._header = new BMPFileHeader();
			this._bmpInfoHeader = new BMPInfoHeader();
			this._bmpCoreHeader = new BMPCoreHeader();
		}
		
		public function decode(bytes:ByteArray):BitmapData
		{
			var reader:BufferedByteReader = new BufferedByteReader(Endian.LITTLE_ENDIAN,bytes);
			this._header.decode(reader.read(HEADER_LENGTH));
			//warning: info header can be larger than 40
			//better to have test 4byte(length) before read(BMP_INFO_HEADER_LENGTH)
			this._bmpInfoHeader.decode(reader.read(BMP_INFO_HEADER_LENGTH));
			if(this._bmpInfoHeader.isPaletteNeeded)
			{
				this._colorPalette = new BMPColorPalette(this._bmpInfoHeader.bitCount);
				this._colorPalette.decode(reader.read(this._colorPalette.size));
			}
			var bmpInfo:BitmapInfo = this.decodeImageData(reader);
			return bmpInfo.make();	
		}
		
		private function decodeImageData(bytesReader:BufferedByteReader):BitmapInfo
		{
			bytesReader.position = this._header.dataOffset;	
			var bmpInfo:BitmapInfo;
			switch(this._bmpInfoHeader.bitCount)
			{
				case 8:
				{
					bmpInfo = BMP8Data.decode(bytesReader,this._bmpInfoHeader,this._colorPalette);
					break;
				}
				case 16:
				{
					bmpInfo = BMP16Data.decode(bytesReader,this._bmpInfoHeader);
					break;
				}
				case 24:
				{
					bmpInfo = BMP24Data.decode(bytesReader,this._bmpInfoHeader);
					break;
				}
			}
			return bmpInfo;
		}
	}
}