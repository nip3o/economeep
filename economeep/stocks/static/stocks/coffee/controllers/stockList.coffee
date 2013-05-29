angular.module('economeep').controller 'StockListController', ($scope, Stock) ->
    Stock.query().then (result) ->
        $scope.stocks = result
