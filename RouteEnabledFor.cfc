component hint="cfWheels enabledFor Plugin" output="false" mixin="global" {

    public function init() {
        this.version = "2.0";
        this.attributeOptions = "enabledFor,enabledForVariable,enabledForRedirectRoute";
        return this;
    }

    public function $initControllerObject(required string name, required struct params) {
        var loc = {};
        loc.validated = true;
        loc.routeName = "";
        if (arguments.params.keyExists("route")) {
            loc.routeName = arguments.params.route;
        }
        if (len(loc.routeName) && application.wheels.namedRoutePositions.keyExists(loc.routeName)) {
            loc.route = $ref_getRouteByName(loc.routeName);
            if(isStruct(loc.route)) {
                loc.validated = $ref_validate(loc.route);
            }
        }
        if (loc.validated) {
            return core.$initControllerObject(argumentCollection=arguments);
        } else {
            redirectTo(route=loc.route.enabledForRedirectRoute);
        }
    }

    public boolean function ref_validateByRouteName(required string name) {
        var route = $ref_getRouteByName(arguments.name);
        return $ref_validate(route);
    }

    /**
     * @hint private
     */
    public struct function $ref_getRouteByName(required string name) {
        if (application.wheels.namedRoutePositions.keyExists(arguments.name)) {
            var pos = application.wheels.namedRoutePositions[arguments.name];
            return $ref_getRouteParams(duplicate(application.wheels.routes[listFirst(pos)]));
        }
        return {};
    }

    /**
     * @hint private  build a route with this.attributeOptions added.
     */
    public struct function $ref_getRouteParams(required struct route) {
        var loc = {};
        loc.route = duplicate(arguments.route);
        if (route.keyExists("enabledFor")) {
            for (key in application.wheels.plugins.routeenabledfor.attributeOptions) {
                if(!route.keyExists(key)) {
                    loc.route[key] = get(functionName="addRoute", name=key);
                }
            }
        }
        return loc.route;
    }

    /**
     * @hint private
     */
    public boolean function $ref_validate(required struct route) {
        var loc = {};
        loc.route = duplicate(arguments.route);
        if (loc.route.keyExists("enabledFor")) {
            if (!len(loc.route.enabledFor) || uCase(loc.route.enabledFor) == "ALL") {
                return true;
            } else if (listLen(loc.route.enabledFor) > 1) {
                for (item in loc.route.enabledFor) {
                    if ($ref_validateHelper(item, loc.route.enabledForVariable)) {
                        return true;
                    }
                }
                return false;
            } else {
                return $ref_validateHelper(loc.route.enabledFor, loc.route.enabledForVariable);
            }
        }
        return true;
    }

    /**
     * @hint private helper
     */
    public boolean function $ref_validateHelper(required string enabledFor, required string enabledForVariable) {
        return uCase(arguments.enabledFor) == uCase(evaluate(arguments.enabledForVariable));
    }
}
