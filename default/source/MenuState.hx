package;

import roboterate.models.PowerGrid;
import roboterate.ui.PowerSupply;
import roboterate.ui.Cpu;
import flixel.addons.plugin.FlxMouseControl;
import flixel.FlxG;
import flixel.FlxState;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		// Set a background color
		FlxG.cameras.bgColor = 0xff131c1b;
		// Show the mouse (in case it hasn't been disabled)
		#if !FLX_NO_MOUSE
		FlxG.mouse.show();
		#end

        // Setup the Mouse Event Manager
        FlxG.plugins.add(new FlxMouseControl());

        var powerGrid = new PowerGrid("grid1");
        var psu = new PowerSupply(powerGrid, 100, 100);
        var cpu1 = new Cpu(powerGrid, "cpu1");
        var cpu2 = new Cpu(powerGrid, "cpu2");

        add(psu);
        add(cpu1);
        add(cpu2);



	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
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