from model_utils.managers import PassThroughManager

from django.db import models
from django.db.models import Sum
from django.utils.translation import ugettext_lazy as _
from django.contrib.auth.models import User


class CategoryQuerySet(models.query.QuerySet):
    """
    A CategoryQuerySet is being used like a custom model-manager, but
    since we also want it to be chainable (which custom managers are not
    by default), we have to create a custom QuerySet and generate a
    manager from it by using model_utils PassThroughManager.

    A really good article regarding this subject:
    http://dabapps.com/blog/higher-level-query-api-django-orm/
    """
    def with_payment_sum(self):
        return self.annotate(payment_sum=Sum('payment__amount'))

    def non_empty(self):
        return self.filter(payment_sum__gt=0)

    def for_month(self, year, month):
        return self.filter(payment__date__year=year,
                           payment__date__month=month)


class PaymentQuerySet(models.query.QuerySet):
    def for_month(self, year, month):
        return self.filter(date__year=year,
                           date__month=month)


class Category(models.Model):
    """
    A Category represents a certain category of payments, i.e. food,
    transport, entertainment or similar.
    """
    class Meta:
        verbose_name = _('category')
        verbose_name_plural = _('categories')

    def __unicode__(self):
        return unicode(self.name)

    # Create a chainable manager from the CategoryQuerySet declared above
    objects = PassThroughManager.for_queryset_class(CategoryQuerySet)()

    name = models.CharField(max_length=50)

    def get_payment_sum(self):
        return self.payment_set.aggregate(s=Sum('amount'))['s']


class Payment(models.Model):
    """
    A Payment is a one-time occurring transaction for a specific user,
    with a fixed amount and for a specific date.
    """
    class Meta:
        verbose_name = _('payment')
        verbose_name_plural = _('payments')

    def __unicode__(self):
        return '%.2f %s' % (self.amount, unicode(self.description))

    objects = PassThroughManager.for_queryset_class(PaymentQuerySet)()

    date = models.DateField(_('date'))
    amount = models.DecimalField(_('amount'), decimal_places=2, max_digits=12)
    description = models.TextField(_('description'), blank=True)

    category = models.ForeignKey(Category)
    user = models.ForeignKey(User)
