angular.module('economeep').factory 'Payment', ($resource) ->
    $resource('payments/', {}, query:
                                method:'GET',
                                isArray:true);
