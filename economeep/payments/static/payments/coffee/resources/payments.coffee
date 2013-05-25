angular.module('economeep').factory 'Payment', (ecoResource) ->
    class Payment extends ecoResource
        @url = 'payments/'

        @convertFromServer (data) ->
            data.amount = parseFloat(data.amount)
