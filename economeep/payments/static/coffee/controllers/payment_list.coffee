angular.module('economeep').controller 'PaymentListCtrl', ($dialog, $scope, $rootScope, $templateCache, Payment, Authentication) ->
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

    $scope.addPayment = ->
        item = 3
        d = $dialog.dialog()
        $rootScope.dialog = d;
        d.open('addPaymentForm', 'AddPaymentController').then(-> console.log "clooosed")


angular.module('economeep').controller 'AddPaymentController', ($scope, $rootScope) ->
    $scope.payment = {amount: 0}

    $scope.close = -> $rootScope.dialog.close()
