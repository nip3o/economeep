angular.module('economeep').factory 'Payment', (ecoResource) ->
    class Payment extends ecoResource
        @url = 'payments/'
