<cfsetting enablecfoutputonly="true">

<h1 id="pluginrouteenabledfor">Plugin: RouteEnabledFor</h1>

<h2 id="purpose">Purpose</h2>

<p>RouteEnabledFor is middle ware solution that adds a level of site-based security restricting access based on application level parameters.</p>

<h2 id="configuration">Configuration</h2>

<p>Within the config/routes.cfm page, added a new parameter to the addRoute method called enabledfor.</p>

<pre><code class="java language-java">config/routes.cfm
addRoute(
    name="about",
    pattern="/about",
    controller="pages",
    action="about",
    enabledFor="all|value1|value1,value2" // new check
);
</code></pre>

<pre><code class="java language-java">config/settings.cfm
// you can set defaults for the addRoute
set(
    functionName="addRoute",
    enabledForVariable="env_variable",
    enabledForRedirectRoute="http404"
);
</code></pre>

<table border=1>
    <thead>
        <tr>
            <th>Parameter</th>
            <th>Type</th>
            <th>Required</th>
            <th>Default</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>enabledFor</td>
            <td><strong>string</strong></td>
            <td>false</td>
            <td>ALL</td>
            <td>
                String of possible options to check against. If more than one option is required, a comma delimited list can be used.
                <ul>
                    <li>"all" - bypasses check and continues to routed page</li>
                    <li>"" - empty string, bypasses check and continues to routed page</li>
                    <li>"param1" - a string to compare against, if it is equal to the string, it will continue to the routes page</li>
                    <li>"param1,param2" - a list of parameters to check against, if one is found it will continue to the routes page</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>enabledForVariable</td>
            <td><strong>string</strong></td>
            <td>false</td>
            <td></td>
            <td>Sets the comparative string used against the enabledFor variable</td>
        </tr>
        <tr>
            <td>enabledForRedirectRoute</td>
            <td><strong>string</strong></td>
            <td>true</td>
            <td></td>
            <td>Sets the route used if the validation check fails</td>
        </tr>
    </tbody>
</table>



<cfsetting enablecfoutputonly="false">
