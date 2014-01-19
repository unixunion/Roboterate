package lib;

// manages resources
import lib.model.ResourceModel;
class ResourceManager {

    private var model:ResourceModel;
    public var resources:Array<Resource>;

    public function new() {
        this.model = new ResourceModel();
        this.resources = new Array<Resource>();
    }

    public function register(name:String) {
        this.resources.push(new Resource(model, name));
    }


}