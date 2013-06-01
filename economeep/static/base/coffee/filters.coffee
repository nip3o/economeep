angular.module("economeep").filter 'title', ->
    """
    Capitalizes the first character of the filtered string.
    """
    (text) ->
        if text
            text.charAt(0).toUpperCase() + text.slice(1)
