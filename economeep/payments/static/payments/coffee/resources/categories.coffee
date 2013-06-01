angular.module('economeep').factory 'Category', (ecoResource) ->
    class Category extends ecoResource
        @url = 'categories/'

        @convertFromServer = (entry) ->
            # Decimal is serialized as string, we want to convert it
            # something numeric instead.
            entry.payment_sum = parseFloat(entry.payment_sum)
            return entry
