package tests;

// test only the osc

import flash.display.Bitmap;
import openfl.Assets;
import flash.Lib;
import flash.display.Sprite;
import flash.events.Event;

class TestOsc extends Sprite
{
    private var vOsc1:ui.Osc1;
    private var vOsc2:ui.Osc1;
    private var vOsc3:ui.Osc1;
    private var vOsc4:ui.Osc1;
    private var vOsc5:ui.Osc1;
    private var vOsc6:ui.Osc1;
    private var vOsc7:ui.Osc1;

    private var ipol:util.Interpolator;

    private var numLow:Float = -0.9;
    private var numHigh:Float = 0.9;
    private var num:Float = 0.0;
    private var inc:Float = 0.1;
    private var lastTick:Int = 0;

    public function new ()
    {

        super ();

//        var background = new Bitmap (Assets.getBitmapData("images/bg-cogs.png"));
//        addChild(background);

        vOsc1 = new ui.Osc1(10,10,200, false, -0.2);
        addChild (vOsc1);

        vOsc2 = new ui.Osc1(10,220,200, false, -0.05);
        addChild (vOsc2);

        vOsc3 = new ui.Osc1(220,10,200, false, -0.05);
        addChild (vOsc3);

        vOsc4 = new ui.Osc1(220,220,40, false, -0.05, 1);
        addChild (vOsc4);

        vOsc5 = new ui.Osc1(270,220,40, false, -0.05, 1);
        addChild (vOsc5);

        vOsc6 = new ui.Osc1(320,220,90, false, -0.05, 1, true);
        addChild (vOsc6);

        ipol = new util.Interpolator(-1.0, 1.0, 0.03);

        Lib.stage.addEventListener (Event.ENTER_FRAME, this_onEnterFrame);


    }


    private function this_onEnterFrame (event:Event):Void
    {
        var delta = Lib.getTimer() - lastTick;
        update(delta);
        lastTick = Lib.getTimer();

    }

    function update(delta:Float){
//        lastSpeed = speed;
//        speed = Std.int(scrollRate * delta);
//        trace("scrollRate: " + scrollRate +  " delta: " + delta + " speed: " + speed + " lastspeed: " + lastSpeed);

        vOsc1.updateValue(Math.random());
        vOsc2.updateValue(Math.random()*-1);

        if ( num <= numLow  ||  num >= numHigh ) {
            inc = inc * -1;
        }

        num = num + inc;
        vOsc3.updateValue(ipol.next());
        vOsc4.updateValue(ipol.next());
        vOsc5.updateValue(ipol.next());
        vOsc6.updateValue(ipol.next());

    }

}
