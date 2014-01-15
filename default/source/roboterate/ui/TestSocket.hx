package roboterate.ui;

import roboterate.interfaces.IPowerInput;
import roboterate.interfaces.IPowerOutput;
import roboterate.models.DraggableGameObject;

class TestSocket extends DraggableGameObject implements IPowerOutput {

    var powerOutput:Float = 1.0;
    var pluggedObject:IPowerInput;

    public function generatePower() : Void
    {

    }

    public function new(X:Float = 0, Y:Float = 0) {
        super(X, Y);
        loadGraphic("assets/images/socket1.png", true, false);
    }

    public override function update():Void
    {
        trace("update");
        generatePower();
        super.update(); // call super update
    }

}