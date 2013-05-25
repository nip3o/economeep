from rest_framework import serializers

from django.contrib.auth.models import User

from payments.serializers import CategorySerializer
from users.models import Budget, BudgetEntry


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('first_name', 'last_name')


class BudgetEntrySerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = BudgetEntry
        fields = ('url', 'budget', 'amount', 'category')

    url = serializers.HyperlinkedIdentityField()
    category = CategorySerializer()


class BudgetEntryDeserializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = BudgetEntry
        fields = ('url', 'budget', 'amount', 'category')


class BudgetSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Budget
        fields = ('url', 'month_start_date', 'budget_entries')

    url = serializers.HyperlinkedIdentityField()
    budget_entries = BudgetEntrySerializer(many=True)
