angular.module('economeep').controller 'PaymentListCtrl', ($scope, Payment, Authentication) ->
    $scope.logged_in = true
#    $scope.payments = Payment.query()
    promise = Authentication.getCurrentUser()
    promise.then(
        (data) ->
            $scope.user = data
        ,
        (message) ->
            if message.status == 404
                console.log "Hittades inte"
    )
