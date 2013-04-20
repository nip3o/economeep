angular.module('economeep', ['ngResource']).factory 'Stock', ($resource) ->
    $resource('stocks', {}, query:
                                method:'GET',
                                isArray:true);
