package tests;

// test only the osc

import flash.Lib;
import flash.display.Sprite;
import flash.events.Event;

class TestOsc extends Sprite
{
    private var vOsc1:ui.Osc1;
    private var vOsc2:ui.Osc1;
    private var vOsc3:ui.Osc1;
    private var ipol:util.Interpolator;

    private var numLow:Float = -0.9;
    private var numHigh:Float = 0.9;
    private var num:Float = 0.0;
    private var inc:Float = 0.1;

    public function new ()
    {

        super ();
        vOsc1 = new ui.Osc1(10,10,200);
        addChild (vOsc1);

        vOsc2 = new ui.Osc1(10,220,200);
        addChild (vOsc2);

        vOsc3 = new ui.Osc1(220,10,200, false, -1);
        addChild (vOsc3);

        ipol = new util.Interpolator(-1.0, 1.0, 0.1);

        Lib.stage.addEventListener (Event.ENTER_FRAME, this_onEnterFrame);

    }

    private function this_onEnterFrame (event:Event):Void
    {



        vOsc1.updateValue(Math.random());
        vOsc2.updateValue(Math.random()*-1);

        if ( num <= numLow  ||  num >= numHigh ) {
            inc = inc * -1;
        }

        num = num + inc;
        vOsc3.updateValue(ipol.next());



    }

}
