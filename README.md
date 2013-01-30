ASImageLib
==========

bmp,png decoder for actionscript

#PNG Decode

##How to decode PNG ByteArray

Plain ActionScript:
 //_pngClass is your png byteArray
 //below is an example of embeded situation
 //[Embed(source="assets/Earth_ga_16.png",mimeType="application/octet-stream")]
 //private var _pngClass:Class;
 var bmpData:BitmapData = new PNGDecoder().decode(new _pngClass());
 this.addChild(new Bitmap(bmpData));