from rest_framework import generics

from utils.permissions import ReadOnly

from .models import Stock
from .serializers import StockSerializer


class StockList(generics.ListCreateAPIView):
    """ API view for listing all Stocks or creating a new instance. """
    model = Stock
    serializer_class = StockSerializer
    permission_classes = (ReadOnly,)


class StockDetails(generics.RetrieveAPIView):
    """ API view for reading a single Stock instance. """
    model = Stock
    serializer_class = StockSerializer
