package ui;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import flash.display.LineScaleMode;

// oscilloscope

class Osc1 extends Sprite
{
    private static var bgColor:Int = 0x00FF00;
    private var screen:Bitmap;
    private var screenData:BitmapData;
    private var size:Int;
    private var oscValue:Int;

    public function new(x:Int, y:Int, size:Int)
    {
        trace("new");
        super();
        this.size = size;
        this.x = x;
        this.y = y;

        screen = new Bitmap();
        screenData = new BitmapData(size, size, false, bgColor);
        screen.bitmapData = screenData;

        addChild(screen);

        Lib.stage.addEventListener (Event.ENTER_FRAME, this_onEnterFrame);
    }

    private function draw():Void
    {
        //trace("drawing");

//        graphics.beginFill(bgColor);
//        graphics.drawRect(x, y, size, size);
//        graphics.endFill();
    }

    private function this_onEnterFrame (event:Event):Void
    {
        //trace("enter frame");

    }

    public function updateValue(value:Int):Void
    {
        //trace("updatevalue");
        this.oscValue = value;


        for(iy in 0...size) {
            for(ix in 0...size) {
                //trace(ix + " " + iy);
                var pixel:Int = (Std.random(255) | Std.random(255) | Std.random(255));
                //trace(pixel);
                screenData.setPixel(ix, iy, pixel);
            }
        }
    }

}