angular.module('economeep').factory 'Budget', (ecoResource, Category, BudgetEntry, $q, $http, $filter) ->
    class Budget extends ecoResource
        @url = 'budgets/'

        @byDate = (date) ->
            deferred = $q.defer()

            $http.get(@url + '?' + $.param({'date': date.getTime()}))
                    .success (data) ->
                        deferred.resolve(new Budget(data))
                    .error (data) ->
                        deferred.reject(data)

            return deferred.promise

        @convertFromServer = (data) ->
            if data
                newEntries = []
                # The Date-constructor in JS is magic!
                data.month_start_date = new Date(data.month_start_date)

                for entry in data.budget_entries
                    entry = new BudgetEntry(entry)
                    # Due to float arithmetric error risk, Decimals is serialized
                    # as strings, so we need to deserialize them here.
                    entry.amount = parseFloat(entry.amount)
                    entry.category = new Category(entry.category)
                    newEntries.push(entry)

                data.budget_entries = newEntries
            return data

        @convertToServer = (data) ->
            data.month_start_date = $filter('date')(data.month_start_date, "yyyy-MM-dd")
            return data
