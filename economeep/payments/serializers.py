from rest_framework import serializers

from .models import Category, Payment


class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields = ('name', 'id')


class PaymentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Payment
        fields = ('date', 'amount', 'description', 'user', 'category')

    user = serializers.Field(source='user.username')
