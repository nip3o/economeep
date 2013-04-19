from django.conf.urls import patterns, include, url
from django.views.generic import TemplateView

from .views import StockList


urlpatterns = patterns(
    'stocks.views',
    
    url(r'^$', StockList.as_view(), name='stock_list'),
#    url(r'^(?P<pk>[0-9]+)$', 'stock_detail', name='stock_detail'),
)
