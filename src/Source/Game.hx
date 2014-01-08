// Game Class

import flash.display.Sprite;
import flash.events.Event;
import flash.display.Bitmap;
import openfl.Assets;
import flash.Lib;
import motion.easing.Quad;

enum GameState 
{
    Title;
    InGame;
    Paused;
    Gameover;
}

class Game extends Sprite
{
	

    private var Head:Bitmap;
    private var vOsc:ui.Osc;

    public function new ()
    {
            
	    super ();
	    initialize ();
	    construct ();

	    Lib.stage.addEventListener (Event.ENTER_FRAME, this_onEnterFrame);
	    
    }

    private function initialize():Void
    {
    	Head = new Bitmap (Assets.getBitmapData ("images/gamescene.png"));
    	//Head.width=200;
    	//Head.height=200;
    	Head.x = Lib.stage.stageWidth/2 - Head.width/2;
    	Head.y = Lib.stage.stageHeight/2 - Head.height/2;

    	vOsc = new ui.Osc(10,10,140);

    }

    private function construct():Void 
    {
    	addChild (Head);
    	addChild (vOsc);

    }

    private function this_onEnterFrame (event:Event):Void
    {
    	vOsc.updateValue(Std.random(5));
        //trace(Quad.easeOut(1,2));
    }

}