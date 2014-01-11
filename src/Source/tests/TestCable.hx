package tests;

import box2D.dynamics.B2Body;
import flash.display.Bitmap;
import box2D.dynamics.B2FixtureDef;
import box2D.collision.shapes.B2PolygonShape;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2DebugDraw;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2World;
import flash.display.StageScaleMode;
import flash.display.StageAlign;
import flash.Lib;
import flash.display.Sprite;
import openfl.Assets;


class TestCable extends Sprite
{

    private var cable1:ui.Cable;

    public var gameWorld:util.GameWorld;
//
//    public static var PHYSICS_SCALE:Float = 1 / 30;
//    public static var PHYSICS_SCALER:Float = 30;
//    public var World:B2World;
//    private var PhysicsDebug:Sprite;

    public function new ()
    {

        super ();

        Lib.current.stage.align = StageAlign.TOP_LEFT;
        Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;

        gameWorld = new util.GameWorld();
        addChild(gameWorld);
//        World = new B2World (new B2Vec2 (0.1, 1), true);
//
//        PhysicsDebug = new Sprite ();
//        addChild(PhysicsDebug);
//
//        var debugDraw = new B2DebugDraw ();
//        debugDraw.setSprite (PhysicsDebug);
//        debugDraw.setDrawScale (1 / PHYSICS_SCALE);
//        debugDraw.setFlags (B2DebugDraw.e_shapeBit);
//        World.setDebugDraw (debugDraw);

        cable1 = new ui.Cable(300,100);
        addChild(cable1);

//        createBox(80,400,100,20,false);

    }

//    private function createBox (x:Float, y:Float, width:Float, height:Float, dynamicBody:Bool):Void {
//
//        var bodyDefinition = new B2BodyDef ();
//        bodyDefinition.position.set (x * PHYSICS_SCALE, y * PHYSICS_SCALE);
//
//        if (dynamicBody) {
//            bodyDefinition.type = B2Body.b2_dynamicBody;
//        }
//
//        var polygon = new B2PolygonShape ();
//        polygon.setAsBox ((width / 2) * PHYSICS_SCALE, (height / 2) * PHYSICS_SCALE);
//
//        var fixtureDefinition = new B2FixtureDef ();
//        fixtureDefinition.shape = polygon;
//
//        var body = World.createBody (bodyDefinition);
//        body.createFixture (fixtureDefinition);
//        var segmentBmp = new Bitmap (Assets.getBitmapData("images/reddot.png"));
//        segmentBmp.width = 100;
//        body.setUserData(segmentBmp);
//        addChild(segmentBmp);
//
//        body.getUserData().x = body.getPosition().x * PHYSICS_SCALER;
//        body.getUserData().y = body.getPosition().y * PHYSICS_SCALER;
//        body.getUserData().rotation = body.getAngle();
//
//    }

}
