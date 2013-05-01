# Custom implementation of Angular.js resource, since the original
# implemetation has some flaws related to URLs.
angular.module('economeep').factory 'ecoResource', ($q, $http) ->
    class ecoResource
        @query = ->
            deferred = $q.defer()

            result = []
            $http.get(@url)
                .success (data) =>
                    for item in data
                        result.push(new this(item))

                    deferred.resolve(result)

            return deferred.promise
