angular.module('economeep', ['ngResource'])

angular.module('economeep').config ($httpProvider) ->
    $httpProvider.defaults.headers.post['X-CSRFToken'] = $('body').data('csrftoken')
