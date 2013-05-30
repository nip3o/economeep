angular.module('economeep').controller 'PaymentsController',
($dialog, $scope, $rootScope, $templateCache, Category, Budget, BudgetEntry, Payment, User, $http, categories, ecoDialog) ->
    $scope.statsByURL = []

    # Get the logged-in user
    User.getCurrent().then(
        (user) ->
            $scope.logged_in = true
            $scope.user = user

            categories.fetchFromServer()
            currentDate = new Date()
            getDataForDateMonth(currentDate)
        ,
        (error) ->
            $scope.logged_in = false
    )

    getDataForDateMonth = (date) ->
        # Fetch Payments and Categories for the same date's month
        Payment.byDate(date).then (payments) ->
            $scope.payments = payments

        Category.byDate(date).then (stats) ->
            $scope.statsByURL = []
            $scope.stats = stats

            # Fetch or create a Budget for a date and add the Budget to scope
            Budget.byDate(date).then(
                (budget) ->
                    for e in budget.budget_entries
                        e.category = $scope.statsByURL[e.category]
                    $scope.budget = budget
                ,
                (error) ->
                    $scope.budget = new Budget(month_start_date: date, budget_entries: [])
                    $scope.budget.$save().then(
                        (budget) ->
                            $scope.budget = budget
                    )
            )

    # Transform the categories into Highcharts-readable format
    updateChartData = (newCategories, oldCategories) ->
        if newCategories != oldCategories
            chartData = []
            for c in newCategories
                chartData.push([c.name, c.payment_sum])
            $scope.paymentsChartData = chartData

    # Update chart data when categories change
    $scope.$watch('stats', updateChartData, true)

    updateStatsByURL = (newStats, oldStats) ->
        for s in categories.getAll()
            s.payment_sum = 0
            $scope.statsByURL[s.url] = s

        if newStats != oldStats
            # Update the array holding the current stats
            for s in newStats
                $scope.statsByURL[s.url] = s

    $scope.$watch('stats', updateStatsByURL, true)


    addMonths = (date, months) ->
        date.setMonth(date.getMonth() + months)
        return date

    sameMonth = (d1, d2) ->
        d1.getMonth() == d2.getMonth() and d1.getYear() == d2.getYear()


    $scope.logOut = ->
        $scope.user.logOut().then(
            (response) ->
                console.log "Logged out"
                $scope.logged_in = false
        )

    $scope.previousMonth = ->
        prevMonthDate = addMonths($scope.budget.month_start_date, -1)
        getDataForDateMonth(prevMonthDate)


    $scope.nextMonth = ->
        nextMonthDate = addMonths($scope.budget.month_start_date, 1)
        getDataForDateMonth(nextMonthDate)


    $scope.addBudgetEntry = ->
        entry = new BudgetEntry(budget: $scope.budget.url, amount: '')

        ecoDialog.open('addBudgetEntryForm', 'AddBudgetEntryController', entry).then(
            (entry)->
                $scope.budget.budget_entries.push(entry)
        )


    $scope.addPayment = ->
        ecoDialog.open('addPaymentForm', 'AddPaymentController').then(
            (payment)->
                if payment and sameMonth(new Date(payment.date),
                                         $scope.budget.month_start_date)
                    category = $scope.statsByURL[payment.category]
                    amount = parseFloat(payment.amount)
                    category.payment_sum += amount

                    if category.payment_sum == amount
                        $scope.stats.push(angular.copy(category))

                    payment.category = category
                    $scope.payments.push(payment)
        )

    $scope.addCategory = ->
        ecoDialog.open('addCategoryForm', 'AddCategoryController').then(
            (category)->
                categories.add(category)
        )
