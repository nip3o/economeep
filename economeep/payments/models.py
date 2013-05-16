from model_utils.managers import PassThroughManager

from django.db import models
from django.db.models import Sum
from django.utils.translation import ugettext_lazy as _
from django.contrib.auth.models import User


class CategoryQuerySet(models.query.QuerySet):
    """
    This class is basically just like a regular Manager, but since we also
    want it to be chainable (which custom managers are not by default),
    we have to create a custom QuerySet and generate a manager from it by
    using model_utils PassThroughManager.

    A really good article regarding this subject:
    http://dabapps.com/blog/higher-level-query-api-django-orm/
    """
    def with_payment_sum(self):
        return self.annotate(payment_sum=Sum('payment__amount'))

    def for_month(self, year, month):
        return self.filter(payment__date__year=year,
                           payment__date__month=month)


class Category(models.Model):
    class Meta:
        verbose_name = _('category')
        verbose_name_plural = _('categories')

    def __unicode__(self):
        return unicode(self.name)

    name = models.CharField(max_length=50)

    # Create a chainable manager from the CategoryQuerySet declared above
    objects = PassThroughManager.for_queryset_class(CategoryQuerySet)()


class Payment(models.Model):
    class Meta:
        verbose_name = _('payment')
        verbose_name_plural = _('payments')

    def __unicode__(self):
        return '%.2f %s' % (self.amount, unicode(self.description))

    date = models.DateField(_('date'))
    amount = models.DecimalField(_('amount'), decimal_places=2, max_digits=12)
    description = models.TextField(_('description'), blank=True)

    category = models.ForeignKey(Category)
    user = models.ForeignKey(User)
