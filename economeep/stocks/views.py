from rest_framework import generics


from .models import Stock
from .serializers import StockSerializer


class StockList(generics.ListCreateAPIView):
    model = Stock
    serializer_class = StockSerializer
