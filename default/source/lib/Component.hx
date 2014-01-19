package lib;

import org.bbmvc.models.BBModel;
import lib.model.CircuitModel;
import lib.model.ComponentModel;

enum ComponentType {
    PSU;
    CPU;
    SENSOR;
    HYDRAULIC;
    COOLER;
    ENVIRONMENT;
}


/* component should consume resources, and the more demand on its
output the higher its demans are for its inputs. eg:

    CPU:
        ratio 1.25
        efficiency 2 - ratio = 0.75
        consumes power: p
        produces logic: l ( demand )
        produces thermal t

        use demand ( l ) * ratio to get power
        p = l * ratio
        t = p * efficiency ( 100watt * 0.75 - 75 watt )

        * needs to know the demands on its outputs first before we can ask for inputs.
        *


*/

class Component extends BBModel implements IResource {

    public var dm: ComponentModel;
    private var _operational:Bool;
    private var _thermalMax:Float;
    private var _thermalMin:Float;
    public var type:ComponentType;

    public static var THERMALMAX = "THERMALMAX";
    public static var THERMALMIN = "THERMALMIN";
    public static var OPERATIONAL = "OPERATIONAL";


    public function new(type:ComponentType, powerRate:Float, logicRate:Float, thermalRate:Float, hydraulicRate:Float, ?thermalMax:Float=300.0, ?thermalMin=-0.5) {
        super();
        this.dm = new ComponentModel();
        this.dm.powerRate = powerRate / 60 / 60 / 30;
        this.dm.logicRate = logicRate / 30;
        this.dm.thermalRate = thermalRate / 60 / 60 / 30;
        this.dm.hydraulicRate = hydraulicRate;
        this.operational = true;
        this.thermalMax = thermalMax / 60 ;
        this.thermalMin = thermalMin / 60 ;
        this.type = type;
    }


    // thermal maximun
    public var thermalMax(get,set):Float;
    private function get_thermalMax():Float {
        return _thermalMax;
    }
    private function set_thermalMax(value:Float) {
        _thermalMax = value;
        this.update(THERMALMAX, _thermalMax);
        return _thermalMax;
    }

    // thermal minimun
    public var thermalMin(get,set):Float;
    private function get_thermalMin():Float {
        return _thermalMin;
    }
    private function set_thermalMin(value:Float) {
        _thermalMin = value;
        this.update(THERMALMIN, _thermalMin);
        return _thermalMin;
    }

    // operational
    public var operational(get,set):Bool;
    private function get_operational():Bool {
        return _operational;
    }
    private function set_operational(value:Bool):Bool {
        _operational = value;
        this.update(OPERATIONAL, _operational);
        return _operational;
    }

    // draw resources / produce to the circuit model instance
    public function run(circuit:CircuitModel):Void {

//        trace("Status power: " + circuit.powerReservoir + " logic: " + circuit.logicReservoir + " thermal: " + circuit.thermalReservoir + " hydraulic: " + circuit.hydraulicReservoir);

        if (circuit.thermalReservoir >= thermalMin && thermalMax >= circuit.thermalReservoir ) {

            // power
            if (dm.powerRate != 0) {
                if (type == ComponentType.PSU && circuit.thermalReservoir < thermalMax) {
                    circuit.powerReservoir += dm.powerRate;
                    operational = true;
                } else if (circuit.powerReservoir >= dm.powerRate ) {
                    circuit.powerReservoir += dm.powerRate;
                    operational = true;
                } else {
                    trace(type + " failure " + dm.powerRate + " reservoir: " + circuit.powerReservoir);
                    operational = false;
                }
            }

            // thermal
    //        trace (circuit.thermalReservoir, thermalMin, thermalMax );

                if ( type == ComponentType.COOLER && operational ) {
                    circuit.thermalReservoir += dm.thermalRate;
                } else if ( circuit.thermalReservoir < thermalMax && operational ) {
                    // not overheating, so run
                    circuit.thermalReservoir += dm.thermalRate;
                } else if ( circuit.thermalReservoir > thermalMax ){
                    // overheating
                    operational = false;
                } else {
                    circuit.thermalReservoir += dm.thermalRate;
                    operational = true;
                }



            // logic
            if (dm.logicRate != 0) {
                if ( type == ComponentType.CPU && circuit.thermalReservoir < thermalMax ) {
                    circuit.logicReservoir += dm.logicRate ;
                    operational = true;
                } else if ( circuit.logicReservoir >= dm.logicRate  && operational) {
                    circuit.logicReservoir += dm.logicRate ;
                    operational = true;
                } else {
                    trace(type + " circuit: " + circuit);
                    trace(type + " this: " + this);
                    trace(type +" not enough logic: " + dm.logicRate);
                    operational = false;
                }
            }




            if ( dm.hydraulicRate != 0) {
                if (type ==  ComponentType.HYDRAULIC) {
                    circuit.hydraulicReservoir += dm.hydraulicRate;
                    operational = true;
                } else if (circuit.hydraulicReservoir >= dm.hydraulicRate && operational) {
                    circuit.hydraulicReservoir += dm.hydraulicRate;
                    operational = true;
                } else {
                    trace(type + " not enough hydraulic pressure needed: " + circuit.hydraulicReservoir);
                    operational = false;
                }
            }


        } else {
            trace(type + " is frozen or overheated cicruit:" + circuit.thermalReservoir + " thermalMin: " + thermalMin + " thermalMax: " + thermalMax);
            operational = false;
        }
//
//        circuit.powerReservoir += dm.powerRate;
//        circuit.logicReservoir += dm.logicRate;
//        circuit.thermalReservoir += dm.thermalRate;
//        circuit.hydraulicReservoir += dm.hydraulicRate;
    }

}