package roboterate.models;

import flash.events.Event;

// generates power
class Power extends Event {
    private var power:Float;
    private var requestor:String;

    public function new(label:String, power:Float, requestor:String, bubbles:Bool = false, cancelable:Bool = false) {
        super(label, bubbles, cancelable);
        this.power = power;
        this.requestor = requestor;
    }

    public function getPower():Float {
//        trace("returning unit: " + this.power);
        return this.power;
    }

    public function getRequestId():String {
//        trace("returning requestor id");
        return this.requestor;
    }

}