from django.contrib import admin
from django.conf.urls import patterns, include, url
from django.views.generic import TemplateView

from rest_framework.urlpatterns import format_suffix_patterns

from payments.views import CategoryList, CategoryDetails
from users.views import BudgetList, BudgetEntryCreate, BudgetDetails, BudgetEntryDetails

# Set up internal URLs for admin. Must be done before patterns are set up.
admin.autodiscover()


urlpatterns = patterns(
    '',

    # Global third-party views
    url(r'', include('social_auth.urls')),

    # Base views
    url(r'^$', TemplateView.as_view(template_name='base.html')),

    # Django admin
    url(r'^admin/', include(admin.site.urls)),

    # Apps
    url(r'^payments/', include('payments.urls')),
    url(r'^stocks/', include('stocks.urls')),
    url(r'^users/', include('users.urls')),

    # API enties without own apps...
    url(r'^categories/$', CategoryList.as_view(), name='category-list'),
    url(r'^categories/(?P<pk>[0-9]+)/$', CategoryDetails.as_view(), name='category-detail'),

    url(r'^budgets/$', BudgetList.as_view(), name='budget-list'),
    url(r'^budgets/(?P<pk>[0-9]+)/$', BudgetDetails.as_view(), name='budget-detail'),

    url(r'^budget-entries/$', BudgetEntryCreate.as_view(), name='budgetentry-create'),
    url(r'^budget-entries/(?P<pk>[0-9]+)/$', BudgetEntryDetails.as_view(), name='budgetentry-detail'),

)

# Add support for document extension suffixes (such as .json, .yml) in API
urlpatterns = format_suffix_patterns(urlpatterns)
