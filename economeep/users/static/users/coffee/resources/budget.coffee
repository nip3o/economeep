angular.module('economeep').factory 'Budget', (ecoResource, Category, BudgetEntry, $q, $http) ->
    class Budget extends ecoResource
        @url = 'budgets/'

        @byDate = (date) ->
            deferred = $q.defer()

            $http.get(@url + '?' + $.param({'date': date.getTime()}))
                    .success (data) ->
                        deferred.resolve(new Budget(data[0])) # TODO
                    .error (data) ->
                        deferred.reject(data)

            return deferred.promise

        @convertFromServer = (data) ->
            newEntries = []
            # The Date-constructor in JS is magic!
            data.date = new Date(data.date)

            for entry in data.budget_entries
                entry = new BudgetEntry(entry)
                entry.category = new Category(entry.category)
                newEntries.push(entry)

            data.budget_entries = newEntries
            return data
