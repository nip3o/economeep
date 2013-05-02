app = angular.module("economeep")

app.directive 'textinput', ($templateCache) ->
    restrict: "E"
    compile: (element, attrs) ->
        template = """
        <div class="control-group">
            <label class="control-label" for="#{attrs.id}">#{attrs.label}</label>
            <div class="controls">
                <input id="#{attrs.id}" type="text" ng-model="#{attrs.model}">
            </div>
        </div>
        """
        element.html(template)


app.directive 'selectable', ->
    restrict: "E"
    compile: (element, attrs) ->
        template = """
        <div class="control-group">
            <label class="control-label" for="#{attrs.id}">#{attrs.label}</label>
            <div class="controls">
                <select ng-model="#{attrs.model}">
                    <option ng-repeat="item in #{attrs.choices}" value="{{ item.url }}">{{ item.name }}</option>
                </select>
            </div>
        </div>
        """
        element.html(template)
