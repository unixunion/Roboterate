package;

import lib.view.CircuitView;
import lib.Circuit;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.Lib;
import lib.model.CircuitModel;
import org.bbmvc.views.IBBView;

class MvcTest extends Sprite, implements IBBView
{
    private var dm : CircuitModel;
    private var pm : Circuit;
    private var view : CircuitView;
    public var viewId:String;

    public function new() {
        super();
        trace('new');
        addEventListener(Event.ADDED_TO_STAGE, init);
    }

    static function main() {
        var stage = Lib.current.stage;
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;
        Lib.current.addChild(new Main());
    }

    private function init(e:Event) {
        trace('init');
        this.dm = new CircuitModel();
        this.pm = new Circuit(dm);
        dm.registerView(this);
        view = new CircuitView( dm, "my panel");
        addChild(view);
        pm.start();
    }

    public function update( updateType : String = null, data : Dynamic = null )        {
        switch(updateType){
            case CircuitModel.RESERVOIR_CHANGE:
                trace("RESERVOIR_CHANGE from panel controller : " + Std.string(data));
            case CircuitModel.COMPONENT_CHANGE:
                trace("COMPONENT_CHANGE from panel controller : " + Std.string(data));
            default:
        }
    }

    public function destroy() {
    }

}