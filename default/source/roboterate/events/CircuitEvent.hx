package roboterate.events;

import flash.events.Event;

class CircuitEvent extends Event {
    private var value:Float;
    private var requestor:String;

    public function new(label:String, value:Float, requestor:String, bubbles:Bool = false, cancelable:Bool = false) {
        super(label, bubbles, cancelable);
        this.value = value;
        this.requestor = requestor;
    }

    public function getValue():Float {
        return this.value;
    }

    public function getRequestId():String {
        return this.requestor;
    }

}