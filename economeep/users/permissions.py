from rest_framework import permissions


class BudgetIsOwner(permissions.BasePermission):
    """
    Allows accessing a BudgetEntry if the current user is the owner of it.
    """
    def has_object_permission(self, request, view, entry):
        return request.user == entry.budget.user
