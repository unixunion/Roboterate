package lib;

// abstract electric class
class Electric implements IResource {

    public var value:Float;
    public var reservoir:Float;

    // increase or decrease depending on value positive or negative.
    public function update() {
        reservoir += value;
        if (reservoir < 0) {
            trace("out of resource");
            reservoir = 0;
        }
    }

}