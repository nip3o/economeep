angular.module('economeep').controller 'StockListCtrl', ($scope, Stock) ->
    $scope.stocks = Stock.query()
