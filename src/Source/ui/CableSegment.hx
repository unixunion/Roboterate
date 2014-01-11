package ui;

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
    private var gameWorld:B2World;

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

        gameWorld = world;
        trace("got world: " + gameWorld);
        //sprite = image;
        spriteData = image.bitmapData.clone();
        sprite = new Bitmap();
        sprite.bitmapData = spriteData;
        sprite.width = thickness*4;
        sprite.height = thickness*4;
        //sprite = new Bitmap(Assets.getBitmapData("images/reddot.png"));
        //Lib.current.stage.addChild(sprite);
        initialize();
        construct();
    }

    private function initialize(){
//        sprite.x = -100;
//        sprite.y = -100;
        //sprite.x = x/util.GameWorld.PHYSICS_SCALER;
        //sprite.y = y/util.GameWorld.PHYSICS_SCALER;
        trace("init segment: x " + x + " y " + y);
        trace("calculated box X: " + (x * util.GameWorld.PHYSICS_SCALE) + " Y: " + ( y * util.GameWorld.PHYSICS_SCALE));
        trace("sprite x: " + sprite.x + " y " + sprite.y);
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
        fixtureDefinition.density=0;
        //fixtureDefinition.setAsBox ((segmentWidth / 2) * PHYSICS_SCALE, (segmentHeight / 2) * PHYSICS_SCALE);

        // add the body to the world
        body = util.GameWorld.World.createBody (bodyDefinition);
        body.createFixture (fixtureDefinition);

        // add the sprite

        body.setUserData(sprite);
        //sprite.addEventListener (MouseEvent.MOUSE_DOWN, this_onMouseDown);
        Lib.current.stage.addChild(sprite);
        //addChild(sprite);



    }

}