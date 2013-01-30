package com.terrynoya.common.color
{
	public class ColorUtil
	{
		public function ColorUtil()
		{
			
		}
		
		public static function getColor(red:uint = 255,green:uint = 255,blue:uint = 255,alpha:uint = 255):uint
		{
			return blue | green << 8 | red << 16 | alpha << 24;
		}
		
		public static function alpha(color:uint):uint
		{
			return (color >> 24 )& 0xff;
		}
		
		public static function red(color:uint):uint
		{
			return (color >> 16) & 0xff;
		}
		
		public static function green(color:uint):uint
		{
			return (color >> 8) & 0xff;
		}
		
		public static function blue(color:uint):uint
		{
			return color & 0xff;
		}
		
		public static function getRandomColor():uint
		{
			return getColor(getRanCC(),getRanCC(),getRanCC());
		}
		
		public static function getRanCC():uint
		{
			return Math.floor(Math.random() * 255);
		}
	}
}