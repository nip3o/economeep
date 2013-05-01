app = angular.module('economeep')

app.factory 'User', (ecoResource, $q, $http) ->
    class User extends ecoResource
        @url = 'users/'

        logOut: ->
            deferred = $q.defer()

            $http.post('users/logout/')
                 .success ->
                    deferred.resolve()
                .error (data) ->
                    deferred.reject(data)

            return deferred.promise


        @getCurrent: ->
            deferred = $q.defer()

            $http.get('users/current/')
                    .success (data) ->
                        deferred.resolve(new User(data))
                    .error (data) ->
                        deferred.reject(data)

            return deferred.promise
