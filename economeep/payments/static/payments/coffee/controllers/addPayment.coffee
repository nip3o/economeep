angular.module('economeep').controller 'AddPaymentController', ($scope, ecoDialog, Payment, categories) ->
    $scope.payment = new Payment({description: '', amount: ''})
    $scope.categories = categories.getAll()

    $scope.save = ->
        $scope.payment.$save().then(
            (payment)->
               ecoDialog.close(payment)

        )

    $scope.cancel = -> ecoDialog.close()
