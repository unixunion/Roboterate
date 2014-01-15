package ui;

import util.DraggableGameObject;
import tests.TestCable;
import tests.TestCable;
import util.GameManager;
import motion.Actuate;
import flash.events.MouseEvent;
import flash.Lib;
import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.Sprite;
import openfl.Assets;


// a simple class which has two draggable endpoint graphics, linked with a bezier curve.
// when dragged over a game object it must link and register with that object and ferry
// data between connected points.

class SimpleCable extends DraggableGameObject {

    // need to notify the other end of this connection of the impending demise somehow...
    public function disconnect() {
        trace("Disconnect");
    }
    public var disconnectable:Bool = true;

    // thickness of the lineStyle
    private var thickness : Float;

    // points / objects we will plug into
    private var point1 : DisplayObject;
    private var point2 : DisplayObject;

    // image for the draggable ends
    private var plug1 : ui.Plug;
    private var plug2 : ui.Plug;


    public function new( ?thickness : Float = 5.0, ?point1 : DisplayObject = null, ?point2 : DisplayObject = null ) {
        super();

        this.thickness = thickness;
        this.point1 = point1;
        this.point2 = point2;

        initialize();
        construct();
    }


    private function initialize() {
        trace("initialize");
        this.plug1 = new Plug();
        this.plug2 = new Plug();
    }


    private function construct() {
        trace("construct");
        Lib.current.stage.addChild(this.plug1);
        //Lib.current.stage.addChild(this.plug2);
        plug1.addEventListener (MouseEvent.MOUSE_DOWN, this_onMouseDown);
        //plug2.addEventListener (MouseEvent.MOUSE_DOWN, this_onMouseDown);
    }


//    private function this_onMouseDown (event:MouseEvent):Void {
//
//        trace("mousedown " + event.target);
//
//        stage.addEventListener (MouseEvent.MOUSE_MOVE, stage_onMouseMove);
//        stage.addEventListener (MouseEvent.MOUSE_UP, stage_onMouseUp);
//
//        dragOffsetX = event.target.x - event.stageX;
//        dragOffsetY = event.target.y - event.stageY;
//
//    }
//
//
//    private function stage_onMouseMove (event:MouseEvent):Void {
//
//
//        Actuate.tween (event.target, 0.4, { alpha: 1 });
//
//        var targetX = event.stageX + dragOffsetX;
//        var targetY = event.stageY + dragOffsetY;
//
//        event.target.x = event.target.x + (targetX - event.target.x) * 0.5;
//        event.target.y = event.target.y + (targetY - event.target.y) * 0.5;
//
//    }
//
//
//    private function stage_onMouseUp (event:MouseEvent):Void {
//
//// hit testing for drop event
//        for (i in util.GameManager.entities) {
//
//            if (i.hitTestPoint (event.stageX, event.stageY)) {
//                trace("Connect to: " + i);
//                Actuate.tween (this, 1, { x: i.x+i.width-i.width/4, y: i.y + i.height/4 } );
//            }
//
//        }
//
//        stage.removeEventListener (MouseEvent.MOUSE_MOVE, stage_onMouseMove);
//        stage.removeEventListener (MouseEvent.MOUSE_UP, stage_onMouseUp);
//
//    }

}