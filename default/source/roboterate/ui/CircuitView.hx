package roboterate.ui;

import roboterate.ui.ProcessingUnit;
import roboterate.interfaces.IController;
import roboterate.models.Model;
import flixel.FlxSprite;
import flixel.FlxG;
import flash.events.Event;

class CircuitView extends AView {

    private var image:FlxSprite;

    // components within this circuit
    private var proccessingUnits:Array<ProcessingUnit>;
    private var powerUnits:Array<PowerUnit>;
//    private var powerGrid:Model;

    public function new(model:Model, controller:IController )
    {
        super(10,10);
        this.model      = model;
        this.controller = controller;

        // background image
        this.image = new FlxSprite().loadGraphic("assets/images/circuit.png");
        addChild(this.image);
        image.x = 100;
        image.y = 100;


        // components in the circuit are in arrays
        this.proccessingUnits = new Array<ProcessingUnit>();
        this.powerUnits = new Array<PowerUnit>();
        this.proccessingUnits.push(new ProcessingUnit("cpu", model, controller));
        this.powerUnits.push(new PowerUnit("psu", model, controller));

        FlxG.stage.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
//        FlxG.stage.addEventListener(Event.ENTER_FRAME, run);
    }


    override public function onAddedToStage(e:Event){
        trace("adding to stage");
        FlxG.stage.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    }

    // call the psu, cpu, cooler and make them all do their thing be it
    // generating power or consuming power / cooling.

//    private function run(e:Event) : Void
//    {
//        for ( i in 0...this.proccessingUnits.length) {
//            i.cont
//        }
//    }



}