# Custom implementation of Angular.js resource, since the original
# implemetation has some flaws related to URLs.
angular.module('economeep').factory 'ecoResource', ($q, $http, $filter) ->
    typeIsArray = Array.isArray || ( value ) -> return {}.toString.call( value ) is '[object Array]'

    class ecoResource
        # Copy all attributes from the recieved object onto the new object
        constructor: (data) ->
            angular.copy(@constructor.convertFromServer(data), this)

        # Hook for converting attributes on the object sent by server,
        # before creating a resource class of the object
        @convertFromServer = (data) -> data

        @convertToServer = (data) -> data

        $save: ->
            deferred = $q.defer()

            data = {}
            angular.copy(this, data)

            $http.post(@constructor.url, @constructor.convertToServer(data))
                .success (data) =>
                    this.url = data.url
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

        # Get objects filtered by date
        @byDate = (date) ->
            deferred = $q.defer()

            dateString = $filter('date')(date, "yyyy-MM-dd")
            $http.get(@url + '?' + $.param({'date': dateString}))
                .success (data) =>
                    if typeIsArray(data)
                        result = []
                        for item in data
                            result.push(new this(item))
                        deferred.resolve(result)
                    else
                        deferred.resolve(new this(data))

                .error (data) =>
                    deferred.reject(data)

            return deferred.promise

        # Get a specific object instance
        @get = (instanceUrl) ->
            deferred = $q.defer()

            result = []
            $http.get(instanceUrl)
                .success (data) =>
                    deferred.resolve(new this(data))

                .error (data) =>
                    deferred.reject(data)

            return deferred.promise
