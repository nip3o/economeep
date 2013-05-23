from rest_framework.permissions import IsAuthenticated

from .permissions import IsOwner


class CurrentUserObjectMixin():
    """
    This mixin is useful in rest_framework generic list views. It makes
    sure that the view is used by a logged-in user, who can only view
    and update the objects that she is owner of. When creating new
    objects, the owner of the new object is set to the current user.
    """
    permission_classes = (IsAuthenticated, IsOwner)

    def pre_save(self, obj):
        obj.user = self.request.user

    def get_queryset(self):
        return self.model.objects.filter(user=self.request.user)
