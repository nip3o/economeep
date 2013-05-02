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

# Highcharts directive
# Inspired by https://github.com/rootux/angular-highcharts-directive/
angular.module("economeep").directive 'highchart', ->
    restrict: "E"
    template: "<div></div>"

    link: (scope, element, attrs) ->
        defaults = {
            chart:
                renderTo: element[0]
                type: attrs.type ? null
                height: attrs.height ? null
                width: attrs.width ? null

            title:
                text: attrs.heading ? null
        }
        settings = {}
        $.extend(true, settings, defaults, JSON.parse(attrs.value))
        chart = new Highcharts.Chart(settings)

        scope.$watch(->
                        attrs.value
                    , (newValue, oldValue) ->
                        if newValue != oldValue
                            newValue = JSON.parse(newValue)

                            for serie, i in chart.series
                                serie.setData(newValue.series[i].data, false)

                            chart.redraw()
        )
