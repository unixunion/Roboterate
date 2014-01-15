import roboterate.models.PowerGrid;
import roboterate.ui.Cpu;
import flixel.FlxSprite;
import flixel.FlxG;
import flash.events.Event;

class CircuitView extends AView {

    private var image:FlxSprite;
    private var cpu:Model;
    private var powerGrid:Model;

    public function new(model:Model, controller:IController )
    {
        super();
        this.model      = model;
        this.controller = controller;

        // background image
        this.image = new FlxSprite().loadGraphic("assets/images/circuit.png");
        addChild(this.image);
        image.x = 100;
        image.y = 100;


        // cpu
        this.cpu = new Cpu()


        FlxG.stage.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        FlxG.stage.addEventListener(Event.ENTER_FRAME, run);
    }


    override public function onAddedToStage(e:Event){
        FlxG.log("adding to stage");
        FlxG.stage.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    }

    // call the psu, cpu, cooler and make them all do their thing be it
    // generating power or consuming power / cooling.

    private function run(play:Bool):Void{
        controller.update('play', 0, play? 1.0:0.0);
    }



}