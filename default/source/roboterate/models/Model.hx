package roboterate.models;

import roboterate.models.Power;
import flash.events.EventDispatcher;

class Model extends EventDispatcher {

    public function new() {
        super();
    }

    // id = resource type eg: power / cooling / ...
    // index
    // value = amount of resource required
    public function update( resource:String, value:Float, requestor:String):Void{
        switch(resource){
            case 'power':{
                trace("Dispatching power event id: " + resource + " requestor " + requestor + " value " + value);
                dispatchEvent(new Power(resource, value, requestor));
            }

            default:
        }
    }

}