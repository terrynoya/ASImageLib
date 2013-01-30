package com.terrynoya.common.color
{
	public class ColorInfo
	{
		private var _x:int;
		private var _y:int;
		private var _color:uint;
		
		public function ColorInfo(x:int = 0,y:int = 0,color:uint = 0)
		{
			this._x = x;
			this._y = y;
			this._color = color;
		}
		
		public function getColorByRGB(r:uint,g:uint,b:uint,a:uint):void
		{
			this._color = ColorUtil.getColor(r,g,b,a);
		}

		public function get color():uint
		{
			return _color;
		}

		public function set color(value:uint):void
		{
			_color = value;
		}

		public function get y():int
		{
			return _y;
		}

		public function set y(value:int):void
		{
			_y = value;
		}

		public function get x():int
		{
			return _x;
		}

		public function set x(value:int):void
		{
			_x = value;
		}

	}
}