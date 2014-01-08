package ui;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import flash.display.LineScaleMode;

// oscilloscope

class Osc extends Sprite
{
	private static var bgColor:Int = 0x000000;
    private var size:Int;
    private var tx:Int;

    // place to store size on creation, since sprite writes seem to increase this over time.
    private var oscWidth:Float;
    private var oscHeight:Float;

    private var lastX:Int;
    private var lastY:Int;
    private var oscX:Int;
    private var oscValue:Int = 1;


	public function new(x:Int, y:Int, size:Int)
	{
		trace("new");
        super();
        this.size = size;
        this.x = x;
        this.y = y;
        draw();
        
        this.oscHeight = this.height;
        this.oscWidth = this.width;
        this.oscX = x;
        this.tx = x;

        Lib.stage.addEventListener (Event.ENTER_FRAME, this_onEnterFrame);
    }

    private function draw():Void
    {
    	trace("drawing");
        graphics.beginFill(bgColor);
        graphics.drawRect(x, y, size, size);
        graphics.endFill();
    }

    private function this_onEnterFrame (event:Event):Void
    {
    	
    	graphics.lineStyle(2, 0xff0000, .2, false, LineScaleMode.NONE);
    	graphics.beginFill(0xff0000, .1);
    	
        var ty = this.oscValue; //Std.random(40);

    	trace("updating osc tx: " + tx + " ty: " + ty + " width: " + this.width);

    	tx = tx + 2;
    	if (tx > this.oscWidth) 
    	{ 
    		tx=this.oscX;
    		draw();
    	}

    	//ty = this.y + this.oscHeight/2 - ty;

    	// graphics.moveTo(this.lastX, this.lastY);
    	// graphics.lineTo(tx,ty);

    	//this.lastX = tx;
    	//this.lastY = this.y + this.oscHeight/2 - ty;

    	graphics.moveTo(tx,this.y + this.oscHeight/2 - ty-1);
    	graphics.lineTo(tx,this.y + this.oscHeight/2 - ty);

    }

    public function updateValue(value:Int):Void
    {
    	this.oscValue = value;
    }

}