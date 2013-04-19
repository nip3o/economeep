angular.module('EconomeepApp').controller 'StockListCtrl', ($scope, Stock) ->
    $scope.stocks = Stock.query()
