angular.module('economeep').controller 'PaymentListCtrl', ($scope, Payment, Authentication) ->
    promise = Authentication.getCurrentUser()
    promise.then(
        (response) ->
            $scope.logged_in = true
            $scope.user = response.data
            $scope.payments = Payment.query()
        ,
        (error) ->
            $scope.logged_in = false
    )

    $scope.logOut = ->
        Authentication.logOut().then(
            (response) ->
                console.log "Logged out"
                $scope.logged_in = false
        )
