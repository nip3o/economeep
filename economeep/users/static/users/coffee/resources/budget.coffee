angular.module('economeep').factory 'Budget', (ecoResource, Category, BudgetEntry, $q, $http, $filter) ->
    class Budget extends ecoResource
        @url = 'budgets/'

        @convertFromServer = (data) ->
            newEntries = []
            # The Date-constructor in JS is magic!
            data.month_start_date = new Date(data.month_start_date)

            for entry in data.budget_entries
                entry = new BudgetEntry(entry)
                # Due to float arithmetric error risk, Decimals is serialized
                # as strings, so we need to deserialize them here.
                entry.amount = parseFloat(entry.amount)
                newEntries.push(entry)

            data.budget_entries = newEntries
            return data

        @convertToServer = (data) ->
            data.month_start_date = $filter('date')(data.month_start_date, "yyyy-MM-dd")
            return data
