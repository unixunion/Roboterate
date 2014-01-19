package lib.model;

import org.bbmvc.models.BBModel;

// simple resource model for pluggable resources hopefully.]
// TODO FIXME move to circuit model!

class ResourceModel extends BBModel {

    public static var REGISTER_RESOURCE = "REGISTER_RESOURCE";
    private var _name : String;

    // NAME
    public var name(get, set) : String;
    private function get_name() : String {
        return _name;
    }
    private function set_name(value:String) : String {
        _name = value;
        this.update(REGISTER_RESOURCE, _name);
        return _name;
    }


}