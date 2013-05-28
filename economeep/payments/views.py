from rest_framework import generics

from utils.mixins import DateFilterMixin, UserObjectDateFilterMixin

from .models import Category, Payment
from .serializers import CategorySerializer, PaymentSerializer


class PaymentsList(UserObjectDateFilterMixin, generics.ListCreateAPIView):
    """
    API view for fetching all Payment instances belonging to the current
    user or create a new Payment.
    """
    model = Payment
    serializer_class = PaymentSerializer

    def get_queryset(self):
        # super() may be ambigous when using multiple inheritance with
        # overloaded methods, as in this case, so use class name instead
        qs = UserObjectDateFilterMixin.get_queryset(self)
        return qs.order_by('-date')


class CategoryList(DateFilterMixin, generics.ListCreateAPIView):
    """ API view for fetching all categories or create a new Category. """
    model = Category
    serializer_class = CategorySerializer

    def get_queryset(self):
        qs = Category.objects.with_payment_sum()
        return DateFilterMixin.date_filter(self, qs)


class CategoryDetails(generics.RetrieveAPIView):
    """ API view for reading a single Category instance. """
    model = Category
    serializer_class = CategorySerializer
