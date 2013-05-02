from django.db import models
from django.utils.translation import ugettext_lazy as _
from django.contrib.auth.models import User


class Category(models.Model):
    class Meta:
        verbose_name = _('category')
        verbose_name_plural = _('categories')

    name = models.CharField(max_length=50)

    def __unicode__(self):
        return unicode(self.name)


class Payment(models.Model):
    class Meta:
        verbose_name = _('payment')
        verbose_name_plural = _('payments')

    date = models.DateField(_('date'))
    amount = models.DecimalField(_('amount'), decimal_places=2, max_digits=12)
    description = models.TextField(_('description'))

    category = models.ForeignKey(Category)
    user = models.ForeignKey(User)

    def __unicode__(self):
        return '%.2f %s' % (self.amount, unicode(self.description))
