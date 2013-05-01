angular.module('economeep').controller 'StockListCtrl', ($scope, Stock) ->
    Stock.query().then (result) ->
        $scope.stocks = result
