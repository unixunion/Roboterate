package lib;

import lib.Component.ComponentType;
import lib.model.CircuitModel;

enum CircuitComponentEnum {
    PSU_V1;
    CPU_V1;
    SENSOR_V1;
    HYDRAULIC_PUMP_V1;
    HYDRAULIC_LIMB_V1;
    COOLER_V1;
    COOLER_V2;
    FROZEN_ENVIRONMENT; // a frozen place! -temperatures and descreases pressures
//    HELL_ENVIRONMENT; // very hot thermal conditions and increases pressures
}

// run the circuit and shuffle the resources around.
class Circuit {

    private var dm: CircuitModel;

    public function new(dm:CircuitModel, components:Array<CircuitComponentEnum>) {
        this.dm = dm;
        this.dm.powerReservoir = 0;
        this.dm.logicReservoir = 0;
        this.dm.thermalReservoir = 0; // need some leeway for PSU startup
        this.dm.hydraulicReservoir = 0;
        this.dm.components = new Array<Component>();

        for (c in components) {
            switch(c){
                // POWER || LOGIC || THERMAL || HYDRAULIC
                case CircuitComponentEnum.CPU_V1:
                    /*
                        The CPU
                            consume power in watts 95watt / 60m / 60s / 30fps = 0.00087962962
                            produces logic
                            produces thermal heat eg: 95watt / 60m / 60s / 30fps = 0.00087962962
                            ignore hydraulic
                            fail at 95
                     */
                    trace("new cpu" + this.dm.components );
                    this.dm.components.push(new Component(ComponentType.CPU, -70, 1000, 95, 0, 95, -50));
                case CircuitComponentEnum.PSU_V1:
                    /*
                        The PSU
                            produces power
                            ignore logic
                            produces thermal heat 1000 watt @ 90% efficiency = 900
                            ignore hydraulic
                            fail at 95
                     */
                    trace("new psu" + this.dm.components );
                    this.dm.components.push(new Component(ComponentType.PSU, 480, 0, 440, 0, 65, -50));
                case CircuitComponentEnum.COOLER_V2:
                    /*
                        The cooler:
                            consumes power
                            ignore logic
                            consumes thermal heat
                            ignore hydraulic
                            fail at 120
                     */
                    trace("new cooler" + this.dm.components );
                    this.dm.components.push(new Component(ComponentType.COOLER,-70, 0, -800, 0, 120, -50));
                case CircuitComponentEnum.COOLER_V1:
                    /*
                        The passive cooler:
                            ignore power
                            ignore logic
                            consumes thermal heat
                            ignore hydraulic
                            fail at 125
                     */
                    trace("new cooler" + this.dm.components );
                    this.dm.components.push(new Component(ComponentType.COOLER ,0, 0, -200, 0, 150, -250));
                case CircuitComponentEnum.HYDRAULIC_PUMP_V1:
                    /*
                        The hydraulic pump
                            consumes power
                            ignore logic
                            produces thermal heat
                            produces hydraulic pressure
                            fail at 120

                     */
                    trace("new hydraulic pump" + this.dm.components );
                    this.dm.components.push(new Component(ComponentType.HYDRAULIC,-300, 0, 1000, 300, 120, -70));
                case CircuitComponentEnum.HYDRAULIC_LIMB_V1:
                     /*
                        The hydraulic limb
                            ignore power
                            consume logic
                            ignore thermal
                            consumes hydraulic pressure
                            fail at 120

                     */
                    trace("new hydraulic limb" + this.dm.components );
                    this.dm.components.push(new Component(ComponentType.HYDRAULIC,-24, -100, 0, -300, 120, -70));
                case CircuitComponentEnum.SENSOR_V1:
                    /*
                        The sensor
                            consume power
                            consumer logic
                            produce thermal
                            ignore hydraulic
                            fail at 50
                     */
                    trace("new sensor " + this.dm.components);
                    this.dm.components.push(new Component(ComponentType.SENSOR,-15, -900, 10, 0, 50, -50));
                case CircuitComponentEnum.FROZEN_ENVIRONMENT:
                    /*
                        an environent of freezing conditions, like space!
                            consumes power ( via battery drain ... )
                            ignores logic
                            consumes thermal
                            consumes hydraulic
                            no fail
                     */
                    trace("new freezing environment");
                    this.dm.components.push(new Component(ComponentType.ENVIRONMENT,-0.20*this.dm.powerReservoir, 0, -0.50*this.dm.thermalReservoir, -0.05*this.dm.hydraulicReservoir, 99999, -99999));

            }
        }
    }

    public function update() {
        this.dm.run(CircuitModel.UPDATE, null);
//        trace("Status power: " + dm.powerReservoir + " logic: " + dm.logicReservoir + " thermal: " + dm.thermalReservoir + " hydraulic: " + dm.hydraulicReservoir);
    }

}