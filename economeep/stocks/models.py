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

    def __unicode__(self):
        return unicode(self.name)
