angular.module('economeep').controller 'PaymentListCtrl',
($dialog, $scope, $rootScope, $templateCache, Category, Payment, User, $http) ->
    User.getCurrent().then(
        (user) ->
            $scope.logged_in = true
            $scope.user = user

            Payment.query().then (payments) ->
                $scope.payments = payments

            Category.query().then (categories) ->
                $scope.categories = categories
                $scope.paymentsChartData = (
                    [c.name, parseFloat(c.payment_sum, 10)] for c in categories)
        ,
        (error) ->
            $scope.logged_in = false
    )


    $scope.addData = ->
        $scope.paymentsChartData.push(['Niclas', 3])

    $scope.updateData = ->
        $scope.paymentsChartData[0][1] += 1

    $scope.logOut = ->
        $scope.user.logOut().then(
            (response) ->
                console.log "Logged out"
                $scope.logged_in = false
        )

    $scope.addPayment = ->
        d = $dialog.dialog()

        # TODO
        $rootScope.dialog = d
        $rootScope.categories = $scope.categories

        d.open('addPaymentForm', 'AddPaymentController').then(
            (payment)->
                if payment
                    $scope.payments.push(payment)
        )


angular.module('economeep').controller 'AddPaymentController', ($scope, $rootScope, Payment) ->
    $scope.payment = new Payment({description: '', amount: ''})

    $scope.save = ->
        $scope.payment.$save().then((data) -> console.log data)
        $rootScope.dialog.close($scope.payment)

    $scope.cancel = -> $rootScope.dialog.close()
