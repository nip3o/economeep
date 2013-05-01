from django.contrib import admin
from django.conf.urls import patterns, include, url
from django.views.generic import TemplateView

from rest_framework.urlpatterns import format_suffix_patterns


# Set up internal URLs for admin. Must be done before patterns are set up.
admin.autodiscover()


urlpatterns = patterns(
    '',

    # Global third-party views
    url(r'', include('social_auth.urls')),
    url(r'^api/', include('rest_framework.urls', namespace='rest_framework')),

    # Base views
    url(r'^$', TemplateView.as_view(template_name='base.html')),

    # Django admin
    url(r'^admin/', include(admin.site.urls)),

    # Apps
    url(r'^payments/', include('payments.urls')),
    url(r'^stocks/', include('stocks.urls')),
    url(r'^users/', include('users.urls')),
)

# Add support for document extension suffixes (such as .json, .yml) in API
urlpatterns = format_suffix_patterns(urlpatterns)
