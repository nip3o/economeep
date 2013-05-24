angular.module('economeep').controller 'PaymentsController',
($dialog, $scope, $rootScope, $templateCache, Category, Budget, Payment, User, $http) ->
    $scope.categories = []

    # Transform the categories into Highcharts-readable
    updateChartData = (newCategories, oldCategories) ->
        if newCategories != oldCategories
            chartData = []
            for c in newCategories
                paymentSum = parseFloat(c.payment_sum, 10)
                if paymentSum > 0
                    chartData.push([c.name, paymentSum])
            $scope.paymentsChartData = chartData

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

            Budget.byDate(new Date()).then (budget) ->
                $scope.budget = budget
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

    $scope.addCategory = ->
        d = $dialog.dialog()

        $rootScope.dialog = d

        d.open('addCategoryForm', 'AddCategoryController').then(
            (category)->
                $scope.categories.push(category)
        )


angular.module('economeep').controller 'AddPaymentController', ($scope, $rootScope, Payment) ->
    $scope.payment = new Payment({description: '', amount: ''})

    $scope.save = ->
        $scope.payment.$save().then(
            (payment)->
                $rootScope.dialog.close(payment)

        )

    $scope.cancel = -> $rootScope.dialog.close()



angular.module('economeep').controller 'AddCategoryController', ($scope, $rootScope, Category) ->
    $scope.category = new Category({name: ''})

    $scope.save = ->
        $scope.category.$save().then(
            (category)->
                $rootScope.dialog.close(category)
        )

    $scope.cancel = -> $rootScope.dialog.close()
