from rest_framework import generics
from rest_framework.permissions import IsAuthenticated

from utils.permissions import IsOwner

from .models import Payment
from .serializers import PaymentSerializer


class PaymentsList(generics.ListCreateAPIView):
    model = Payment
    serializer_class = PaymentSerializer
    permission_classes = (IsAuthenticated, IsOwner)

    def pre_save(self, payment):
        payment.user = self.request.user

    def get_queryset(self):
        return Payment.objects.filter(user=self.request.user)
