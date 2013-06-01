angular.module('economeep').factory 'User', (ecoResource, $q, $http) ->
    class User extends ecoResource
        @url = 'users/'

        logOut: ->
            """ Log out the current user. """
            deferred = $q.defer()

            $http.post(@constructor.url + 'logout/')
                 .success ->
                    deferred.resolve()
                .error (data) ->
                    deferred.reject(data)

            return deferred.promise


        @getCurrent: ->
            """ Fetches the currently logged-in user. """
            deferred = $q.defer()

            $http.get(@url + 'current/')
                    .success (data) ->
                        deferred.resolve(new User(data))
                    .error (data) ->
                        deferred.reject(data)

            return deferred.promise
