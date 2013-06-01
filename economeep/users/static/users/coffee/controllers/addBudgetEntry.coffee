angular.module('economeep').controller 'AddBudgetEntryController', ($scope, Budget, Category, categories, ecoDialog) ->
    """
    Controller for the 'add new budget entry' dialog.
    """
    # Get the passed-in budget entry
    $scope.entry = ecoDialog.getData()
    # Set all global categories to scope
    $scope.categories = categories.getAll()

    $scope.save = ->
        $scope.entry.$save().then(
            (entry) ->
                # Replace the selected category URL with a new, fresh
                # category object for that URL from server
                category = Category.get(entry.category).then(
                    (category) ->
                        entry.category = category
                        ecoDialog.close(entry)
                )

        )

    $scope.cancel = -> ecoDialog.close()
