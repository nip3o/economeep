angular.module('economeep').factory 'Category', (ecoResource) ->
    class Category extends ecoResource
        @url = 'categories/'
