angular.module('economeep').factory 'ecoDialog', ($dialog) ->
    dialog = {}
    data = null

    open: (template, controller, item=null) ->
        data = item
        dialog = $dialog.dialog()
        dialog.open(template, controller)

    close: (item) -> dialog.close(item)

    getData: -> data
