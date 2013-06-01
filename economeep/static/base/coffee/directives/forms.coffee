app = angular.module("economeep")

app.directive 'textinput', ($templateCache) ->
    """
    Element directive that renders a text input box with Bootstrap-wrapper
    classes for styling, bound to a specific model.

    @param id - HTML id for the element
    @param label - Text to use in the form element label
    @param model - The model to bound the element's value to
    @param options - Additional attributes on the form element, for example
                     for HTML5 form validation.
    """
    restrict: "E"
    # Since some of the attributes in the rendered output (such as ng-model)
    # need to be parsed by Angular after being rendered, we use the compile()
    # hook instead of the usual link().
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
    """
    Element directive that renders a select box with Bootstrap-wrapper
    classes for styling, bound to a specific model.

    @param id - HTML id for the element
    @param label - Text to use in the form element label
    @param model - The model to bound the element's value to
    @param choices - Array of choices (with a name and url attribute) to choose from
    @param options - Additional attributes on the form element, for example
                     for HTML5 form validation.
    """
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
    """
    Attribute directive to add a bootstrap-datepicker to the element.

    @param model - The model to bound the selected date to
    """
    restrict: "A"
    link: (scope, element, attrs) ->
        model = $parse(attrs.model)
        element.datepicker({format: "yyyy-mm-dd", weekStart: 1})
               .on 'changeDate', (e) ->
                    formattedDate = angular.copy(e.format())

                    scope.$apply (scope) ->
                        model.assign(scope, formattedDate)
                    element.datepicker('hide')

