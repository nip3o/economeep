from rest_framework import permissions


class ReadOnly(permissions.BasePermission):
    """
    Read-only permission for all users, regardless of if they are
    authenticated and not.
    """
    def has_object_permission(self, request, view, obj):
        return request.method in permissions.SAFE_METHODS


class IsOwner(permissions.BasePermission):
    """
    Allows permission only for the user owning a specific object
    """
    def has_object_permission(self, request, view, obj):
        return request.user == obj.user
