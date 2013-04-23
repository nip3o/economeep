angular.module('economeep').factory 'Stock', ($resource) ->
    $resource('stocks', {}, query:
                                method:'GET',
                                isArray:true);
