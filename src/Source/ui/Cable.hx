package ui;


// a physics cable, hopefully.
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



class Cable extends Sprite {

    private var dragOffsetY:Float;
    private var dragOffsetX:Float;

    private var segmentBmp:Bitmap;
    private var segments:Array<CableSegment>;
    private var World:B2World;

    // cable defaults
    private var length:Int = 5;

    public function new (x:Int, y:Int) {

        super ();
//        this.x = x;
//        this.y = y;
        this.World = util.GameWorld.World;
        trace("got world: " + World);

        initialize();
        construct();


        //GameWorld = new B2World (new B2Vec2 (0, 0), true);

//        PhysicsDebug = new Sprite ();
//        addChild (PhysicsDebug);
//
//        var debugDraw = new B2DebugDraw ();
//        debugDraw.setSprite (PhysicsDebug);
//        debugDraw.setDrawScale (1 / PHYSICS_SCALE);
//        debugDraw.setFlags (B2DebugDraw.e_shapeBit);
//
//        GameWorld.setDebugDraw (debugDraw);


        //createCable(600,10,15);

        addEventListener (Event.ENTER_FRAME, this_onEnterFrame);

    }

    private function initialize() {
        // the bmp we will clone for cable links
        segmentBmp = new Bitmap (Assets.getBitmapData("images/reddot.png"));
    }

    private function construct() {
        segments = new Array<CableSegment>();
        for( i in 0...length ) {
            var cable = new CableSegment(this.x + (4*i), this.y + (25*i), this.World, segmentBmp);
            segments.push(cable);
            addChild(cable);

//            var spriteData:BitmapData = segmentBmp.bitmapData.clone();
//            var sprite:Bitmap = new Bitmap();
//            sprite.bitmapData = spriteData;
//            sprite.x = this.x;
//            sprite.y = this.y + (25*i);

           // addChild(sprite);
            //cable.body.setUserData(segmentBmp);

        }

        trace(segments);

        for (i in 1...segments.length) {
            trace("joining " + segments[i-1].body + " and " + segments[i].body + " center " + segments[i-1].body.getWorldCenter());
            var joint = new B2DistanceJointDef();
            joint.initialize(segments[i-1].body, segments[i].body, new B2Vec2(0,0), new B2Vec2(0,0));
            joint.collideConnected = true;
            trace(joint);
        }


    }

//    private function createCable (x:Float, y:Float, ?length:Int=5, ?segmentWidth:Int=4, ?segmentHeight:Int=20) {
//        // create a bunch of polygon shapes and tie them together to get some rope like thing working.
//        segments = new Array<B2Body>();
//
//
//
//        for( i in 0...length ) {
//            // create the bodyDef
//
//            var bodyDefinition = new B2BodyDef ();
//            bodyDefinition.type = B2Body.b2_dynamicBody;
//            bodyDefinition.position.set (x * PHYSICS_SCALE, (i * y * PHYSICS_SCALE ));
//
//            // create the poly
//            var polygon = new B2PolygonShape ();
//            polygon.setAsBox ((segmentWidth / 2) * PHYSICS_SCALE, (segmentHeight / 2) * PHYSICS_SCALE);
//
//            // create the fixture
//            var fixtureDefinition = new B2FixtureDef ();
//            fixtureDefinition.shape = polygon;
//            //fixtureDefinition.setAsBox ((segmentWidth / 2) * PHYSICS_SCALE, (segmentHeight / 2) * PHYSICS_SCALE);
//
//            // add the body to the world
//            var body = gameWorld.World.createBody (bodyDefinition);
//            body.createFixture (fixtureDefinition);
//
//            var l:Int = segments.push(body);
//            trace(i + ": inserted at pos: " + l);
//
//            if (i>0) {
//                // make joints
//                var joint = new B2DistanceJointDef();
//                joint.initialize(segments[i-1], segments[i], new B2Vec2(0,0), new B2Vec2(0,0));
//                joint.collideConnected = true;
//                trace(joint);
//            }
//
//        }
//
//        for (i in segments.iterator() )
//        {
//            //trace(segments[1].getJointList());
//            cableSegment = new Bitmap (Assets.getBitmapData("images/reddot.png"));
//            addChild(cableSegment);
//            i.setUserData(cableSegment);
//            cableSegment.addEventListener (MouseEvent.MOUSE_DOWN, this_onMouseDown);
//        }
//
//        //trace(segments[1].m_jointList);
//
//    }


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

        stage.removeEventListener (MouseEvent.MOUSE_MOVE, stage_onMouseMove);
        stage.removeEventListener (MouseEvent.MOUSE_UP, stage_onMouseUp);

    }

    // Event Handlers


    private function this_onEnterFrame (event:Event):Void {

        this.World.step (1 / 30, 10, 10);
        this.World.clearForces ();
        this.World.drawDebugData ();

        //b2BodyElements is my array of bodies
        for (myBody in segments.iterator())
        {
        //If the body has an attached Sprite
            //trace(cast(myBody.getUserData(), Bitmap));
            if(myBody.body.getUserData() != null && Std.is(cast(myBody.body.getUserData(), Bitmap), Bitmap))
            {
                //Sets the x, y, and rotation of the sprite

                myBody.body.getUserData().x = myBody.body.getPosition().x * util.GameWorld.PHYSICS_SCALER;
                myBody.body.getUserData().y = myBody.body.getPosition().y * util.GameWorld.PHYSICS_SCALER;
                myBody.body.getUserData().rotation = myBody.body.getAngle();

                //trace("myBody.getUserData().x " + myBody.body.getUserData().x + " bodypos: " + myBody.body.getPosition().x * gameGameWorld.PHYSICS_SCALER);
                //trace("myBody.getUserData().y " + myBody.body.getUserData().y + " bodypos: " + myBody.body.getPosition().y * util.GameWorld.PHYSICS_SCALER);

            }
        }

    }


}