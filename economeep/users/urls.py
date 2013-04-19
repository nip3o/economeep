from django.conf.urls import patterns, include, url
from django.views.generic import TemplateView

urlpatterns = patterns(
    'users.views',
    url(r'^login$', 'login', name='login'),
)
