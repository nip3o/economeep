angular.module("economeep").filter 'title', ->
    (text) ->
        if text
            text.charAt(0).toUpperCase() + text.slice(1)
