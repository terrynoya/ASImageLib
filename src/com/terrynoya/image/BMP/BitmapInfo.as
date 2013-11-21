package com.terrynoya.image.BMP
{

	import flash.display.BitmapData;
	import flash.geom.Rectangle;

	public class BitmapInfo
	{
		private var _width:int;
		private var _height:int;
		private var _pixels:Vector.<uint>;

		public function BitmapInfo(width:int,height:int)
		{
			this._width = width;
			this._height = height;
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
			var rect:Rectangle = new Rectangle(0, 0, this._width, this._height);
			var bmpData:BitmapData = new BitmapData(this._width, this._height, true, 0);
			bmpData.setVector(rect, _pixels);
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