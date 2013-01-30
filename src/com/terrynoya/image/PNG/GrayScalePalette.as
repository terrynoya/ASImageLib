package com.terrynoya.image.PNG
{
	import com.terrynoya.common.color.ColorUtil;

	/**
	 * palette for gray scale normal 8-bit or 16-bit
	 * @author yaojianzhou
	 */
	public class GrayScalePalette
	{
		private var _colors:Vector.<uint>;
		
		/**
		 * 
		 */
		public function GrayScalePalette()
		{
		}
		
		/**
		 * 
		 * @param bitDepth
		 */
		public function make(bitDepth:int = 8):void
		{
			this._colors = new Vector.<uint>();
			var len:uint = Math.pow(2,bitDepth);
			var maxLen:uint = len -1;
			for (var i:uint = 0; i < len; i++) 
			{
				var r:uint = i * 0xff / maxLen;
				var g:uint = i * 0xff / maxLen;
				var b:uint = i * 0xff / maxLen;
				var color:uint = ColorUtil.getColor(r,g,b,0);
				this._colors[i] = color;	
			}
		}
		
		/**
		 * 
		 * @param index
		 * @return 
		 */
		public function getColorAt(index:uint):uint
		{
			return this._colors[index];
		}
	}
}