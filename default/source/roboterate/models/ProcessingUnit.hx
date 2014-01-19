package roboterate.ui;

// consume power from internal reservoir and adds logic to internal reservoir
// later, should answer logic request and draw power to return that logic amount.

class ProcessingUnit {

    var powerRate:Float; // rate we consume power at ( - )
    var powerReservoir:Float = 0;
    var logicRate:Float; // logic generated per powerRate cycle.
    var logicReservoir:Float;
    var operational:Bool; // if were out of power we fail

    public function new()
    {
        this.powerRate = -0.04;
        this.logicRate = 0.05;
        this.operational = true;
    }

    public function update():Void
    {
        if ( (powerReservoir += powerRate) <= 0 ) {
            operational = false;
            trace("not enough power");
        } else {
            powerReservoir += powerRate;
            logicReservoir += logicRate;
            operational = true;
        }
    }

    // probably goes in the controller / engine
    public function getLogic(amount:Float) {
        // should consume X power units to return the approriate logic amount.
        // 1 Logic = ( 1.2 / logicRate * powerRate )
        var powerRequired:Float = (amount / logicRate) * powerRate;
    }

}