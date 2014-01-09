package util;

// interpolates between two numbers taking a delta
class Interpolator
{
    private var start:Float = -1.0;
    private var end:Float = 1.0;
    private var num:Float = 0.0;
    private var increment:Float = 0.1;

    public function new(start:Float, end:Float, increment:Float)
    {
        this.start = start;
        this.end = end;
        this.increment = increment;
    }

//    public function hasNext() {
//        return( min < max );
//    }

    public function next() {
        num = num + increment;
        if ( num > end ) {
            this.increment = this.increment * -1;
            this.num = end;
            return num;
        }

        if ( num < start ) {
            this.increment = this.increment * -1;
            this.num = start;
            return num;
        }

        return num;

    }

}