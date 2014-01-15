package roboterate.ui;

import flixel.FlxSprite;
import roboterate.models.DraggableGameObject;

class TestPlug extends DraggableGameObject  {
    public function new(X:Float = 0, Y:Float = 0) {
        super(X, Y);
        loadGraphic("assets/images/plug1.png", true, false);
    }
}