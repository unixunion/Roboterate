package util;

// manage drag and drop events.
import flash.display.DisplayObject;
import util.GameManager;
import motion.Actuate;
import flash.events.MouseEvent;
import flash.Lib;
import flash.display.Sprite;


class DraggableGameObject extends Sprite {

    private var dragOffsetY:Float;
    private var dragOffsetX:Float;
    private var currentTarget:Dynamic;

    public static var entities:Array<Dynamic> = new Array<Dynamic>();

    public function new() {
        super();
        // add to entities
        entities.push(this);
        trace(entities);
    }


    public function this_onMouseDown (event:MouseEvent):Void {

        trace("mousedown " + event.target);
        currentTarget = event.target;

        if (currentTarget.disconnectable) {
            trace("disconnecting");
            currentTarget.unsocket();
        }

        stage.addEventListener (MouseEvent.MOUSE_MOVE, stage_onMouseMove);
        stage.addEventListener (MouseEvent.MOUSE_UP, stage_onMouseUp);

        dragOffsetX = event.target.x - event.stageX;
        dragOffsetY = event.target.y - event.stageY;

    }


    public function stage_onMouseMove (event:MouseEvent):Void {

        trace("mouseMove current:" + currentTarget + " event target: " + event.target);
        Actuate.tween (currentTarget, 0.4, { alpha: 1 });

        var targetX = event.stageX + dragOffsetX;
        var targetY = event.stageY + dragOffsetY;

        currentTarget.x = currentTarget.x + (targetX - currentTarget.x) * 0.5;
        currentTarget.y = currentTarget.y + (targetY - currentTarget.y) * 0.5;

    }


    private function stage_onMouseUp (event:MouseEvent):Void {
        trace("mouseUp current:" + currentTarget + " event target: " + event.target);

        // hit testing for drop event
        for (i in entities) {

            if (i.hitTestPoint (event.stageX, event.stageY) && i != currentTarget ) {
                if (i.connectable) {
                    trace("Connecting to: " + i);
                    Actuate.tween (currentTarget, 1, { x: i.x+i.width-i.width/4, y: i.y + i.height/4 } );
                    i.socket(currentTarget);

                } else {
                    trace("target: " + i + " does not implement plugsocket");
                }
            }

        }
        currentTarget = null;

        stage.removeEventListener (MouseEvent.MOUSE_MOVE, stage_onMouseMove);
        stage.removeEventListener (MouseEvent.MOUSE_UP, stage_onMouseUp);

    }

}