package roboterate.ui;

import roboterate.models.Power;
import roboterate.interfaces.IController;
import roboterate.models.Model;
import flash.events.Event;

class CircuitEngine extends AView {

    public function new(model:Model, controller:IController ) {
        super(10,10);
        this.model = model;
        this.controller = controller;
        this.model.addEventListener("power_request", onPowerRequest);
    }

    private function onPowerRequest(e:Power) {
        trace("power requestor: " + e.getRequestId() + " value: " + e.getPower());
    }

    private function onPowerResponse(e:Event) {
        trace("power response " + e);
    }

}