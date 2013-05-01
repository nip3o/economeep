angular.module('economeep').controller 'PaymentListCtrl', ($dialog, $scope, $rootScope, $templateCache, Payment, Authentication) ->
    promise = Authentication.getCurrentUser()
    promise.then(
        (response) ->
            $scope.logged_in = true
            $scope.user = response.data

            Payment.query().then((payments) -> $scope.payments = payments)
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
        d = $dialog.dialog()
        $rootScope.dialog = d;

        d.open('addPaymentForm', 'AddPaymentController').then(
            (payment)->
                if payment
                    $scope.payments.push(payment)
        )


angular.module('economeep').controller 'AddPaymentController', ($scope, $rootScope, Payment) ->
    $scope.payment = new Payment({description: '', amount: ''})

    $scope.save = ->
        $scope.payment.$save()
        $rootScope.dialog.close($scope.payment)

    $scope.cancel = -> $rootScope.dialog.close()
