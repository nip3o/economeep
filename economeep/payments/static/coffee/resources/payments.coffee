app = angular.module('economeep')

app.factory 'Payment', ($resource) ->
    $resource('payments/')

app.factory 'User', ($resource) ->
    $resource('users/:userId/')


app.service 'Authentication', ($http, $q) ->
    this.getCurrentUser = ->
        deferred = $q.defer()

        $http.get('users/current/')
            .success (data) ->
                deferred.resolve(data)
