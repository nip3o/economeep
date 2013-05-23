from rest_framework import serializers

from .models import Stock


class StockSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Stock
        fields = ('url', 'name', 'short_name', 'currency', 'price')

    url = serializers.HyperlinkedIdentityField()
    price = serializers.DecimalField(read_only=True, required=False,
                                     source='latest_stock_price')
