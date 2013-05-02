from django.conf.urls import patterns, url

from .views import UserDetails

urlpatterns = patterns(
    'users.views',

    url(r'^(?P<pk>[0-9]+)/$', UserDetails.as_view(), name='user-detail'),

    url(r'^login/$', 'login', name='login'),
    url(r'^logout/$', 'logout', name='logout'),

    url(r'^current/$', 'current_user', name='current_user'),
)
