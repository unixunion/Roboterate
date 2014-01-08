package tests;

// test only the osc

import flash.Lib;
import flash.display.Sprite;
import flash.events.Event;

class TestOsc extends Sprite
{
    private var vOsc:ui.Osc1;

    public function new ()
    {

        super ();
        vOsc = new ui.Osc1(10,10,140);
        addChild (vOsc);
        Lib.stage.addEventListener (Event.ENTER_FRAME, this_onEnterFrame);

    }

    private function this_onEnterFrame (event:Event):Void
    {
        vOsc.updateValue(Std.random(15));
    }

}
