angular.module('economeep').controller 'PaymentsController',
($dialog, $scope, $rootScope, $templateCache, Category, Budget, BudgetEntry, Payment, User, $http) ->
    $scope.categories = []

    addMonths = (date, months) ->
        date.setMonth(date.getMonth() + months)
        return date

    getOrCreateBudget = (date) ->
        Budget.byDate(date).then(
            (budget) ->
                $scope.budget = budget
            ,
            (error) ->
                $scope.budget = new Budget(month_start_date: date, budget_entries: [])
                $scope.budget.$save().then(
                    (budget) ->
                        # Update the local budget with the one from server
                        $scope.budget = budget
                )
        )

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

            getOrCreateBudget(new Date())
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

    $scope.previousMonth = ->
        prevMonthDate = addMonths($scope.budget.month_start_date, -1)
        getOrCreateBudget(prevMonthDate)

    $scope.nextMonth = ->
        nextMonthDate = addMonths($scope.budget.month_start_date, 1)
        getOrCreateBudget(nextMonthDate)


    $scope.addBudgetEntry = ->
        d = $dialog.dialog()

        $rootScope.dialog = d
        $rootScope.categories = $scope.categories
        $rootScope.entry = new BudgetEntry(budget: $scope.budget.url,
                                           amount: '')

        d.open('addBudgetEntryForm', 'AddBudgetEntryController').then(
            (entry)->
                $scope.budget.budget_entries.push(entry)
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


angular.module('economeep').controller 'AddBudgetEntryController', ($scope, $rootScope, Budget, Category) ->
    $scope.entry = $rootScope.entry

    $scope.save = ->
        $scope.entry.$save().then(
            (entry) ->
                # Replace the selected category URL with a new, fresh
                # category object for that URL from server
                category = Category.get(entry.category).then(
                    (category) ->
                        entry.category = category
                        $rootScope.dialog.close(entry)
                )

        )

    $scope.cancel = -> $rootScope.dialog.close()
