# Custom implementation of Angular.js resource, since the original
# implemetation has some flaws related to URLs.
angular.module('economeep').factory 'ecoResource', ($q, $http) ->
    class ecoResource
        # Copy all attributes from the recieved object onto the new object
        constructor: (data) ->
            angular.copy(data, this)


        $save: ->
            deferred = $q.defer()

            $http.post(@constructor.url, this)
                .success (data) =>
                    deferred.resolve(this)
                .error (data) =>
                    deferred.reject(data)

            return deferred.promise

        # Fetch all instances of a resource from API
        @query = ->
            deferred = $q.defer()

            result = []
            $http.get(@url)
                .success (data) =>
                    for item in data
                        result.push(new this(item))
                    deferred.resolve(result)

                .error (data) =>
                    deferred.reject(data)

            return deferred.promise
