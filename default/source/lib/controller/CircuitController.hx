package lib.controller;

import lib.model.CircuitModel;

class CircuitController implements IController
{
    private var dm:CircuitModel;

    public function new(dm:CircuitModel){
        this.dm = dm;
    }

    public function run():Void{
        this.dm.run(CircuitModel.UPDATE, null);
    }

}