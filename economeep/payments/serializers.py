from rest_framework import serializers

from .models import Category, Payment


class CategorySerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Category
        fields = ('url', 'name',)

    url = serializers.HyperlinkedIdentityField()


class PaymentSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Payment
        fields = ('date', 'amount', 'description', 'user', 'category')

    user = serializers.Field()
