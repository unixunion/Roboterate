package ui;

import flash.display.Bitmap;
import flash.display.Sprite;
import openfl.Assets;

class Plug extends Sprite {

    private var image:Bitmap;

    public function new() {
        super();
        initialize();
        construct();
    }

    private function initialize() {
        this.image = new Bitmap (Assets.getBitmapData("images/plug1.png"));
    }

    private function construct() {
        addChild(this.image);
    }

}