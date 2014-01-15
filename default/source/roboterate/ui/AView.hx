import roboterate.models.DraggableGameObject;
import flixel.FlxSprite;
import flash.events.Event;


class AView extends DraggableGameObject
{
    private var model:Model;
    private var controller:IController;

    public function onAddedToStage(e:Event):Void{
        trace("onAddedToStage: must be overriden in a subclass");
    }

}