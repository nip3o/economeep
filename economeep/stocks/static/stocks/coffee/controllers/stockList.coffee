angular.module('economeep').controller 'StockListController', ($scope, Stock) ->
    """
    Controller for the list of stocks and their current price.
    """
    Stock.query().then (result) ->
        $scope.stocks = result
