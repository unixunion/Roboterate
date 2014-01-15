package roboterate.interfaces;

// describes consumer socket
interface IPowerInput
{

    var powerUsage: Float; // power to draw per frame ( 1/30 or 1/60 )

    var pluggedObject: IPowerOutput; // where we point and can talk to the plugged in object

    function draw_power() : Void; // method that pulls power

}