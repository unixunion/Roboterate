package;


import lib.ResourceManager;
import flash.events.Event;
import lib.Circuit;
import lib.controller.CircuitController;
import lib.view.CircuitView;
import lib.model.CircuitModel;
import flixel.addons.plugin.FlxMouseControl;
import flixel.FlxG;
import flixel.FlxState;


class TestState extends FlxState
{
    private var model:CircuitModel;
    private var view:CircuitView;
    private var controller:CircuitController;
    private var circuit:Circuit;
    private var resourceManager:ResourceManager;

    override public function create():Void
    {

        FlxG.cameras.bgColor = 0xff131c1b;
		FlxG.mouse.show();
        FlxG.plugins.add(new FlxMouseControl());
        FlxG.autoPause = false;
        super.create();

        resourceManager = new ResourceManager();
        resourceManager.register("power");
        resourceManager.register("thermal");
        resourceManager.register("hydraulic");
        resourceManager.register("logic");

        model = new CircuitModel();
        controller = new CircuitController(model);
        view = new CircuitView(model, controller);
        var setup = new Array<CircuitComponentEnum>();
//        setup.push(CircuitComponentEnum.COOLER_V1);
//        setup.push(CircuitComponentEnum.COOLER_V1);
//        setup.push(CircuitComponentEnum.COOLER_V1);
////        setup.push(CircuitComponentEnum.COOLER_V1);
//        setup.push(CircuitComponentEnum.PSU_V1);
//        setup.push(CircuitComponentEnum.CPU_V1);
//        setup.push(CircuitComponentEnum.COOLER_V2);
//        setup.push(CircuitComponentEnum.HYDRAULIC_PUMP_V1);
//        setup.push(CircuitComponentEnum.HYDRAULIC_LIMB_V1);
//        setup.push(CircuitComponentEnum.SENSOR_V1);
        setup.push(CircuitComponentEnum.COOLER_V1);
        setup.push(CircuitComponentEnum.PSU_V1);
        setup.push(CircuitComponentEnum.CPU_V1);
        setup.push(CircuitComponentEnum.SENSOR_V1);
//        setup.push(CircuitComponentEnum.FROZEN_ENVIRONMENT);

        circuit = new Circuit(model, setup);
        model.registerView(view);



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
        circuit.update();
    }
}