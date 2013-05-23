from django.conf.urls import patterns, url

from .views import StockList, StockDetails


urlpatterns = patterns(
    'stocks.views',

    url(r'^$', StockList.as_view(), name='stocks'),
    url(r'^(?P<pk>[0-9]+)$', StockDetails.as_view(), name='stock-detail'),
)
