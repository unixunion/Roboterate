package tests;

import util.GameManager;
import flash.display.DisplayObject;
import flash.display.Bitmap;
import flash.display.StageScaleMode;
import flash.display.StageAlign;
import flash.Lib;
import flash.display.Sprite;
import openfl.Assets;

class TestCable extends Sprite
{

    private var cable1:ui.Cable;
    private var cable2:ui.Cable;
    public var gameWorld:util.GameWorld;

    public function new ()
    {

        super ();

        Lib.current.stage.align = StageAlign.TOP_LEFT;
        Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;

        gameWorld = new util.GameWorld();
        Lib.current.stage.addChild(gameWorld);


        var vOsc1 = new ui.Osc1(50,50,120, false, -0.2);
        addChild (vOsc1);
        util.GameManager.entities.push(vOsc1);


        var vOsc2 = new ui.Osc1(400,50,120, false, -0.2);
        addChild (vOsc2);
        util.GameManager.entities.push(vOsc2);

        cable1 = new ui.Cable(vOsc1,vOsc2,5,50);
        cable1.x = 100;
        cable1.y = 10;
        addChild(cable1);
        trace("cable1.x: " + cable1.x + " cable1.y: " + cable1.y);

//        cable2 = new ui.Cable(vOsc1,vOsc2,5,50);
//        addChild(cable2);


    }


}
