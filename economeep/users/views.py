from django.contrib.auth.views import login as auth_login

from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response

from .serializers import UserSerializer


def login(request, **kwargs):
    return auth_login(request, template_name='users/login.html')


@api_view(['GET'])
def current_user(request):
    user = request.user

    if not user.is_authenticated():
        return Response(status=status.HTTP_401_UNAUTHORIZED)

    if request.method == 'GET':
        serializer = UserSerializer(user)
        return Response(serializer.data)
