package ui;


// a physics cable, hopefully.
import box2D.dynamics.B2DebugDraw;
import util.GameManager;
import flash.display.DisplayObject;
import box2D.dynamics.joints.B2RevoluteJointDef;
import flash.Lib;
import flash.display.BitmapData;
import util.GameWorld;
import motion.Actuate;
import flash.events.MouseEvent;
import flash.display.Bitmap;
import flash.display.Sprite;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.joints.B2DistanceJointDef;
import box2D.dynamics.B2World;
import flash.display.Sprite;
import flash.events.Event;
import openfl.Assets;


class Cable extends Sprite {

    // mouse drag offset coordinates
    private var dragOffsetY:Float;
    private var dragOffsetX:Float;

    // images
    private var segmentBmp:Bitmap;
    private var plugBmp1:Bitmap;
    private var plugBmp2:Bitmap;
    private var segments:Array<CableSegment>;

    // box2d
    private var World:B2World;
    private var PhysicsDebug:Sprite;
    public static var PHYSICS_SCALE:Float = 1 / 30;
    public static var PHYSICS_SCALER:Float = 30;

    // cable defaults
    private var length:Int;
    private var thickness:Int;

    public function new (img1:DisplayObject, img2:DisplayObject, ?thickness:Int=5, ?length:Int=10) {

        super ();
//        this.x=img1.x;
//        this.y=img1.y;

        this.World = util.GameWorld.World;

        this.thickness = thickness;
        this.length = length;

        initialize();
        construct();

        addEventListener (Event.ENTER_FRAME, this_onEnterFrame);

    }

    private function initialize() {
        // the bmp we will clone for cable links
        segmentBmp = new Bitmap (Assets.getBitmapData("images/reddot.png"));

        // the connector bmp
        plugBmp1 = new Bitmap (Assets.getBitmapData("images/plug.png"));
        plugBmp1.width=30;
        plugBmp1.height=30;
        addChild(plugBmp1);


        plugBmp2 = new Bitmap (Assets.getBitmapData("images/plug.png"));
        plugBmp2.width=30;
        plugBmp2.height=30;
        plugBmp2.x = x+100;
        plugBmp2.y = y+100;
        addChild(plugBmp2);

//        trace("cable1.this.x: " + this.x + " cable1.this.y: " + this.y);
//        trace("plugBmp1.x: " + plugBmp1.x + " plugBmp1.y: " + plugBmp1.y);

        // the listener for mousemove on the connector for some magical reason
        addEventListener (MouseEvent.MOUSE_DOWN, this_onMouseDown);
    }

    private function construct() {
        // 1st segment with slightly different behavior ( innertia )
        segments = new Array<CableSegment>();
        var cable = new CableSegment(this.x, this.y  + (this.thickness), this.World, plugBmp1, this.thickness, 12.0, true);
        addChild(cable);
        segments.push(cable);
        cable.addEventListener (MouseEvent.MOUSE_DOWN, this_onMouseDown);

        // store it into lastSegment for joint creation later
        var lastSegment:CableSegment = cable;

        // rest of cable segments
        for( i in 1...this.length+1 ) {
            var cable = new CableSegment(this.x, this.y  + (this.thickness * i), this.World, segmentBmp, this.thickness, 1);
            segments.push(cable);
//            Lib.current.stage.addChild(cable);
            addChild(cable);
            createJoint(lastSegment.body, cable.body);
            lastSegment = cable;
        }

        // a final segment which coule have different behavior also, like innertia.
        var cable = new CableSegment(this.x, this.y  + (this.thickness * this.length+1), this.World, segmentBmp, this.thickness, 1.0);
        addChild(cable);
        segments.push(cable);
        createJoint(lastSegment.body, cable.body);

    }

    private function createJoint(bodyA:B2Body, bodyB:B2Body ) {
        // creates a joint between two segments at the appropriate coordinates
        trace("joining " + bodyA + " and " + bodyB);
        var joint = new B2DistanceJointDef();
        joint.initialize(bodyA, bodyB, new B2Vec2(0,-1), new B2Vec2(0,1));
        joint.collideConnected = false;
        var joint = new B2RevoluteJointDef();
        joint.initialize(bodyA, bodyB, new B2Vec2(0,0));
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

    // Event Handlers


    private function this_onEnterFrame (event:Event):Void {

        this.World.step (1 / 30, 10, 10);
        this.World.clearForces ();
        this.World.drawDebugData ();

        var pforce = 512;
        segments[0].body.applyForce(new B2Vec2( (this.x + (plugBmp1.width/2) - (segments[0].body.getPosition().x * util.GameWorld.PHYSICS_SCALER)) * pforce , ( (this.y + (plugBmp1.height/2)) - (segments[0].body.getPosition().y * util.GameWorld.PHYSICS_SCALER))*pforce), new B2Vec2(0,0));


        for (i in 0...segments.length )
        {

            var myBody = segments[i];

            if(myBody.body.getUserData() != null && Std.is(cast(myBody.body.getUserData(), Bitmap), Bitmap))
            {
                //Sets the x, y, and rotation of the sprite
//                trace("PRE x: " + x + " this.x: " + this.x + " image.x: " + myBody.x  + " body.x: " + myBody.body.getPosition().x );

                myBody.x = myBody.body.getPosition().x * util.GameWorld.PHYSICS_SCALER - x; // - (this.thickness*2);
                myBody.y = myBody.body.getPosition().y * util.GameWorld.PHYSICS_SCALER - y; // - (this.thickness*2);
                //myBody.body.getUserData().rotation = myBody.body.getAngle();


//                trace("POST image.x: " + myBody.x  + " body.x: " + myBody.body.getPosition().x );
//                trace("body.userdata.x " + myBody.body.getUserData().x + " body.x: " + myBody.body.getPosition().x * util.GameWorld.PHYSICS_SCALER);
//                trace("body.userdata.y " + myBody.body.getUserData().y + " body.y: " + myBody.body.getPosition().y * util.GameWorld.PHYSICS_SCALER);

            }
        }

    }


}