package lib.model;


import org.bbmvc.models.BBModel;

class CircuitModel extends BBModel {

    public static var POWER_RESERVOIR_CHANGE = "POWER_RESERVOIR_CHANGE";
    public static var LOGIC_RESERVOIR_CHANGE = "LOGIC_RESERVOIR_CHANGE";
    public static var THERMAL_RESERVOIR_CHANGE = "THERMAL_RESERVOIR_CHANGE";
    public static var HYDRAULIC_RESERVOIR_CHANGE = "HYDRAULIC_RESERVOIR_CHANGE";
    public static var COMPONENT_CHANGE = "COMPONENT_CHANGE";
    public static var UPDATE = "UPDATE";

    private var _components : Array<Component>;
    // reservoirs should perhaps be refactored to be "demand" since
    // I want to abolish the reservoir and ask components for their
    // needs / outputs.
    private var _powerReservoir : Float;
    private var _logicReservoir : Float;
    private var _thermalReservoir : Float;
    private var _hydraulicReservoir : Float;

    public var components(get_components, set_components) : Array<Component>;
    private function get_components() : Array<Component> {
        return _components;
    }
    private function set_components(value:Array<Component>) : Array<Component> {
        _components = value;
        this.update(COMPONENT_CHANGE, _components);
        return _components;
    }

    // POWER
    public var powerReservoir(get, set) : Float;
    private function get_powerReservoir(): Float {
        return _powerReservoir;
    }
    private function set_powerReservoir(value:Float): Float {
        _powerReservoir = value;
        this.update(POWER_RESERVOIR_CHANGE, _powerReservoir);
        return _powerReservoir;
    }
//    public function get_powerDemand() : Float {
//        // iterate over components and get power demands
//        var _powerDemand:Float;
//        for ( c in components ) {
//            _powerDemand += c.dm.powerRate;
//        }
//        return _powerDemand;
//    }


    // LOGIC
    public var logicReservoir(get,set) : Float;
    private function get_logicReservoir() : Float {
        return _logicReservoir;
    }
    private function set_logicReservoir(value:Float) {
        _logicReservoir = value;
        this.update(LOGIC_RESERVOIR_CHANGE, _logicReservoir);
        return _logicReservoir;
    }

    // THERMAL
    public var thermalReservoir(get,set) : Float;
    private function get_thermalReservoir() : Float {
        return _thermalReservoir;
    }
    private function set_thermalReservoir(value:Float) {
        _thermalReservoir = value;
        this.update(THERMAL_RESERVOIR_CHANGE, _thermalReservoir);
        return _thermalReservoir;
    }

    // HYDRAULIC
    public var hydraulicReservoir(get,set) : Float;
    private function get_hydraulicReservoir() : Float {
        return _hydraulicReservoir;
    }
    private function set_hydraulicReservoir(value:Float) {
        _hydraulicReservoir = value;
        this.update(HYDRAULIC_RESERVOIR_CHANGE, hydraulicReservoir);
        return hydraulicReservoir;
    }





    public function run(change:String, value:Dynamic): Void {
//        trace("change: " + change + " value: " + value);
        for (c in _components) {
            c.run(this);
            if (c.operational) {
//                trace("component: " + c.type + " is OPERATIONAL");
            } else {
                trace("component: " + c.type + " is NON-operational");

            }
        }

        // after the run, lets commit excess power direct into heat.

        //this.thermalReservoir += this.powerReservoir;
        this.update(UPDATE, null);

    }

//    private function update(): Void {
//        // iterate over all components and do usage / production calculations
//        for ( c in _components ) {
//            trace("Component: " + c + " rate: " + c.rate);
//        }
//    }

}