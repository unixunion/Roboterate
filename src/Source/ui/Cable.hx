package ui;


// a physics cable, hopefully.
import box2D.dynamics.joints.B2PulleyJointDef;
import box2D.dynamics.joints.B2RevoluteJointDef;
import box2D.common.math.B2Transform;
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



class Cable extends Sprite {

    private var dragOffsetY:Float;
    private var dragOffsetX:Float;

    private var segmentBmp:Bitmap;
    private var plugBmp1:Bitmap;
    private var plugBmp2:Bitmap;
    private var segments:Array<CableSegment>;
    private var World:B2World;

    // cable defaults
    private var length:Int;
    private var thickness:Int;

    public function new (x:Int, y:Int, ?thickness:Int=5, ?length:Int=10) {

        super ();
        this.x=x;
        this.y=y;

        this.World = util.GameWorld.World;
        trace("got world: " + World);

        this.thickness = thickness;
        this.length = length;

        initialize();
        construct();


        addEventListener (Event.ENTER_FRAME, this_onEnterFrame);


    }

    private function initialize() {
        // the bmp we will clone for cable links
        segmentBmp = new Bitmap (Assets.getBitmapData("images/reddot.png"));
        plugBmp1 = new Bitmap (Assets.getBitmapData("images/plug.png"));
        plugBmp1.width=15;
        plugBmp1.height=15;
        addChild(plugBmp1);
        addEventListener (MouseEvent.MOUSE_DOWN, this_onMouseDown);
    }

    private function construct() {
        segments = new Array<CableSegment>();
        var cable = new CableSegment(this.x, this.y  + (this.thickness), this.World, segmentBmp, this.thickness, 1.0, true);
        addChild(cable);
        segments.push(cable);

        var lastSegment:CableSegment = cable;
        trace("lastSegment: " +lastSegment);


        // rest of cable
        for( i in 1...this.length+1 ) {
            var cable = new CableSegment(this.x, this.y  + (this.thickness * i), this.World, segmentBmp, this.thickness, 1);
            segments.push(cable);
            Lib.current.stage.addChild(cable);
            createJoint(lastSegment.body, cable.body);
            lastSegment = cable;
//            trace(this.World.getJointList());
        }

        var cable = new CableSegment(this.x, this.y  + (this.thickness * this.length+1), this.World, segmentBmp, this.thickness, 12.0);
        addChild(cable);
        segments.push(cable);
        createJoint(lastSegment.body, cable.body);


        trace(segments);

//        for (i in 1...segments.length) {
//            trace("joining " + segments[i-1].body + " and " + segments[i].body + " center " + segments[i-1].body.getWorldCenter());
//            var joint = new B2DistanceJointDef();
//            joint.initialize(segments[i-1].body, segments[i].body, new B2Vec2(0,0), new B2Vec2(0,0));
//            joint.collideConnected = false;
//            trace(joint);
//        }



    }

    private function createJoint(bodyA:B2Body, bodyB:B2Body ) {
        trace("joining " + bodyA + " and " + bodyB);
        var joint = new B2DistanceJointDef();
//            joint.frequencyHz = 15.0;
//            joint.dampingRatio = 1.0;
        joint.initialize(bodyA, bodyB, new B2Vec2(0,-1), new B2Vec2(0,1));
        joint.collideConnected = false;
        var joint = new B2RevoluteJointDef();
        joint.initialize(bodyA, bodyB, new B2Vec2(0,0));

//        joint.lowerAngle = -2 * 3.14159265359; // -180 degrees
//        joint.upperAngle = 2 * 3.14159265359; // 180 degrees
        joint.enableLimit = false;
        this.World.createJoint(joint);
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

        stage.removeEventListener (MouseEvent.MOUSE_MOVE, stage_onMouseMove);
        stage.removeEventListener (MouseEvent.MOUSE_UP, stage_onMouseUp);

    }

    // Event Handlers


    private function this_onEnterFrame (event:Event):Void {

        this.World.step (1 / 30, 10, 10);
        this.World.clearForces ();
        this.World.drawDebugData ();

        var pforce = 128;
        segments[0].body.applyForce(new B2Vec2( (this.x - (segments[0].body.getPosition().x * util.GameWorld.PHYSICS_SCALER)) * pforce , (this.y + this.height - (segments[0].body.getPosition().y * util.GameWorld.PHYSICS_SCALER))*pforce), new B2Vec2(0,0));


        //b2BodyElements is my array of bodies
        for (i in 0...segments.length )
        {

            var myBody = segments[i];

//            This makes the body follow the parent body in the chain, though poorly.
//            if (i>1) {
//                var pforce = 1;
//                var x1 = segments[i-1].body.getPosition().x * util.GameWorld.PHYSICS_SCALER;
//                var y1 = segments[i-1].body.getPosition().y * util.GameWorld.PHYSICS_SCALER;
//
//                var x2 = segments[i].body.getPosition().x * util.GameWorld.PHYSICS_SCALER;
//                var y2 = segments[i].body.getPosition().y * util.GameWorld.PHYSICS_SCALER;
//
//                segments[i].body.applyForce(new B2Vec2((x1-x2) * pforce , (y1-y2)*pforce), new B2Vec2(0,0));
//            }

            if(myBody.body.getUserData() != null && Std.is(cast(myBody.body.getUserData(), Bitmap), Bitmap))
            {
                //Sets the x, y, and rotation of the sprite

                myBody.body.getUserData().x = myBody.body.getPosition().x * util.GameWorld.PHYSICS_SCALER - (this.thickness*2);
                myBody.body.getUserData().y = myBody.body.getPosition().y * util.GameWorld.PHYSICS_SCALER - (this.thickness*2);
                myBody.body.getUserData().rotation = myBody.body.getAngle();

                //trace("myBody.getUserData().x " + myBody.body.getUserData().x + " bodypos: " + myBody.body.getPosition().x * gameGameWorld.PHYSICS_SCALER);
                //trace("myBody.getUserData().y " + myBody.body.getUserData().y + " bodypos: " + myBody.body.getPosition().y * util.GameWorld.PHYSICS_SCALER);

            }
        }

    }


}