package lib.model;

import org.bbmvc.models.BBModel;

// component Model, contains rate information

class ComponentModel extends BBModel {

    public static var POWERRATE_CHANGE : String = "POWERRATE_CHANGE";
    public static var LOGICRATE_CHANGE : String = "LOGICRATE_CHANGE";
    public static var THERMALRATE_CHANGE : String = "THERMALRATE_CHANGE";
    public static var HYDRAULICRATE_CHANGE : String = "HYDRAULICRATE_CHANGE";

    private var _powerRate : Float;
    private var _logicRate : Float;
    private var _thermalRate : Float;
    private var _hydraulicRate : Float;

    // POWER
    public var powerRate(get, set) : Float;
    private function get_powerRate():Float {
        return _powerRate;
    }
    private function set_powerRate(value:Float) : Float {
        _powerRate = value;
        this.update(POWERRATE_CHANGE, _powerRate);
        return _powerRate;
    }

    // LOGIC
    public var logicRate(get, set) : Float;
    private function get_logicRate():Float {
        return _logicRate;
    }
    private function set_logicRate(value:Float) : Float {
        _logicRate = value;
        this.update(LOGICRATE_CHANGE, _logicRate);
        return _logicRate;
    }

    // THERMAL
    public var thermalRate(get, set) : Float;
    private function get_thermalRate():Float {
        return _thermalRate;
    }
    private function set_thermalRate(value:Float) : Float {
        _thermalRate = value;
        this.update(THERMALRATE_CHANGE, _thermalRate);
        return _thermalRate;
    }

    // HYDRAULIC
    public var hydraulicRate(get, set) : Float;
    private function get_hydraulicRate():Float {
        return _hydraulicRate;
    }
    private function set_hydraulicRate(value:Float) : Float {
        _hydraulicRate = value;
        this.update(HYDRAULICRATE_CHANGE, _hydraulicRate);
        return _hydraulicRate;
    }



    public function run():Void {
        trace("run");
    }

}