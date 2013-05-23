from rest_framework import generics

from utils.mixins import CurrentUserObjectMixin

from .models import Category, Payment
from .serializers import CategorySerializer, PaymentSerializer


class PaymentsList(CurrentUserObjectMixin, generics.ListCreateAPIView):
    model = Payment
    serializer_class = PaymentSerializer

    def get_queryset(self):
        return CurrentUserObjectMixin.get_queryset(self).order_by('-date')


class CategoryList(generics.ListCreateAPIView):
    model = Category
    serializer_class = CategorySerializer

    def get_queryset(self):
        return Category.objects.with_payment_sum()


class CategoryDetails(generics.RetrieveAPIView):
    model = Category
    serializer_class = CategorySerializer
