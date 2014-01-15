package tests;

import nape.phys.Body;
import nape.shape.Polygon;
import nape.phys.BodyType;
import flash.display.Sprite;
import flash.Lib;
import util.GameWorld;

class TestNape extends Sprite {

    private var gameWorld:util.GameWorld;

    public function new() {
        super();
        var gameWorld = new util.GameWorld();
        Lib.current.stage.addChild(gameWorld);



        var w = stage.stageWidth;
        var h = stage.stageHeight;

        debug = new ShapeDebug(w, h);
        addChild(debug);

        // Create world bounds.
        var walls = new Body(BodyType.STATIC);
        walls.shapes.add(new Polygon(Polygon.rect(0, 0, w, 10)));
        walls.shapes.add(new Polygon(Polygon.rect(0, 0, 10, h)));
        walls.shapes.add(new Polygon(Polygon.rect(0, h - 10, w, 10)));
        walls.shapes.add(new Polygon(Polygon.rect(w - 10, 0, 10, h)));
        walls.space = util.GameWorld.space;


    }
}