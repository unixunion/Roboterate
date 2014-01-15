package roboterate.ui;

import roboterate.models.Power;
import roboterate.interfaces.IController;
import roboterate.ui.AView;
import roboterate.models.Model;
import flash.events.Event;
import flixel.FlxG;
class PowerUnit extends AView {

    public function new(id:String, model:Model, controller:IController )
    {
        super(10,10);
        this.model         = model;
        this.controller = controller;
        this.id = id;

        powerRate = 0.01;

        FlxG.stage.addEventListener(Event.ENTER_FRAME, generate);
        model.addEventListener("power_request", onPowerRequest);
    }

    private function generate(e:Event):Void {
//        trace("Generating power");
        powerReserve += powerRate;
    }

    private function onPowerRequest(e:Power):Void {
        trace("Power Requestor: " + e.getRequestId() + " value: " + e.getPower());
        if (this.powerReserve >= e.getPower()) {
            this.powerReserve -= e.getPower();
            model.dispatchEvent(new Power(e.getRequestId(), e.getPower(), this.id));
        } else {
            trace("not enough power in powerReserve: " + powerReserve);
            model.dispatchEvent(new Power(e.getRequestId(), 0, this.id));
        }
    }

}