from django.db import models
from django.utils.translation import ugettext_lazy as _

from model_utils import Choices


class Stock(models.Model):
    class Meta:
        verbose_name = _('stock')
        verbose_name_plural = _('stocks')

    CURRENCY = Choices('SEK', 'USD')

    name = models.CharField(max_length=40)
    short_name = models.CharField(max_length=10)
    currency = models.CharField(choices=CURRENCY, max_length=10)

    def latest_stock_price(self):
        try:
            return self.stockprice_set.latest().price
        except StockPrice.DoesNotExist:
            return None

    def __unicode__(self):
        return unicode(self.name)


class StockPrice(models.Model):
    class Meta:
        verbose_name = _('stock price')
        verbose_name_plural = _('stock prices')
        get_latest_by = 'datetime'

    stock = models.ForeignKey(Stock)

    price = models.DecimalField(_('price'), decimal_places=2, max_digits=12)
    datetime = models.DateTimeField()

    def __unicode__(self):
        return "%s, %.2f" % (unicode(self.stock), self.price)
