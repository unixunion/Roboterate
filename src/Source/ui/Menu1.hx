package ui;

import flash.Lib;
import flash.events.MouseEvent;
import flash.events.Event;
import flash.display.DisplayObject;
import flash.display.IGraphicsData;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.display.GradientType;
import flash.display.Sprite;
import flash.display.StageDisplayState;
import flash.geom.Matrix;
import flash.text.TextField;
import flash.text.TextFormatAlign;
import flash.text.Font;
import flash.text.TextFormat;
import flash.display.DisplayObject;
import flash.display.Shape;
import flash.display.SimpleButton;

class CustomSimpleButton extends SimpleButton {
    private static var upColor:Int   = 0xFFCC00;
    private static var overColor:Int = 0xCCFF00;
    private static var downColor:Int = 0x00CCFF;
    private static var size:Int      = 80;

    public function new(x:Int, y:Int) {
        super();
        trace("X: " + x + " Y: " + y);
        downState      = new ButtonDisplayState(x,y,downColor, size);
        overState      = new ButtonDisplayState(x,y,overColor, size);
        upState        = new ButtonDisplayState(x,y,upColor, size);
        hitTestState   = new ButtonDisplayState(x,y,upColor, size);
        // hitTestState.x = -(size / 4);
        // hitTestState.y = hitTestState.x;
        useHandCursor  = true;
    }



}

class ButtonDisplayState extends Shape {
    private var bgColor:Int;
    private var size:Int;

    public function new(x:Int, y:Int, bgColor:Int, size:Int) {
        super();
        this.bgColor = bgColor;
        this.size    = size;
        this.x = x;
        this.y = y;
        draw();
    }

    private function draw():Void {
        graphics.beginFill(bgColor);
        trace(x);
        graphics.drawRect(x, y, size, size);
        graphics.endFill();
    }
}

class Menu1 extends Sprite
{
    public var but:CustomSimpleButton;

	public function new()
	{
	   super();
	   Lib.current.addChild(this);

	   but = new CustomSimpleButton(100,100);
	   but.addEventListener(MouseEvent.MOUSE_DOWN,onButtonDown,false,100);
	   Lib.current.stage.addEventListener(MouseEvent.MOUSE_DOWN,onStageDown);
	   
	   addChild(but);
	}

	private function onStageDown(e:MouseEvent):Void
	{
	        trace("stage received down event.");
	}

	private function onButtonDown(e:MouseEvent):Void
	{
	        trace("button received down event: should cancel stage.");
	        e.stopPropagation();
	        e.stopImmediatePropagation();
            removeChild(but);
            addChild(new Game());

	}

}