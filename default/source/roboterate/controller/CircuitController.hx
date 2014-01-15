package roboterate.controller;

import flixel.FlxG;
class CircuitController implements IController
{
    private var model:Model;

    public function new(model:Model){
        this.model = model;
    }

    public function update(id:String, index:UInt, value:Float):Void{

        switch(id){
            case 'power':{
                FlxG.log("power update");
                model.update(id, index, value*value);
            }
            default:{
                FlxG.log("default update");
                model.update(id, index, value);
            }
        }
    }
}

