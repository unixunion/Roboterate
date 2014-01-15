package roboterate.interfaces;

// descrines a power emitting object
interface IPowerOutput
{

    var powerOutput: Float; // power to generate per frame ( 1/30 or 1/60 )

    var pluggedObject: IPowerInput; // where we can talk to the plugged in object

    function generatePower() : Void; // method that generates power

}