from rest_framework import generics
from rest_framework.permissions import IsAuthenticated

from utils.permissions import IsOwner

from .models import Category, Payment
from .serializers import CategorySerializer, PaymentSerializer


class PaymentsList(generics.ListCreateAPIView):
    model = Payment
    serializer_class = PaymentSerializer
    permission_classes = (IsAuthenticated, IsOwner)

    def pre_save(self, payment):
        payment.user = self.request.user

    def get_queryset(self):
        return Payment.objects.filter(user=self.request.user).order_by('-date')


class CategoryList(generics.ListCreateAPIView):
    model = Category
    serializer_class = CategorySerializer

    def get_queryset(self):
        return Category.objects.with_payment_sum()


class CategoryDetails(generics.RetrieveAPIView):
    model = Category
    serializer_class = CategorySerializer
