from django.contrib.auth import logout as auth_logout
from django.contrib.auth.views import login as auth_login

from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response

from .serializers import UserSerializer


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
