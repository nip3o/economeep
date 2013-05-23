from rest_framework import generics

from utils.permissions import ReadOnly

from .models import Stock
from .serializers import StockSerializer


class StockList(generics.ListCreateAPIView):
    model = Stock
    serializer_class = StockSerializer
    permission_classes = (ReadOnly,)


class StockDetails(generics.RetrieveAPIView):
    model = Stock
    serializer_class = StockSerializer
