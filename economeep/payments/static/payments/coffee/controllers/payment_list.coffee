angular.module('economeep').controller 'PaymentListCtrl',
($dialog, $scope, $rootScope, $templateCache, Payment, User, $http) ->
    User.getCurrent().then(
        (user) ->
            $scope.logged_in = true
            $scope.user = user

            Payment.query().then((payments) -> $scope.payments = payments)
        ,
        (error) ->
            $scope.logged_in = false
    )

    $scope.paymentsChartData = {
        chart: {
            type: 'bar'
            renderTo: $('#chart')
        },
        title: {
            text: 'Fruit Consumption'
        },
        xAxis: {
            categories: ['Apples', 'Bananas', 'Oranges']
        },
        yAxis: {
            title: {
                text: 'Fruit eaten'
            }
        },
        series: [{
            name: 'Jane',
            data: [1, 0, 4]
        }, {
            name: 'John',
            data: [5, 7, 3]
        }],
    }

    $scope.logOut = ->
        $scope.user.logOut().then(
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
        $scope.payment.$save().then((data) -> console.log data)
        $rootScope.dialog.close($scope.payment)

    $scope.cancel = -> $rootScope.dialog.close()
