from rest_framework import serializers

from .models import Category, Payment


class PaymentSumField(serializers.DecimalField):
    def field_to_native(self, category, field_name):
        # Querysets for newly saved objects does not have the
        # payment_sum-attribute.
        if hasattr(category, 'payment_sum'):
            return category.payment_sum
        return category.get_payment_sum()


class CategorySerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Category
        fields = ('url', 'name', 'payment_sum')

    url = serializers.HyperlinkedIdentityField()
    payment_sum = PaymentSumField(read_only=True, required=False)


class PaymentSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Payment
        fields = ('date', 'amount', 'description', 'user', 'category')

    user = serializers.Field()
