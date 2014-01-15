package roboterate.ui;

import roboterate.interfaces.IController;
import roboterate.models.Model;
import roboterate.models.DraggableGameObject;
import flash.events.Event;

// abstract view class
class AView extends DraggableGameObject
{
    private var model:Model;
    private var controller:IController;
    private var id:String;

    private var powerRate:Float = 0;
    private var powerReserve:Float = 0;

    public function onAddedToStage(e:Event):Void{
        trace("onAddedToStage: must be overriden in a subclass");
    }

}