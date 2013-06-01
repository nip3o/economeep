angular.module("economeep").directive 'piechart', ->
    """
    Element directive that renders a Highcharts piechart.
    Inspired by https://github.com/rootux/angular-highcharts-directive/
    """

    restrict: "E"
    template: "<div></div>"
    link: (scope, element, attrs) ->
        chart = null

        scope.$watch(
            ->
                # Watch for changes in the data attribute
                attrs.data

            , (newValue, oldValue) ->
                # This promise is run as soon as the attribute is changed

                # Make sure data is loaded
                if not newValue
                    return

                # If this is the first time we have data
                if not chart
                    # Get options from directive attributes, and set these on
                    # the Highcharts settings-object
                    settings = {
                        chart:
                            renderTo: element[0]
                            type: 'pie'
                            height: attrs.height
                            width: attrs.width

                        title:
                            text: attrs.heading

                        tooltip:
                            formatter:
                                -> this.series.name + " <b>" + this.y + "</b> " + attrs.unit

                        series: [
                            name: attrs.name
                            data: JSON.parse(attrs.data)
                        ]
                    }
                    # Create a new chart instance
                    chart = new Highcharts.Chart(settings)

                else
                    # Attributes are converted to strings when passed to the
                    # directive, so we have to convert it back
                    newData = JSON.parse(newValue)

                    # If a new series has been added
                    if newData.length != chart.series[0].data.length
                        # Update the chart with the new data array
                        chart.series[0].setData(newData, true)

                    # Update each data element. Do not redraw the chart.
                    for data, i in chart.series[0].data
                        data.update(newData[i], false)

                    # Redraw the whole chart after updating it
                    chart.redraw()
        )
