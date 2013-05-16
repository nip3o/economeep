app = angular.module("economeep")

app.directive 'textinput', ($templateCache) ->
    restrict: "E"
    compile: (element, attrs) ->
        template = """
        <div class="control-group">
            <label class="control-label" for="#{attrs.id}">#{attrs.label}</label>
            <div class="controls">
                <input id="#{attrs.id}" type="text" ng-model="#{attrs.model}" #{attrs.options}>
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
                <select ng-model="#{attrs.model}" #{attrs.options}>
                    <option ng-repeat="item in #{attrs.choices}" value="{{ item.url }}">{{ item.name }}</option>
                </select>
            </div>
        </div>
        """
        element.html(template)


app.directive 'datepicker', ($parse) ->
    restrict: "A"
    link: (scope, element, attrs) ->
        model = $parse(attrs.model)
        element.datepicker({format: "yyyy-mm-dd", weekStart: 1})
               .on 'changeDate', (e) ->
                    formattedDate = angular.copy(e.format())

                    scope.$apply (scope) ->
                        model.assign(scope, formattedDate)
                    element.datepicker('hide')

