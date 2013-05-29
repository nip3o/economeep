angular.module('economeep').factory 'categories', (Category) ->
    categories = []

    add: (category) ->
        categories.push(category)

    fetchFromServer: ->
        Category.query().then (c) ->
            categories = c

    getAll: -> categories
