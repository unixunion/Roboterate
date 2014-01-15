package interfaces;

interface Plug extends InPlug {
    function disconnect() : Void;
    var disconnectable: Bool;
}