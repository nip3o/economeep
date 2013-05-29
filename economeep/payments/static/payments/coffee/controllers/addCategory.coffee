angular.module('economeep').controller 'AddCategoryController', ($scope, ecoDialog, Category) ->
    $scope.category = new Category({name: ''})

    $scope.save = ->
        $scope.category.$save().then(
            (category)->
                ecoDialog.close(category)
        )

    $scope.cancel = -> ecoDialog.close()
