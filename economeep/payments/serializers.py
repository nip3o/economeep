from rest_framework import serializers

from .models import Payment


class PaymentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Payment
        fields = ('date', 'amount', 'description', 'user')

    user = serializers.Field(source='user.username')
