angular.module('economeep', ['ui.bootstrap.dialog'])

angular.module('economeep').config ($httpProvider) ->
    # For every request, include the CSRF-token as a header. This is required
    # for Django's CSRF validation middleware to allow any request except GET.
    $httpProvider.defaults.headers.post['X-CSRFToken'] = $('body').data('csrftoken')
