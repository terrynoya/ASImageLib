package com.terrynoya.image.PNG.chunk
{
	import com.terrynoya.image.PNG.PNGColorType;
	
	import flash.utils.ByteArray;

	/**
	 * 
	 * @author terrynoya
	 */
	public class IHDR
	{
		private var _width:int;
		private var _height:int;
		private var _bitDepth:int;
		private var _colorType:int;
		/**
		 *must be 0 
		 */		
		private var _compression:int;			
		/**
		 * must be 0
		 */		
		private var _filterMode:int;
		private var _interLaceMode:int;
		
		/**
		 * 
		 */
		public function IHDR()
		{
			
		}
		
		/**
		 * 0	no interlaced
		 * 1	adam 7 interlacing
		 */
		public function get interLaceMode():int
		{
			return _interLaceMode;
		}

		/**
		 * 0	GrayScale
		 * 2	RGB Triple
		 * 3	Palette
		 * 4	GrayScale with Alpha Channel
		 * 6	RGB	width Alpha Channel
		 */
		public function get colorType():int
		{
			return _colorType;
		}

		/**
		 *1,2,4,8 or 16 
		 */
		public function get bitDepth():int
		{
			return _bitDepth;
		}

		public function get height():int
		{
			return _height;
		}

		public function get width():int
		{
			return _width;
		}
		
		public function get bpp():int 
		{
			var bit12348:Array = [1,2,3,4,8];
			if(this.colorType == PNGColorType.PALETTE && bit12348.indexOf(this.bitDepth) != -1)
			{
				return 1;
			}
			else if(this.colorType == PNGColorType.RGB_ALPHA && this.bitDepth == 8)
			{
				return 4;
			}
			else if(this.colorType == PNGColorType.GRAY_SCALE && this.bitDepth == 16)
			{
				return 2;
			}
			else if(this.colorType == PNGColorType.GRAY_SCALE_ALPHA && this.bitDepth == 16)
			{
				return 4;
			}
			else if(this.colorType == PNGColorType.GRAY_SCALE_ALPHA && this.bitDepth == 8)
			{
				return 2;
			}
			else if(this.colorType == PNGColorType.RGB_ALPHA && this.bitDepth == 16)
			{
				return 8;
			}
			return 1;
		}

		public function decode(bytes:ByteArray):void
		{
			this._width = bytes.readInt();
			this._height = bytes.readInt();
			this._bitDepth = bytes.readByte();
			this._colorType = bytes.readByte();
			this._compression = bytes.readByte();
			this._filterMode = bytes.readByte();
			this._interLaceMode = bytes.readByte();
			
			// trace("width:",this._width);
			// trace("height:",this._height);
			// trace("bitDepth",this._bitDepth);
			// trace("colorType",this._colorType);
		}
	}
}
