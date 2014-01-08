package;

import motion.Actuate;
import flash.display.Sprite;
import flash.events.Event;
import flash.display.Bitmap;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;
import openfl.Assets;


class Main extends Sprite 
{
	
	private var background:Bitmap;
    private var logo:Bitmap;
    private var splashSound:Sound;
    private var soundChannel:SoundChannel;
    private var soundPosition:Float = 0;
    private var playing:Bool;

	public function new ()
	{
		super();
		initialize();
		construct();

		resize (stage.stageWidth, stage.stageHeight);	// resize window
        stage.addEventListener (Event.RESIZE, stage_onResize);	// resize event listener

		
		
	}

	private function initialize()
	{
		// load up some assets
		trace("initialize");
        logo = new Bitmap (Assets.getBitmapData("images/logo.png"));
        splashSound = Assets.getSound ("clang");
        addChild(logo);
        //play();
		background = new Bitmap (Assets.getBitmapData("images/bg-cogs.png"));
	}

    private function construct()
    {
        trace("Constructing");
        removeChild(logo);
        addChild (background);
        addChild(new ui.Menu1());
    }

	private function resize (newWidth:Int, newHeight:Int):Void
	{
        trace("resize");
	    background.width = newWidth;
	    background.height = newHeight;

	    //Game.resize (newWidth, newHeight);
                
    }

    private function stage_onResize (event:Event):Void 
    {   
    	trace("stage resizing");
        resize (stage.stageWidth, stage.stageHeight);   
    }

    private function play (fadeIn:Float = 3):Void
    {
        trace("Playing sound");
        playing = true;

//        if (fadeIn <= 0) {

            soundChannel = splashSound.play (soundPosition);

//        } else {

//            soundChannel = splashSound.play (soundPosition, new SoundTransform (0, 0));
//            Actuate.transform(soundChannel, fadeIn).sound (1,0);
//
//        }

        soundChannel.addEventListener (Event.SOUND_COMPLETE, channel_onSoundComplete);
    }

    private function channel_onSoundComplete (event:Event):Void {
        trace("sound completed");
        playing = false;
        soundPosition = 0;

    }


}