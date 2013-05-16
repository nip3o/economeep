from rest_framework import serializers

from .models import Category, Payment


class CategorySerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Category
        fields = ('url', 'name', 'payment_sum')

    url = serializers.HyperlinkedIdentityField()
    payment_sum = serializers.FloatField(read_only=True, source='payment_sum')


class PaymentSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Payment
        fields = ('date', 'amount', 'description', 'user', 'category')

    user = serializers.Field()
