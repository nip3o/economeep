from rest_framework import generics

from utils.permissions import ReadOnly

from .models import Stock
from .serializers import StockSerializer


class StockList(generics.ListCreateAPIView):
    """
    This class-based view is a RESTful API for reading stock data.
    """
    model = Stock
    serializer_class = StockSerializer
    permission_classes = (ReadOnly,)
