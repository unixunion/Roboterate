package ui;

import util.GameManager;
import flash.Lib;
import tests.TestCable;
import flash.display.BitmapData;
import util.GameWorld;
import motion.Actuate;
import flash.events.MouseEvent;
import flash.display.Bitmap;
import flash.display.Sprite;
import box2D.collision.shapes.B2CircleShape;
import box2D.collision.shapes.B2PolygonShape;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2DebugDraw;
import box2D.dynamics.B2FixtureDef;
import box2D.dynamics.joints.B2DistanceJoint;
import box2D.dynamics.joints.B2DistanceJointDef;
import box2D.dynamics.B2World;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import openfl.Assets;

// individual cable segments
class CableSegment extends Sprite {

    private var dragOffsetY:Float;
    private var dragOffsetX:Float;

    private var PhysicsDebug:Sprite;
    private var World:B2World;

    private static var segmentWidth:Int = 4;
    private static var segmentHeight:Int = 20;
    private var thickness:Int;
    private var linearDamping:Float;

    public var body:B2Body; // out publically accessable part
    public var spriteData:BitmapData;
    public var sprite:Bitmap;
    private var moveListener:Bool;

    public function new(x:Float, y:Float, world:B2World, image:Bitmap, ?thickness:Int=15, ?linearDamping:Float=12.0, ?moveListener:Bool=false) {
        super();
        this.x = x;
        this.y = y;
        this.thickness = thickness;
        this.linearDamping = linearDamping;
        this.moveListener = moveListener;

        this.World = world;
        //trace("got world: " + World);
        //sprite = image;
        spriteData = image.bitmapData.clone();
        sprite = new Bitmap();
        sprite.graphics.beginFill(0x000000, 1);
        sprite.graphics.drawCircle(sprite.x/2,sprite.y/2,thickness);

        trace("x: " + x + " y: " + y);
        trace("sprite.x: " + sprite.x + " sprite.y: " + sprite.y);


//sprite.bitmapData = spriteData;
//        sprite.width = thickness*4;
//        sprite.height = thickness*4;
        //sprite = new Bitmap(Assets.getBitmapData("images/reddot.png"));
        //Lib.current.stage.addChild(sprite);
        //buttonMode = true;
        //sprite.addEventListener (MouseEvent.MOUSE_DOWN, this_onMouseDown);
        initialize();
        construct();
    }

    private function initialize(){
//        sprite.x = -100;
//        sprite.y = -100;
        //sprite.x = x/util.GameWorld.PHYSICS_SCALER;
        //sprite.y = y/util.GameWorld.PHYSICS_SCALER;
        trace("x: " + x + " y: " + y);
        trace("this.x: " + x + "this.y: " + y);
        trace("sprite.x: " + x + " sprite.y: " + y);

//        trace("calculated box X: " + (x * util.GameWorld.PHYSICS_SCALE) + " Y: " + ( y * util.GameWorld.PHYSICS_SCALE));
//        trace("sprite x: " + sprite.x + " y " + sprite.y);
        // load assets
//        sprite = new Bitmap(Assets.getBitmapData("images/reddot.png"));
//        addChild(sprite);


    }

    private function construct() {

        var bodyDefinition = new B2BodyDef ();
        bodyDefinition.type = B2Body.b2_dynamicBody;
        bodyDefinition.position.set (x * util.GameWorld.PHYSICS_SCALE, y * util.GameWorld.PHYSICS_SCALE );
        bodyDefinition.angularDamping = 1;
        bodyDefinition.linearDamping = this.linearDamping;

        // create the poly
//        var polygon = new B2PolygonShape ();
//        polygon.setAsBox ((segmentWidth / 2) * util.GameWorld.PHYSICS_SCALE, (segmentHeight / 2) * util.GameWorld.PHYSICS_SCALE);

        var circle = new B2CircleShape (this.thickness * util.GameWorld.PHYSICS_SCALE);

        //circle.m_p.set(x * util.GameWorld.PHYSICS_SCALE, y * util.GameWorld.PHYSICS_SCALE);

        // create the fixture
        var fixtureDefinition = new B2FixtureDef ();
        fixtureDefinition.shape = circle;
        //fixtureDefinition.density=0;
        //fixtureDefinition.setAsBox ((segmentWidth / 2) * PHYSICS_SCALE, (segmentHeight / 2) * PHYSICS_SCALE);

        // add the body to the world
        body = util.GameWorld.World.createBody (bodyDefinition);
        body.createFixture (fixtureDefinition);

        // add the sprite

        body.setUserData(sprite);

//        Lib.current.stage.addChild(sprite);
        addChild(sprite);
        addEventListener (MouseEvent.MOUSE_DOWN, this_onMouseDown);
        addEventListener (Event.ENTER_FRAME, this_onEnterFrame);

    }

    private function this_onMouseDown (event:MouseEvent):Void {

        trace("mousedown " + event.target);

        stage.addEventListener (MouseEvent.MOUSE_MOVE, stage_onMouseMove);
        stage.addEventListener (MouseEvent.MOUSE_UP, stage_onMouseUp);

        dragOffsetX = event.target.x - event.stageX;
        dragOffsetY = event.target.y - event.stageY;

    }


    private function stage_onMouseMove (event:MouseEvent):Void {

        Actuate.tween (this, 0.4, { alpha: 1 });

        var targetX = event.stageX + dragOffsetX;
        var targetY = event.stageY + dragOffsetY;

        this.x = this.x + (targetX - this.x) * 0.5;
        this.y = this.y + (targetY - this.y) * 0.5;

    }


    private function stage_onMouseUp (event:MouseEvent):Void {

// hit testing for drop event
        for (i in util.GameManager.entities) {

            if (i.hitTestPoint (event.stageX, event.stageY)) {
                trace("Connect to: " + i);
                Actuate.tween (this, 1, { x: i.x+i.width-i.width/4, y: i.y + i.height/4 } );
            }

        }

        stage.removeEventListener (MouseEvent.MOUSE_MOVE, stage_onMouseMove);
        stage.removeEventListener (MouseEvent.MOUSE_UP, stage_onMouseUp);

    }


    private function this_onEnterFrame (event:Event):Void {

//        trace("x: " + x + " y: " + y);
//        trace("this.x: " + x + "this.y: " + y);
//        trace("sprite.x: " + x + " sprite.y: " + y);
//        this.World.step (1 / 30, 10, 10);
//        this.World.clearForces ();
//        this.World.drawDebugData ();
//
//            var myBody = this.body;
//
//            if(myBody.getUserData() != null && Std.is(cast(myBody.getUserData(), Bitmap), Bitmap))
//            {
//                trace("sprite x: " + myBody.getUserData().x + " body x: " + myBody.getPosition().x );
//                myBody.getUserData().x = myBody.getPosition().x * util.GameWorld.PHYSICS_SCALER;
//                myBody.getUserData().y = myBody.getPosition().y * util.GameWorld.PHYSICS_SCALER;
//                myBody.getUserData().rotation = myBody.getAngle();
//
//
//            }

    }

}