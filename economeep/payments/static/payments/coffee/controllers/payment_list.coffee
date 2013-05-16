angular.module('economeep').controller 'PaymentListCtrl',
($dialog, $scope, $rootScope, $templateCache, Category, Payment, User, $http) ->
    $scope.categories = []

    # Transform the categories into Highcharts-readable
    updateChartData = (newCategories, oldCategories) ->
        if newCategories != oldCategories
            $scope.paymentsChartData = (
                [c.name, parseFloat(c.payment_sum, 10)] for c in newCategories)

    # Update chart data when categories change
    $scope.$watch('categories', updateChartData, true)

    User.getCurrent().then(
        (user) ->
            $scope.logged_in = true
            $scope.user = user

            Payment.query().then (payments) ->
                $scope.payments = payments

            Category.query().then (categories) ->
                $scope.categories = categories
        ,
        (error) ->
            $scope.logged_in = false
    )

    $scope.logOut = ->
        $scope.user.logOut().then(
            (response) ->
                console.log "Logged out"
                $scope.logged_in = false
        )

    $scope.addPayment = ->
        d = $dialog.dialog()

        $rootScope.dialog = d
        $rootScope.categories = $scope.categories

        d.open('addPaymentForm', 'AddPaymentController').then(
            (payment)->
                if payment
                    Category.query().then (categories) ->
                        $scope.categories = categories
                        $scope.payments.push(payment)
        )


angular.module('economeep').controller 'AddPaymentController', ($scope, $rootScope, Payment) ->
    $scope.payment = new Payment({description: '', amount: ''})

    $scope.save = ->
        $scope.payment.$save().then(
            (payment)->
                $rootScope.dialog.close(payment)
            ,
            (error) ->

        )



    $scope.cancel = -> $rootScope.dialog.close()
