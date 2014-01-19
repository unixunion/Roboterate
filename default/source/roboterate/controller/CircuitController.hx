package roboterate.controller;

import roboterate.interfaces.IController;
import roboterate.models.Model;

/*
    The circuit controller should handle the users manipulation
    of the circuit as a whole, and perhaps pass down the commands to
    the individual components of the circuit.

 */

class CircuitController implements IController
{
    private var model:Model;

    public function new(model:Model){
        this.model = model;
    }

    public function update(resource:String, value:Float, requestor:String):Void{

        switch(resource){
            case 'power_request':{
                trace("power update");
                model.update(resource, value, requestor);
            }
            default:{
                trace("default update resource: " + resource + " value: " + value + " requestor: " + requestor);
                model.update(resource, value, requestor);
            }
        }
    }
}

