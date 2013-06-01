"""
Custom implementation of Angular.js resource, since the original
implemetation is very limited and also has some flaws related to URLs.

A resource is simply a wrapper for creating and fetching model instances,
not unlike the Django ORM.

ecoResource is the base class for all resources.
"""
angular.module('economeep').factory 'ecoResource', ($q, $http, $filter) ->
    # Utility function needed for array checking
    typeIsArray = Array.isArray || ( value ) -> return {}.toString.call( value ) is '[object Array]'

    class ecoResource
        # Copy all attributes from the recieved object onto the new object
        constructor: (data) ->
            angular.copy(@constructor.convertFromServer(data), this)

        """
        convertFromServer is a hook for converting attributes on the
        object sent by server, before creating a resource class of the object.
        """
        @convertFromServer = (data) -> data

        """
        convertToServer is a hook for converting attributes on objects
        that are being sent to the server.
        """
        @convertToServer = (data) -> data

        $save: ->
            """ Saves the object by sending a POST-request to the resource URL. """
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

        @query = ->
            """ Fetches all instances of a resource from API. """
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

        @byDate = (date) ->
            """ Fetches objects filtered by a given date. """
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

        @get = (instanceUrl) ->
            """ Fetches a specific object instance by URL. """
            deferred = $q.defer()

            result = []
            $http.get(instanceUrl)
                .success (data) =>
                    deferred.resolve(new this(data))

                .error (data) =>
                    deferred.reject(data)

            return deferred.promise
