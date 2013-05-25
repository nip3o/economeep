from django.contrib.auth import logout as auth_logout
from django.contrib.auth.views import login as auth_login
from django.contrib.auth.models import User

from rest_framework import status, generics
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated

from utils.mixins import CurrentUserObjectMixin

from .serializers import (UserSerializer, BudgetSerializer,
                          BudgetEntryDeserializer, BudgetEntrySerializer)
from .permissions import BudgetIsOwner
from .models import Budget, BudgetEntry


def login(request, **kwargs):
    return auth_login(request, template_name='users/login.html')


@api_view(['POST'])
def logout(request):
    auth_logout(request)
    return Response()


@api_view(['GET'])
def current_user(request):
    user = request.user

    if not user.is_authenticated():
        return Response(status=status.HTTP_401_UNAUTHORIZED)

    serializer = UserSerializer(user)
    return Response(serializer.data)


class UserDetails(generics.RetrieveAPIView):
    model = User
    serializer_class = UserSerializer


class BudgetList(CurrentUserObjectMixin, generics.ListCreateAPIView):
    model = Budget
    serializer_class = BudgetSerializer


class BudgetDetails(generics.RetrieveAPIView):
    model = Budget
    serializer_class = BudgetSerializer


class BudgetEntryCreate(generics.CreateAPIView):
    model = BudgetEntry
    serializer_class = BudgetEntryDeserializer


class BudgetEntryDetails(generics.ListAPIView):
    model = BudgetEntry
    permission_classes = (IsAuthenticated, BudgetIsOwner)
    serializer_class = BudgetEntrySerializer
