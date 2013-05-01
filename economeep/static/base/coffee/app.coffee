angular.module('economeep', ['ui.bootstrap.dialog'])

angular.module('economeep').config ($httpProvider) ->
    $httpProvider.defaults.headers.post['X-CSRFToken'] = $('body').data('csrftoken')
