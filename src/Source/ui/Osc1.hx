package ui;
import flash.geom.Matrix;
import flash.display.BlendMode;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import flash.display.LineScaleMode;

// oscilloscope

class Osc1 extends Sprite
{
    private static var bgColor:Int = 0x000000;
    private static var gridColor:Int = 0x888888;
    private static var plotColor:Int = 0x78C5F5;

    private var screen:Bitmap;
    private var screenData:BitmapData;
    private var size:Int;
    private var oscValue:Float = 0;
    private var oscAmplitude:Float = 4;
    private var scrollRate:Int = 1;

    // store last plot variables
    private var lastOscValue:Float = 0;
    private var lastPlotPixel:Float = 0;

    public function new(x:Int, y:Int, size:Int)
    {

        super();
        this.size = size;
        this.oscAmplitude = size / 3;
        this.x = x;
        this.y = y;

        screen = new Bitmap();
        screenData = new BitmapData(size, size, false, bgColor);
        screen.bitmapData = screenData;

        addChild(screen);

        Lib.stage.addEventListener (Event.ENTER_FRAME, this_onEnterFrame);
    }


    private function this_onEnterFrame (event:Event):Void
    {
        updateScreen();
    }

    public function updateValue(value:Float):Void
    {
        //trace("updatevalue");
        lastOscValue = oscValue;
        oscValue = value;
    }

    private function updateScreen():Void
    {
        //var newScreenData:BitmapData = new BitmapData(size, size, false, bgColor);

//        // from 2nd ( NOT 1st ) pixel so we slide to the left since we -1 this pos.
//        for(iy in 0...size) {
//            for(ix in 0...size) {
//                //var pixel:Int = (Std.random(255) + Std.random(255) +  Std.random(255));
//                //screenData.setPixel(ix, iy, pixel);
////                var pixel:Int = ;
//                //trace(screenData.getPixel(-ix,iy));
//                //screenData.scroll(ix-2,iy);
//                screenData.setPixel(ix-1,iy, screenData.getPixel(ix,iy));
//                //screenData.setPixel(ix,iy, screenData.getPixel(ix+1,iy));
//
//            }
//        }

//        if (oscValue < 0)
//        {
//            oscAmplitude = -1 * oscAmplitude;
//        } else {
//            oscAmplitude = 1 * oscAmplitude;
//        }

        screenData.scroll(-1 * scrollRate,0);
        var plotPixel:Float;

        plotPixel = (size/2) - (oscAmplitude*this.oscValue);

//        if (oscValue < 0) {
//            // negative the ize
//            plotPixel = (size/2) + (oscAmplitude*this.oscValue);
//            trace("size/2" + size/2);
//            trace("adjusted amplit:" + oscAmplitude*this.oscValue);
//            trace("less than: " + this.oscValue + " pp: " + Std.int(plotPixel) + " ppint " + plotPixel);
//        } else {
//            plotPixel = (size/2) + (oscAmplitude*this.oscValue);
//            trace("more than: " + this.oscValue + " pp: " + Std.int(plotPixel));
//        }

        // seems like the int conversion looses the sign
        var newPlotPoint = new Point(Std.int(screenData.width)-2, Std.int(plotPixel));

        //var lastPlotPixel:Float = (size/2)-oscAmplitude +(oscAmplitude*this.lastOscValue);
        var lastPlotPoint = new Point(Std.int(screenData.width)-3, Std.int(lastPlotPixel));
        lastPlotPixel = plotPixel;

        // put the pixel on the rightmost column at correct height
        screenData.setPixel32(size-2, Std.int(plotPixel), plotColor);
        //screenData.setPixel(Std.int(newPlotPoint.x), Std.int(newPlotPoint.y), plotColor);

        // draw center line
        screenData.setPixel32(Std.int(this.width)-1, Std.int(this.height/2), gridColor);
        screenData.setPixel32(Std.int(this.width)-1, Std.int((size/2) - oscAmplitude), gridColor);
        screenData.setPixel32(Std.int(this.width)-1, Std.int((size/2) + oscAmplitude), gridColor);
        //screenData.setPixel32(Std.int(this.width)-1, Std.int(this.height/4), gridColor);

        // line between old point and new point
        var lineBmp:Bitmap = new Bitmap();
        lineBmp.bitmapData = new BitmapData(screenData.width, screenData.height, true, 0x00000000);
        lineBmp.graphics.lineStyle(0.3, plotColor, 0.5, false, LineScaleMode.NONE);
        //lineBmp.graphics.moveTo(Std.int(newPlotPoint.x), Std.int(newPlotPoint.y));

        lineBmp.graphics.moveTo(Std.int(lastPlotPoint.x), Std.int(lastPlotPoint.y));

        lineBmp.graphics.curveTo(Std.int(newPlotPoint.x), Std.int(newPlotPoint.y), Std.int(this.width)-2,  Std.int(lastPlotPoint.y));
        lineBmp.graphics.curveTo(Std.int(lastPlotPoint.x), Std.int(lastPlotPoint.y), Std.int(this.width)-2,  Std.int(newPlotPoint.y));


        //lineBmp.graphics.lineTo(Std.int(lastPlotPoint.x), Std.int(lastPlotPoint.y));

        // Draw the lineBmp onto this one
        screenData.draw(lineBmp, new Matrix(), null, null, null, false);


    }

}