package ui;
import motion.Actuate;
import openfl.Assets;
import flash.events.MouseEvent;
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

// oscilloscope, accepts inputs from -1 to +1 floats.
//
// parameters:
//  x:Int position X
//  y:Int position Y
//  curve:Bool use beziers or not
//  scrollRate:Float, value to scroll X axis on, default -0.1
//  plotLineThickness: Int, the thickness of plotter lines, max 2 recommended.
//  bars:Bool, draw bar lines down to the center axis!

class Osc1 extends Sprite
{
    private static var bgColor:Int = 0x00FFFFFF;
    private static var gridColor:Int = 0x55555555;
    private static var plotColor:Int = 0x20F75A; //0x78C5F5;
    private static var lineColor:Int = 0x20F75A;

    private var screen:Bitmap;
    private var screenData:BitmapData;
    private var screenGrid:Bitmap;
    private var screenGridData:BitmapData;

    private var size:Int;
    private var oscValue:Float = 0;
    private var oscAmplitude:Float = 4;
    private var scrollRate:Float;
    private var speed:Int = 0;
    private var lastSpeed:Int = 0;
    private var curve:Bool;
    private var bars:Bool;
    private var lastTick:Int = 0;
    private var plotLineThickness:Int;
    private var joinDots:Bool = true;

    // store last plot variables
    private var lastOscValue:Float = 0;
    private var lastPlotPixel:Float = 0;

    // drag / drop stuff
    private var dragOffsetX:Float;
    private var dragOffsetY:Float;

    public function new(x:Int, y:Int, size:Int, ?curve:Bool=true, ?scrollRate=-0.1, ?plotLineThickness=2, ?bars=false)
    {

        super();
        this.size = size;
        this.oscAmplitude = size / 3;
        this.x = x;
        this.y = y;
        this.curve = curve;
        this.scrollRate = scrollRate;
        this.plotLineThickness = plotLineThickness;
        this.bars = bars;

        lastPlotPixel = size/2;

        screen = new Bitmap();
        screenData = new BitmapData(size, size, true,  0x00000000 );
        screen.bitmapData = screenData;

        // pre render the grid lines as a second image to be placed behind the dynamic plotter.
        screenGrid = new Bitmap();
        screenGridData = new BitmapData(size, size, true,   0x99000000);
        screenGrid.bitmapData = screenGridData;
        // draw the grids lines
        screenGrid.graphics.lineStyle(1, gridColor, 1, false, LineScaleMode.NONE);
        screenGrid.graphics.moveTo(Std.int(screenGrid.width), Std.int(screenGrid.height/2));
        screenGrid.graphics.lineTo(0, Std.int(screenGrid.height/2));
        screenGrid.graphics.moveTo(Std.int(screenGrid.width), Std.int((screenGrid.height/2) - oscAmplitude));
        screenGrid.graphics.lineTo(0, Std.int((screenGrid.width/2) - oscAmplitude) );
        screenGrid.graphics.moveTo(Std.int(screenGrid.width), Std.int((screenGrid.height/2) + oscAmplitude));
        screenGrid.graphics.lineTo(0, Std.int((screenGrid.width/2) + oscAmplitude) );

        // load the bg image

        var background = new Bitmap (Assets.getBitmapData("images/tv.png"));
        background.width = size + size/2;
        background.height = size + size/4;
        background.x = background.x-size/8;
        background.y = background.y-size/7;
        addChild(background);

        // add the grid and the plotter screen to the stage
        addChild(screenGrid);
        addChild(screen);

        var foreground = new Bitmap (Assets.getBitmapData("images/tv-cover.png"));
        foreground.width = size + size/2;
        foreground.height = size + size/4;
        foreground.x = foreground.x-size/8;
        foreground.y = foreground.y-size/7;
        addChild(foreground);

        Lib.stage.addEventListener (Event.ENTER_FRAME, this_onEnterFrame);
        addEventListener (MouseEvent.MOUSE_DOWN, this_onMouseDown);
    }

    private function this_onMouseDown (event:MouseEvent):Void {

        stage.addEventListener (MouseEvent.MOUSE_MOVE, stage_onMouseMove);
        stage.addEventListener (MouseEvent.MOUSE_UP, stage_onMouseUp);

        dragOffsetX = this.x - event.stageX;
        dragOffsetY = this.y - event.stageY;

    }


    private function stage_onMouseMove (event:MouseEvent):Void {

        //Actuate.tween (this, 0.4
        Actuate.tween (this, 0.4, { alpha: 1 });

        var targetX = event.stageX + dragOffsetX;
        var targetY = event.stageY + dragOffsetY;

        this.x = this.x + (targetX - this.x) * 0.5;
        this.y = this.y + (targetY - this.y) * 0.5;

    }


    private function stage_onMouseUp (event:MouseEvent):Void {

        stage.removeEventListener (MouseEvent.MOUSE_MOVE, stage_onMouseMove);
        stage.removeEventListener (MouseEvent.MOUSE_UP, stage_onMouseUp);

    }

    private function this_onEnterFrame (event:Event):Void
    {
        var delta = Lib.getTimer() - lastTick;
        lastTick = Lib.getTimer();
        update(delta);
        //updateScreen();

    }

    function update(delta:Float){
        lastSpeed = speed;
        speed = Std.int(scrollRate * delta);
        //trace("scrollRate: " + scrollRate +  " delta: " + delta + " speed: " + speed + " lastspeed: " + lastSpeed);

    }


    public function updateValue(value:Float):Void
    {
        //trace("updatevalue");
        lastOscValue = oscValue;
        oscValue = value;

        // clamping to -1.0 and 1.0;
        if ( value > 1.0 ) {
            trace("clamping");
            oscValue = 1.0;
        }

        if ( value < -1.0 ) {
            trace("clamping");
            oscValue = -1.0;
        }

        updateScreen();

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

        //speed = -1;
        if ( speed == 0) { speed = -1; }
        screenData.scroll(speed,0);
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
        //trace(screenData.width);
        var newPlotPoint = new Point(Std.int(screenData.width)+-size/10, Std.int(plotPixel));
        var lastPlotPoint = new Point(Std.int(screenData.width)+(speed+-size/10), Std.int(lastPlotPixel));
        lastPlotPixel = plotPixel;

        // clear the rightmost column with black pixels to cleanup corruption sometimes.
//        screen.graphics.lineStyle(1, 0x000000, 1, false, LineScaleMode.NONE);
//        screen.graphics.moveTo(Std.int(screenData.width)+-size/10-1, 0);
//        screen.graphics.lineTo(Std.int(screenData.width)+-size/10-1, screen.height);


        // put the pixel on the rightmost column at correct height
//        screenData.setPixel32(Std.int(newPlotPoint.x), Std.int(newPlotPoint.y), plotColor);
        //screenData.setPixel(Std.int(newPlotPoint.x), Std.int(newPlotPoint.y), plotColor);

        // draw center line
//        screen.graphics.lineStyle(0, gridColor, 0.1, true, LineScaleMode.NONE);
//        screen.graphics.moveTo(Std.int(screen.width), Std.int(screen.height/2));
//        screen.graphics.lineTo(0, Std.int(screen.height/2));
//
//        screen.graphics.moveTo(Std.int(screen.width), Std.int((screen.height/2) - oscAmplitude));
//        screen.graphics.lineTo(0, Std.int((size/2) - oscAmplitude) );
//
//        screen.graphics.moveTo(Std.int(screen.width), Std.int((screen.height/2) + oscAmplitude));
//        screen.graphics.lineTo(0, Std.int((size/2) + oscAmplitude) );

        //screenData.setPixel32(Std.int(this.width)-1, Std.int(this.height/2), gridColor);
//        screenData.setPixel32(Std.int(this.width)-1, Std.int((size/2) - oscAmplitude), gridColor);
//        screenData.setPixel32(Std.int(this.width)-1, Std.int((size/2) + oscAmplitude), gridColor);
        //screenData.setPixel32(Std.int(this.width)-1, Std.int(this.height/4), gridColor);

        // line between old point and new point

        if (joinDots) {

            var lineBmp:Bitmap = new Bitmap();
            lineBmp.bitmapData = new BitmapData(screenData.width, screenData.height, true, 0x00000000);
    //        lineBmp.graphics.lineStyle(plotLineThickness, lineColor, 1, true, LineScaleMode.NONE);

            lineBmp.graphics.moveTo(Std.int(lastPlotPoint.x), Std.int(lastPlotPoint.y));
    //


            if (curve == true) {
                lineBmp.graphics.lineStyle(plotLineThickness, lineColor, 1, false, LineScaleMode.NONE);
                //lineBmp.graphics.curveTo( Std.int(newPlotPoint.x), Std.int(lastPlotPoint.y), Std.int(lastPlotPoint.x), Std.int(lastPlotPoint.y));
                lineBmp.graphics.curveTo( Std.int(lastPlotPoint.x), Std.int(newPlotPoint.y), Std.int(newPlotPoint.x), Std.int(newPlotPoint.y));
            } else if (curve == false && bars == false) {
                lineBmp.graphics.lineStyle(plotLineThickness, lineColor, 1, false, LineScaleMode.NONE);
                lineBmp.graphics.lineTo(Std.int(newPlotPoint.x), Std.int(newPlotPoint.y));
            } else {
                lineBmp.graphics.lineStyle(-1*speed+1, lineColor, 1, false, LineScaleMode.NONE);
                lineBmp.graphics.lineTo(lastPlotPoint.x, Std.int(lineBmp.height/2));
            }

            //lineBmp.graphics.lineTo(Std.int(lastPlotPoint.x), Std.int(lastPlotPoint.y));

            // Draw the lineBmp onto this one
            screenData.draw(lineBmp);
            lineBmp.bitmapData.dispose();
            lineBmp.bitmapData = null;
            lineBmp = null;
        }

        screenData.setPixel32(Std.int(newPlotPoint.x), Std.int(newPlotPoint.y), plotColor);
        //screenGrid.bitmapData.copyPixels(screenData);
        //screenData.setPixels(new Rectangle(0,0))


    }

}