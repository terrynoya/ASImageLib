package com.terrynoya.common.color
{
	import flash.utils.ByteArray;

	public class RGBAColor
	{
		private var _red:uint;
		private var _green:uint;
		private var _blue:uint;
		private var _alpha:uint;
		
		public function RGBAColor(r:uint = 255,g:uint = 255,b:uint = 255,a:uint = 255)
		{
			this._red = r;
			this._green = g;
			this._blue = b;
			this._alpha = a;
		}
		
		public function get alpha():uint
		{
			return _alpha;
		}

		public function set alpha(value:uint):void
		{
			_alpha = value;
		}

		public function get blue():uint
		{
			return _blue;
		}

		public function set blue(value:uint):void
		{
			_blue = value;
		}

		public function get green():uint
		{
			return _green;
		}

		public function set green(value:uint):void
		{
			_green = value;
		}

		public function get red():uint
		{
			return _red;
		}

		public function set red(value:uint):void
		{
			_red = value;
		}

		public static function getColor(color:uint):RGBAColor
		{
			var r:uint = ColorUtil.red(color);
			var g:uint = ColorUtil.green(color);
			var b:uint = ColorUtil.blue(color);
			var a:uint = ColorUtil.alpha(color);
			var vo:RGBAColor = new RGBAColor(r,g,b,a);
			return vo;
		}
		
		public function add(value:RGBAColor,module:Boolean = true):RGBAColor
		{
			var rlt:RGBAColor = new RGBAColor();
			rlt.red = (this.red + value.red) & 0xFF;
			rlt.green = (this.green + value.green) & 0xFF;
			rlt.blue = (this.blue + value.blue) & 0xFF;
			rlt.alpha = (this.alpha + value.alpha) & 0xFF;
			return rlt;
		}
		
		public function decode(bytes:ByteArray):void
		{
			this._red = bytes.readUnsignedByte();
			this._green = bytes.readUnsignedByte();
			this._blue = bytes.readUnsignedByte();
			this._alpha = bytes.readUnsignedByte();
		}
		
		public function get color():uint 
		{
			var rlt:uint = ColorUtil.getColor(this._red,this._green,this._blue,this._alpha);
			return rlt;
		}
	}
}