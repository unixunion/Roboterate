package roboterate.models;

import flash.events.EventDispatcher;

// distributes power to components via events
class PowerGrid extends EventDispatcher {

    public var id:String;

    public function new(id:String) {
        super();
        this.id = id;
    }

    public function request( requestor:String, power:Float, channel:String) : Void {
        trace("request:" + requestor + " power: " + power + " channel: " + channel);
        dispatchEvent(new Power( channel, power, requestor ));
    }

}