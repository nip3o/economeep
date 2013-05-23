import celery
import urllib
import urllib2

from decimal import Decimal
from datetime import datetime
from lxml import objectify
from stocks.models import Stock

API_URL = "http://www.nasdaq.com/aspx/ELS/ELSHandler.ashx?%s"


@celery.task
def get_price_for_all_stocks():
    for stock in Stock.objects.all():
        get_price_for_stock.delay(stock.pk)


@celery.task
def get_price_for_stock(stock_id):
    stock = Stock.objects.get(pk=stock_id)

    params = {'msg': 'Last', 'Symbol': stock.short_name}
    xml = objectify.parse(urllib2.urlopen(API_URL % urllib.urlencode(params)))

    result = xml.getroot().getchildren()[0]
    stock.stockprice_set.create(
        price=Decimal(unicode(result.Price)),
        datetime=datetime.strptime(unicode(result.tradetimestamp), '%Y-%m-%d %H:%M:%S'))
