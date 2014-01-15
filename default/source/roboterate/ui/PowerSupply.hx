package roboterate.ui;

import roboterate.models.DraggableGameObject;
import roboterate.models.Power;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flash.events.Event;
import flixel.FlxG;
import roboterate.models.PowerGrid;

// TODO FIXME
// make this not juse puke power on frame, but answer requests for power
// from PSU's and so forth...

class PowerSupply extends FlxGroup {

    private var powerGrid:PowerGrid;
    private var sprite:DraggableGameObject;
    private var power:Float=0.09; // power to generate per tick
    private var powerStore:Float=0;

    public function new(powerGrid:PowerGrid, ?x:Float=100, ?y:Float=100) {
        super();
        this.powerGrid = powerGrid;
        this.sprite = new DraggableGameObject(x,y);
        this.sprite.loadGraphic("assets/images/plug1.png");
        this.sprite.x = x;
        this.sprite.y = y;
        add(this.sprite);
//        FlxG.stage.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        FlxG.stage.addEventListener(Event.ENTER_FRAME, generate);
//        FlxG.stage.addEventListener('PSU', receivePower);
        powerGrid.addEventListener('PSU', requestPower);
    }


    public function generate(e:Event):Void {
        this.powerStore+=this.power;
//        powerGrid.generate('PSU', this.power, 'PSU');
    }

    public function requestPower(e:Power) {
        trace("answering request for power from: " + e.getRequestId() + " for power: " + e.getPower());
        if (this.powerStore >= e.getPower()) {
            var powerResponse:Float = e.getPower(); // enough for 30 frames
            this.powerStore -= powerResponse;
            // new request from PSU for power to requestor
            powerGrid.request("PSU", powerResponse, e.getRequestId());
        } else {
            trace("not enough power captain!");
            powerGrid.request("PSU", 0, e.getRequestId());
        }
    }

}