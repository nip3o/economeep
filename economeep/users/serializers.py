from rest_framework import serializers

from django.contrib.auth.models import User

from users.models import Budget, BudgetEntry


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('first_name', 'last_name')


class BudgetSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Budget
        fields = ('url', 'budget_entries')

    url = serializers.HyperlinkedIdentityField()


class BudgetEntrySerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = BudgetEntry
        fields = ('amount', 'category')
