package com.terrynoya.image.BMP
{
	import com.terrynoya.common.color.ColorInfo;
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;

	public class BitmapInfo
	{
		private var _width:int;
		private var _height:int;
		private var _pixels:Vector.<uint>;
		private var _colors:Array;
		
		public function BitmapInfo(width:int,height:int)
		{
			this._width = width;
			this._height = height;
		}
		
		public function get colors():Array
		{
			return _colors;
		}

		public function set colors(value:Array):void
		{
			_colors = value;
		}

		public function get pixels():Vector.<uint>
		{
			return _pixels;
		}

		public function set pixels(value:Vector.<uint>):void
		{
			_pixels = value;
		}

		public function make():BitmapData
		{
			//create a Rectangle with width / height of Bitmap
			var rect:Rectangle = new Rectangle(0, 0, this._width, this._height);
			//create the BitmapData object to hold hold the BMP data.
			//we do a red fill here so it is easier to see if we have any errors
			//in our code
			var bmpData:BitmapData = new BitmapData(this._width, this._height, true, 0);
			//copy the BMP pixel data into the BitmapData
			bmpData.setVector(rect, pixels);
			return bmpData;
		}
		
		public function makeByArray():BitmapData
		{
			var bmpData:BitmapData = new BitmapData(this._width,this._height,true,0x0);
			var len:int = this._colors.length;
			for (var i:int = 0; i < len; i++) 
			{
				var info:ColorInfo = this._colors[i];
				bmpData.setPixel32(info.x,info.y,info.color);
			}
			return bmpData;
		}

		public function get width():int
		{
			return _width;
		}

		public function set width(value:int):void
		{
			_width = value;
		}

		public function get height():int
		{
			return _height;
		}

		public function set height(value:int):void
		{
			_height = value;
		}
	}
}