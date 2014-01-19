package lib.view;

import lib.Component.ComponentType;
import roboterate.models.DraggableGameObject;
import flash.display.DisplayObject;
import flixel.group.FlxGroup;
import flixel.addons.display.FlxExtendedSprite;
import org.bbmvc.views.IBBView;
import lib.model.CircuitModel;
import lib.view.AbstractView;
import flixel.FlxSprite;
import flixel.FlxG;
import flash.events.Event;
import flash.display.Sprite;

// a view representing graphicsl representation of the circuit and the graphical
// parts of the circuit components as-well.

class CircuitView implements IBBView {

    private var background:FlxSprite;
    public var viewId:String;
    public var name:String;
    private var model:CircuitModel;
    private var controller:IController;

    private var screen:DraggableGameObject;

// components within this circuit
//    private var proccessingUnits:Array<ProcessingUnit>;
//    private var powerUnits:Array<PowerUnit>;
//    private var powerGrid:Model;

    public function new(model:CircuitModel, controller:IController )
    {
//        super(10,10);
        this.model      = model;
        this.controller = controller;
        this.name = "circuitView";



        // background image
        background = new FlxSprite().loadGraphic("assets/images/circuit.png");
//        FlxG.state.add(background);
//        background.x = 100;
//        background.y = 100;

        screen = new DraggableGameObject(0,0);
        screen.width = background.width;
        screen.height = background.height;
        screen.addChild(background);

//       screen.addChild(new FlxSprite().loadGraphic("assets/images/cpu.png"));
//        screen.draggable = true;
//        screen.enableMouseDrag(true, false, 255);




        FlxG.stage.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

    }

    public function onAddedToStage(e:Event){
        trace("adding to stage");
        FlxG.stage.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        trace(this.model.components);
        for (c in this.model.components) {
            if ( c.type == ComponentType.CPU) {
                screen.addChild(new CpuView(10,10));
            }
        }

    }

    public function update( ?updateType : String = null, ?data : Dynamic = null)  {
        trace("updateType: " + updateType + " data: " + data);
        switch(updateType){
            case CircuitModel.UPDATE:
                trace("message from Main PM : " + Std.string(data));
            default:
        }

        screen.update();

    }

    public function destroy():Void {

    }

}