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
angular.module("economeep").directive 'piechart', ->
    restrict: "E"
    template: "<div></div>"

    link: (scope, element, attrs) ->
        settings = {
            chart:
                renderTo: element[0]
                type: 'pie'
                height: attrs.height
                width: attrs.width

            title:
                text: attrs.heading

            series: [
                name: attrs.name
                data: JSON.parse(attrs.data)
            ]
        }
        chart = new Highcharts.Chart(settings)

        scope.$watch(
            ->
                attrs.data
            , (newValue, oldValue) ->
                if newValue != oldValue
                    newData = JSON.parse(newValue)

                    if newData.length != chart.series[0].data.length
                        chart.series[0].setData(newData, true)
                    else
                        for data, i in chart.series[0].data
                            data.update(newData[i])
        )
