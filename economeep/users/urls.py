from django.conf.urls import patterns, url

urlpatterns = patterns(
    'users.views',
    url(r'^login/$', 'login', name='login'),
    url(r'^logout/$', 'logout', name='logout'),

    url(r'^current/$', 'current_user', name='current_user'),
)
