from rest_framework import permissions


class BudgetIsOwner(permissions.BasePermission):
    def has_object_permission(self, request, view, entry):
        return request.user == entry.budget.user
