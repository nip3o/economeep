angular.module('economeep').factory 'Budget', (ecoResource, $q, $http) ->
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
