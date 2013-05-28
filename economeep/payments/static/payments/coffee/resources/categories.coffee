angular.module('economeep').factory 'Category', (ecoResource) ->
    class Category extends ecoResource
        @url = 'categories/'

        @convertFromServer = (entry) ->
            entry.payment_sum = parseFloat(entry.payment_sum)
            return entry
