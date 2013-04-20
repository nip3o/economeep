from django.conf.urls import patterns, url

from .views import PaymentsList


urlpatterns = patterns(
    'payments.views',

    url(r'^$', PaymentsList.as_view(), name='payments'),
)
