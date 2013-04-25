from django.conf.urls import patterns, url
from django.views.generic import TemplateView

urlpatterns = patterns(
    'users.views',
    url(r'^login/$', 'login', name='login'),
    url(r'^current/$', 'current_user', name='current_user'),
    url(r'^profile/$', TemplateView.as_view(template_name='users/profile.html'))
)
