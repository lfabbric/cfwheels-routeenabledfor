# Plugin: RouteEnabledFor

## Purpose

RouteEnabledFor is middle ware solution that adds a level of site-based security restricting access based on application level parameters.

## Configuration

Within the config/routes.cfm page, added a new parameter to the addRoute method called enabledfor.

```java
config/routes.cfm ---------------------
    addRoute(
        name="about",
        pattern="/about",
        controller="pages",
        action="about",
        enabledFor="all|value1|value1,value2" // new check
    );
```

```java
config/settings.cfm
    // you can set defaults for the addRoute
    set(
        functionName="addRoute",
        enabledForVariable="environment_variable",
        enabledForRedirectRoute="http404"
    );
```

### Example
The below example will restrict access to routes depending on the current environment. So the route in the example 'myRoute' will only be accessible in the design and development environments.


```java
config/routes.cfm ---------------------
    addRoute(
        name="myRoute",
        pattern="/myRoute",
        controller="MyRouteController",
        action="index",
        enabledFor="design,development" // new check
    );
```

```java
config/settings.cfm
    // you can set defaults for the addRoute
    set(
        functionName="addRoute",
        enabledForVariable="application.wheels.environment",
        enabledForRedirectRoute="http404"
    );
```
#### Parameters
Parameter | Type | Required | Default | Description
--- | --- | --- | --- | ---
enabledFor | `string` | false | `all` | String of possible options to check against. If more than one option is required, a comma delimited list can be used. <ul><li>"all" - bypasses check and continues to routed page</li><li>"" - empty string, bypasses check and continues to routed page</li><li>"param1" - a string to compare against, if it is equal to the string, it will continue to the routes page</li><li>"param1,param2" - a list of parameters to check against, if one is found it will continue to the routes page</li></ul>
enabledForVariable | `string` | false |  | Sets the comparative string used against the enabledFor variable
enabledForRedirectRoute | `string` | true | | Sets the route used if the validation check fails


## Utilities

-----
### ref_validateByRouteName()
Based on a route name, will return a boolean response if that route is allowed to be viewed by the configured "enabledForVariable".

#### Usage
```java
config/routes.cfm
    addRoute(
        name="myRoute",
        pattern="/secret",
        controller="MyRouteController",
        action="index",
        enabledFor="design,development",
        enabledForVariable="application.applicationname",
        enabledForRedirectRoute="http404"
    );
```

```java
//cfscript example
    if (ref_validateByRouteName("myRoute")) {
        // ... do some action
    }
```

```html
    <cfif ref_validateByRouteName("myRoute") >
        <li>
            #linkTo(
                route="aceWizard",
                text="AgChemExpert"
            )#
        </li>
    <cfif>
```

#### Parameters
Parameter | Type | Required | Default | Description
--- | --- | --- | --- | ---
name | `string` | true |  | Name of a route that you have configured in config/routes.cfm.
----
