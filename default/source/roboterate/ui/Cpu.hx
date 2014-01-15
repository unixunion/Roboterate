package roboterate.ui;

import roboterate.models.DraggableGameObject;
import roboterate.models.Power;
import flixel.FlxSprite;
import flixel.FlxG;
import flash.events.Event;
import roboterate.models.PowerGrid;
import flixel.group.FlxGroup;

// TODO FIXME
// make this request power units from the PSU, utilizing per object ID's

class Cpu extends FlxGroup
{
    private var powerGrid:PowerGrid;
    private var sprite:DraggableGameObject;

    private var power:Float = 0; // current power value, builds up.
    private var powerCapacity:Float = 3; // max power we will store in power
    private var powerUsage:Float = 0.05;

    public var operational:Bool;
    public var id:String;

    public function new(powerGrid:PowerGrid, id, ?x:Float=100, y:Float=100) {
        super();
        this.powerGrid = powerGrid;
        this.id = id;
        this.sprite = new DraggableGameObject(x,y);
        this.sprite.loadGraphic("assets/images/cpu.png");
        add(this.sprite);
        this.sprite.addChild(new FlxSprite(x,y).loadGraphic("assets/images/socket1.png"));

        powerGrid.addEventListener(this.id, receivePower);
        FlxG.stage.addEventListener(Event.ENTER_FRAME, consume);
    }

    public function receivePower(e:Power) {
        trace("receiving power from: " + e.getRequestId());
        if (this.power < this.powerCapacity) {
            this.power+=e.getPower();
        }
        trace("power: " + this.power);
    }

    public function consume(e:Event) : Void {
        trace("=====CPU=====");
        trace("currentPower: " + this.power);
        if (this.power <= powerUsage) {
            trace('requesting power');
            powerGrid.request(this.id, powerUsage, 'PSU'); // cpu asking for 0.05 from psu
        }
        this.power = this.power - this.powerUsage;
        update();
    }

    override public function update():Void
    {
        trace("update");
        super.update();

        if ( this.power <= 0 ){
            this.operational = false;
            this.power = 0;
            trace("not enough power");
        } else {
            trace("power is good");
            this.operational = true;
        }

    }

}