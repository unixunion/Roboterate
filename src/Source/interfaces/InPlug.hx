package interfaces;

import ui.SimpleCable;

// ducktyping?

// this is a inconnection abstract class, should also hold the resource requesting from gameObject and
// forward these to the cable who forwards to the other gameObject on the other end.

abstract InPlug {

    public var connectable:Bool = true; // allow connections, connect events set this to false
    public var disconnectable:Bool = true; // allow disconnects
    public var connection:SimpleCable = null; // only one connection per plug or list / array?

    // called with a outPlug type object
    public function connect(cable:SimpleCable) : Void {
        trace("connecting cable: " + cable);
        this.socket_connection = cable; // point to the cable object
        this.connectable = false; // deny future connections
    }

    public function unsocket(): Void {
        if (this.socket_connection != null) {
            trace("calling cables disconnect method");
            this.socket_connection.disconnect(); // tell the cable to disconnect
        } else {
            trace("unable to disconnect");
        }
        this.socket_connection = null; // set socket to null
        this.connectable = true; // ready to receive new connection
    }


    public function new() {
        trace("new");
    }

}