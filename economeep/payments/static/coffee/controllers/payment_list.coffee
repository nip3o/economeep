angular.module('economeep').controller 'PaymentListCtrl', ($scope, Payment) ->
    $scope.logged_in = true
    $scope.payments = Payment.query()
