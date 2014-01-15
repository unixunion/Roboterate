package;

import flixel.addons.plugin.FlxMouseControl;
import roboterate.ui.CircuitEngine;
import roboterate.ui.CircuitView;
import roboterate.interfaces.IController;
import roboterate.ui.AView;
import roboterate.controller.CircuitController;
import roboterate.models.Model;



import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;


class PlayState extends FlxState
{
    private var model:Model;
    private var view:AView;
    private var controller:IController;
    private var circuit:AView;

	override public function create():Void
	{
		// Set a background color
		FlxG.cameras.bgColor = 0xff131c1b;
		// Show the mouse (in case it hasn't been disabled)
		#if !FLX_NO_MOUSE
		FlxG.mouse.show();
		#end
        FlxG.plugins.add(new FlxMouseControl());
		super.create();

        model = new Model();
        controller = new CircuitController(model);
        view = new CircuitView(model, controller);
        circuit = new CircuitEngine(model, controller);

	}
	

	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
	}	
}