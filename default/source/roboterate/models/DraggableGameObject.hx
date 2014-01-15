package roboterate.models;

import roboterate.interfaces.IPowerInput;
import flixel.FlxState;
import flixel.util.FlxPoint;
import flixel.FlxG;
import flixel.addons.display.FlxExtendedSprite;
import flixel.FlxSprite;
import roboterate.controller.Register;
import flash.events.MouseEvent;
import flixel.addons.display.FlxExtendedSprite;



class DraggableGameObject extends FlxExtendedSprite {

    private var dragOffsetY:Float;
    private var dragOffsetX:Float;
    private var currentTarget:Dynamic;
    public var dragging:Bool = false;
    public var child:Array<FlxSprite>;

    public function new(X:Float, Y:Float) {
        super(X,Y);
        Register.entities.push(this);
        trace(Register.entities);
        this.enableMouseDrag(true, false, 128);
        mouseReleasedCallback = onRelease;
        this.child = new Array<FlxSprite>();
//        MouseEventManager.addSprite(this, onMouseDown, onMouseUp, onMouseOver, onMouseOut);
//        FlxG.stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, onMouseUp);

    }

    // draw another child sprite
    public function addChild(sprite:FlxSprite) {
        this.child.push(sprite);
        FlxG.state.add(sprite);
    }

    public override function update():Void {

        // TODO FIXME MOUSE DRAG OFFSET!

//        if (this.dragging) {
//            this.x = FlxG.mouse.screenX - this.width / 2;
//            this.y = FlxG.mouse.screenY - this.height / 2;
//        }


        super.update();
        for (child in this.child) {
            child.update();
            child.x = this.x;
            child.y = this.y;
        }

    }


//    public override function mouseStopDragCallback(obj:FlxExtendedSprite, x:Int, y:Int) : Dynamic  {
//        trace("Drop drag callback: " + this);
//
//    }

    public function onMouseDown (event:MouseEvent):Void {

        trace("mousedown " + event.target);
//        currentTarget = event.target;

        if (!exists || !visible || !active) {
            currentTarget = null;
            return;
        }


        if (overlapsPoint(new FlxPoint(FlxG.mouse.x, FlxG.mouse.y))) {
            this.dragging = true;
            currentTarget = event.target;
            FlxG.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
            FlxG.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
        }


//        if (currentTarget.disconnectable) {
//            trace("disconnecting");
//            currentTarget.unsocket();
//        }
//
//        stage.addEventListener (MouseEvent.MOUSE_MOVE, onMouseMove);
//        stage.addEventListener (MouseEvent.MOUSE_UP, onMouseUp);
//
//        dragOffsetX = event.target.x - event.stageX;
//        dragOffsetY = event.target.y - event.stageY;

    }


    public function onMouseMove (event:MouseEvent):Void {

        trace("mouseMove current:" + currentTarget + " event target: " + event.target);
//        Actuate.tween (currentTarget, 0.4, { alpha: 1 });
//
//        var targetX = event.stageX + dragOffsetX;
//        var targetY = event.stageY + dragOffsetY;
//
//        currentTarget.x = currentTarget.x + (targetX - currentTarget.x) * 0.5;
//        currentTarget.y = currentTarget.y + (targetY - currentTarget.y) * 0.5;

    }


    private function onMouseUp (event:MouseEvent):Void {

        trace("mouseUp current:" + currentTarget + " event target: " + currentTarget);

        if (!exists || !visible || !active || !FlxG.mouse.justReleased) {
            return;
        }

        this.dragging = false;
        FlxG.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
        FlxG.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
//
//        // hit testing for drop event
//        for (i in entities) {
//
//            if (i.hitTestPoint (event.stageX, event.stageY) && i != currentTarget ) {
//                if (i.connectable) {
//                    trace("Connecting to: " + i);
//                    Actuate.tween (currentTarget, 1, { x: i.x+i.width-i.width/4, y: i.y + i.height/4 } );
//                    i.socket(currentTarget);
//
//                } else {
//                    trace("target: " + i + " does not implement plugsocket");
//                }
//            }
//
//        }
//        currentTarget = null;
//
//        stage.removeEventListener (MouseEvent.MOUSE_MOVE, stage_onMouseMove);
//        stage.removeEventListener (MouseEvent.MOUSE_UP, stage_onMouseUp);

    }

    private function onRelease (obj:FlxExtendedSprite, x:Int, y:Int): Void {
        trace("mouse release: " + obj);
        for (target in Register.entities ) {
            if (FlxG.overlap(this, target) && Std.is(IPowerInput, target)) {
                if (target.plugged_object == null ) {
                    target.plugged_object=this;
                } else {
                    trace("Socket already occupied!");
                }
            }
        }
    }

    private function onMouseOut (sprite:FlxSprite): Void {
        trace("mouse out");
    }

}