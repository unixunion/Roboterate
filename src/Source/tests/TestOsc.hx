package tests;

// test only the osc

import flash.Lib;
import flash.display.Sprite;
import flash.events.Event;

class TestOsc extends Sprite
{
    private var vOsc1:ui.Osc1;
    private var vOsc2:ui.Osc1;

    public function new ()
    {

        super ();
        vOsc1 = new ui.Osc1(10,10,200);
        addChild (vOsc1);

        vOsc2 = new ui.Osc1(10,220,200);
        addChild (vOsc2);


        Lib.stage.addEventListener (Event.ENTER_FRAME, this_onEnterFrame);

    }

    private function this_onEnterFrame (event:Event):Void
    {
        vOsc1.updateValue(Math.random());
        vOsc2.updateValue(Math.random()*-1);
    }

}
