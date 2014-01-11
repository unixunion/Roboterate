package tests;

import flash.display.StageScaleMode;
import flash.display.StageAlign;
import flash.Lib;
import flash.display.Sprite;

class TestCable extends Sprite
{

    private var cable1:ui.Cable;

    public var gameWorld:util.GameWorld;

    public function new ()
    {

        super ();

        Lib.current.stage.align = StageAlign.TOP_LEFT;
        Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;

        gameWorld = new util.GameWorld();
        Lib.current.stage.addChild(gameWorld);

        cable1 = new ui.Cable(300,100,5,100);
        Lib.current.stage.addChild(cable1);

    }


}
