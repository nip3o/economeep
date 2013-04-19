angular.module('economeepServices', ['ngResource']).
    factory('Stock', ($resource) ->
        return $resource('stocks', {},
                         query:
                             method:'GET',
                             isArray:true);
    );
