import datetime

from django.contrib.auth import logout as auth_logout
from django.contrib.auth.views import login as auth_login
from django.contrib.auth.models import User
from django.shortcuts import get_object_or_404

from rest_framework import status, generics, mixins
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated

from utils.mixins import CurrentUserObjectMixin

from .serializers import (UserSerializer, BudgetSerializer, BudgetDeserializer,
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
    """
    Resturns the currently logged-in user, or HTTP 401 if no user is logged-in
    """
    user = request.user

    if not user.is_authenticated():
        return Response(status=status.HTTP_401_UNAUTHORIZED)

    serializer = UserSerializer(user)
    return Response(serializer.data)


class UserDetails(generics.RetrieveAPIView):
    model = User
    serializer_class = UserSerializer


class BudgetList(CurrentUserObjectMixin,
                 mixins.CreateModelMixin, generics.RetrieveAPIView):
    """
    These views is a test of a slightly more low-level and customized API view
    than the rest, mostly since I wanted to test how well Django REST Framwork
    suits for non-standard API views.

    A more sane way to do this would be to create one RetrieveAPIView for
    getting the Budget, and one CreateView for creating new entries.
    But that would be boring and non-educational. =)
    """
    model = Budget
    serializer_class = BudgetSerializer

    def get_object(self):
        # This function is called when issuing GET on a RetrieveAPIView,
        # and should return a single model instance queryset
        qs = super(BudgetList, self).get_queryset()

        date = self.request.QUERY_PARAMS.get('date', None)
        if date:
            date = datetime.datetime.fromtimestamp(int(date) / 1000)
            qs = qs.for_month(date.year, date.month)

        return get_object_or_404(qs)

    def post(self, request, *args, **kwargs):
        # Called when issuing POST, creates a new object.
        serializer = BudgetDeserializer(data=request.DATA)

        if serializer.is_valid():
            self.pre_save(serializer.object)
            self.object = serializer.save()

            headers = self.get_success_headers(serializer.data)
            return Response(serializer.data, status=status.HTTP_201_CREATED,
                            headers=headers)

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


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
