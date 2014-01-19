package roboterate.ui;

import flash.events.Event;
import roboterate.models.Power;
import flixel.FlxG;
import roboterate.interfaces.IController;
import roboterate.models.Model;
import roboterate.ui.AView;

class ProcessingUnit extends AView {


    public function new(id:String, model:Model, controller:IController )
    {
        super(10,10);
        this.model         = model;
        this.controller = controller;
        this.id = id;

        powerRate = 0.05;
        powerReserve = 1;

        FlxG.stage.addEventListener(Event.ENTER_FRAME, run);
        model.addEventListener(this.id, onPowerResponse);

    }

    private function run(e:Event) {
        if (powerReserve > powerRate) {
            powerReserve -= powerRate;
        } else {
            trace("out of power");
            this.model.dispatchEvent(new Power('power_request', powerRate, this.id));
        }
        controller.update(this.id, powerReserve, null);
    }

    private function onPowerResponse(e:Power) {
        trace("receive power");
        this.powerReserve += e.getPower();
    }


}