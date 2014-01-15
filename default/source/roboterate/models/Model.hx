import flixel.FlxG;
import roboterate.models.Power;
import flash.events.EventDispatcher;

class Model extends EventDispatcher {

    public function new() {
        super();
    }

    // id = resource type eg: power / cooling / ...
    // index
    // value = amount of resource required
    public function update( id:String, index:UInt, value:Float):Void{
        switch(id){
            case 'power':{
                FlxG.log("Dispatching power event id: " + id + " index " + index + " value " + value);
                dispatchEvent(new Power(id, index, value));
            }
            default:
        }
    }

}