angular.module("economeep").directive 'textinput', ($templateCache) ->
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


angular.module("economeep").directive 'highchart', ->
    restrict: "E"
    template: "<div>Helluu</div>"

    link: (scope, element, attrs) ->
        defaults = {
            chart:
                type: attrs.type ? null
                height: attrs.height ? null
                width: attrs.width ? null
        }

        settings = {}
        $.extend(true, settings, defaults, JSON.parse(attrs.value))

        element.highcharts(settings)
