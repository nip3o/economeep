import datetime

from rest_framework.permissions import IsAuthenticated

from .permissions import IsOwner


class UserObjectMixin(object):
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


class DateFilterMixin(object):
    """
    This mixin is useful for filtering querysets by month.
    """
    def date_filter(self, qs):
        """
        Filters the qs queryset by month if a 'date' parameter is
        passed-in as query parameter to the request.
        """
        date = self.request.QUERY_PARAMS.get('date', None)

        if date:
            date = datetime.datetime.strptime(date, '%Y-%m-%d')
            qs = qs.for_month(date.year, date.month)

        return qs


class UserObjectDateFilterMixin(UserObjectMixin, DateFilterMixin):
    """
    Basically a UserObjectMixin that filters the result by month
    using a DateFilterMixin.
    """
    def get_queryset(self):
        qs = UserObjectMixin.get_queryset(self)
        return DateFilterMixin.date_filter(self, qs)
