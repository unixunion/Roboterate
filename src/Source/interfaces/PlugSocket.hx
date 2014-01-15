package interfaces;

import ui.SimpleCable;

interface PlugSocket {
    function socket(cable: SimpleCable) : Void;
    var connectable : Bool;
    var socket_connection: SimpleCable;
    var disconnectable:Bool;

//  perhaps this needs to be a hermaphrodite connector
//    var disconnectable : Bool;
//    function disconnect() : Void;
}