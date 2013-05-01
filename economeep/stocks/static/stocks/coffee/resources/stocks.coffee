angular.module('economeep').factory 'Stock', (ecoResource) ->
    class Stock extends ecoResource
        @url = 'stocks/'
