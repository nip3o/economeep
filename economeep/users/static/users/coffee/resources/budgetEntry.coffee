angular.module('economeep').factory 'BudgetEntry', (ecoResource) ->
    class BudgetEntry extends ecoResource
        @url = 'budget-entries/'
