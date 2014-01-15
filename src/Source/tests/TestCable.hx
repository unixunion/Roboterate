package tests;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;


class TestCable extends FlxState
{


    override public function create():Void
    {
        // Set a background color
        FlxG.cameras.bgColor = 0xff131c1b;
        // Show the mouse (in case it hasn't been disabled)
        #if !FLX_NO_MOUSE
           FlxG.mouse.show();
        #end
        super.create();
    }

    /**
     * Function that is called when this state is destroyed - you might want to
     * consider setting all objects this state uses to null to help garbage collection.
     */
    override public function destroy():Void
    {
        super.destroy();
    }

    /**
     * Function that is called once every frame.
     */
    override public function update():Void
    {
        super.update();
    }
//
//    private var cable1:ui.SimpleCable;
//    private var cable2:ui.SimpleCable;
//
//    public static var gameController:util.DraggableGameObject = new DraggableGameObject();
//
//    public function new ()
//    {
//
//        super ();
//
//        Lib.current.stage.align = StageAlign.TOP_LEFT;
//        Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
//
//        addChild(gameController);
//
//
//        var vOsc1 = new ui.Osc1(50,50,120, false, -0.2);
//        addChild (vOsc1);
//        util.GameManager.entities.push(vOsc1);
//
//        var vOsc2 = new ui.Osc1(400,50,120, false, -0.2);
//        addChild (vOsc2);
//        util.GameManager.entities.push(vOsc2);
//
//        cable1 = new ui.SimpleCable();
//        trace("created cable1");
//        addChild(cable1);
//
//        cable2 = new ui.SimpleCable();
//        trace("created cable1");
//        addChild(cable2);
////        cable2 = new ui.Cable(vOsc1,vOsc2,5,50);
////        addChild(cable2);
//
//
//    }


}
