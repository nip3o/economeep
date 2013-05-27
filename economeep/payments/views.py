import datetime

from rest_framework import generics

from utils.mixins import CurrentUserObjectMixin

from .models import Category, Payment
from .serializers import CategorySerializer, PaymentSerializer


class PaymentsList(CurrentUserObjectMixin, generics.ListCreateAPIView):
    """
    API view for fetching all Payment instances belonging to the current
    user or create a new Payment.
    """
    model = Payment
    serializer_class = PaymentSerializer

    def get_queryset(self):
        qs = CurrentUserObjectMixin.get_queryset(self)

        date = self.request.QUERY_PARAMS.get('date', None)
        if date:
            date = datetime.datetime.strptime(date, '%Y-%m-%d')
            qs = qs.for_month(date.year, date.month)

        return qs.order_by('-date')


class CategoryList(generics.ListCreateAPIView):
    """ API view for fetching all categories or create a new Category. """
    model = Category
    serializer_class = CategorySerializer

    def get_queryset(self):
        return Category.objects.with_payment_sum()


class CategoryDetails(generics.RetrieveAPIView):
    """ API view for reading a single Category instance. """
    model = Category
    serializer_class = CategorySerializer
