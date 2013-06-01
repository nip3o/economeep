angular.module('economeep').controller 'PaymentsController',
($dialog, $scope, $rootScope, $templateCache, Category, Budget, BudgetEntry, Payment, User, $http, categories, ecoDialog) ->
    $scope.statsByURL = []

    # Get the logged-in user
    User.getCurrent().then(
        (user) ->
            # If a user is logged in
            $scope.logged_in = true
            $scope.user = user

            # Init the global category service which contains categories
            # which are selectable in the popup dialogs.
            categories.fetchFromServer()

            # Get data for this month
            currentDate = new Date()
            getDataForDateMonth(currentDate)
        ,
        (error) ->
            $scope.logged_in = false
    )

    getDataForDateMonth = (date) ->
        """ Fetches Payments and Categories for the specified date's month """

        Payment.byDate(date).then (payments) ->
            $scope.payments = payments

        Category.byDate(date).then (stats) ->
            $scope.statsByURL = []
            $scope.stats = stats

            # Fetch or create a Budget for a date and add the Budget to scope
            Budget.byDate(date).then(
                (budget) ->
                    # Update each entry to have a reference to the category
                    # object, in order for payment sums to update when
                    # a category is updated.
                    for e in budget.budget_entries
                        e.category = $scope.statsByURL[e.category]
                    $scope.budget = budget
                ,
                (error) ->
                    # No budget defined fot this month, create a new one and save it
                    $scope.budget = new Budget(month_start_date: date, budget_entries: [])
                    $scope.budget.$save().then(
                        (budget) ->
                            # Set the new budget as the current one
                            $scope.budget = budget
                    )
            )

    updateChartData = (newCategories, oldCategories) ->
        """
        Transforms the categories (with sum of payments) into
        Highcharts-readable format. Called as soon as the $scope.stats
        variable is updated (since we using $watch below)
        """
        if newCategories != oldCategories
            chartData = []
            for c in newCategories
                chartData.push([c.name, c.payment_sum])
            $scope.paymentsChartData = chartData

    # Update chart data when categories change
    $scope.$watch('stats', updateChartData, true)

    updateStatsByURL = (newStats, oldStats) ->
        """
        $scope.statsByURL is an alternative representation of $scope.stats,
        which is used to find the category object for a specific URL,
        without fetching it from the server again. This function is run
        as soon as $scope.stats updates.
        """
        for s in categories.getAll()
            s.payment_sum = 0
            $scope.statsByURL[s.url] = s

        if newStats != oldStats
            # Update the array holding the current stats
            for s in newStats
                $scope.statsByURL[s.url] = s

    $scope.$watch('stats', updateStatsByURL, true)


    addMonths = (date, months) ->
        """ Add (or subtract if negative) months from a date. """
        date.setMonth(date.getMonth() + months)
        return date

    sameMonth = (d1, d2) ->
        """ Check if two dates belongs to the same month. """
        d1.getMonth() == d2.getMonth() and d1.getYear() == d2.getYear()


    $scope.logOut = ->
        """ Sends a request to log out the current user. """
        $scope.user.logOut().then(
            (response) ->
                $scope.logged_in = false
        )

    $scope.previousMonth = ->
        """ Fetches data for the previous month """
        prevMonthDate = addMonths($scope.budget.month_start_date, -1)
        getDataForDateMonth(prevMonthDate)


    $scope.nextMonth = ->
        """ Fetches data for the next month """
        nextMonthDate = addMonths($scope.budget.month_start_date, 1)
        getDataForDateMonth(nextMonthDate)


    $scope.addBudgetEntry = ->
        """ Open a dialog for creating a new budget row. """
        entry = new BudgetEntry(budget: $scope.budget.url, amount: '')

        # Open a new dialog, using the specified Angular-template and
        # controller, passing the variable 'entry' as data.
        ecoDialog.open('addBudgetEntryForm', 'AddBudgetEntryController', entry).then(
            (entry)->
                if entry
                    # Save button on dialog was clicked, add the entry
                    $scope.budget.budget_entries.push(entry)
        )


    $scope.addPayment = ->
        """ Open a dialog for creating a new payment. """
        ecoDialog.open('addPaymentForm', 'AddPaymentController').then(
            (payment)->
                # if save button on dialog was clicked and we added something
                # to the current month
                if payment and sameMonth(new Date(payment.date),
                                         $scope.budget.month_start_date)

                    # In retrospective, doing this by requesting the
                    # category again from the server would be much less hairy.

                    # Get the category object for the selected category
                    category = $scope.statsByURL[payment.category]
                    # Update payment sum of the category
                    amount = parseFloat(payment.amount)
                    category.payment_sum += amount

                    # Category without any payments before, we need to
                    # add it to the stats array
                    if category.payment_sum == amount
                        $scope.stats.push(angular.copy(category))

                    # add the payment to list
                    payment.category = category
                    $scope.payments.push(payment)
        )

    $scope.addCategory = ->
        """ Open a dialog for creating a new category. """
        ecoDialog.open('addCategoryForm', 'AddCategoryController').then(
            (category)->
                if category
                    # Save button on dialog was clicked, add the entry
                    categories.add(category)
        )
