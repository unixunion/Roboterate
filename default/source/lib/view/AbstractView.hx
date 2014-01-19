package lib.view;

import lib.model.CircuitModel;
import lib.model.ComponentModel;
import roboterate.models.DraggableGameObject;
import flash.events.Event;


class AbstractView extends DraggableGameObject
{
    private var model:CircuitModel;
    private var controller:IController;
    public var cpu:Array<Component>;

    public function onAddedToStage(e:Event):Void{
        trace("onAddedToStage: must be overriden in a subclass");
    }

    public function setPos(e:Event):Void{
        trace("setPos: must be overriden in a subclass");
    }

    public function run(e:Event):Void {
        trace("override this method in subclass");
    }
}
