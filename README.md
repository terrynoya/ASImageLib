### ASImageLib: PNG BMP file decoder in ActionScript3

ASImageLib is an OOP lib to decode PNG and BMP in AS3

### How To Use

***

### Decode PNG byteArray
    var bytes:ByteArray = new _pngClass();
    var bmpData:BitmapData = new PNGDecoder().decode(bytes);
    this.addChild(new Bitmap(bmpData));

***
### PNG Colortype supported detail
* 1.Gray Scale
* 2.Gray Scale Alpha width bitDepth 8 or 16
* 3.Palette width bitDepth 1,2,3,4 or 8
* 4.RGB alpha
