import celery
import urllib
import urllib2
from decimal import Decimal
from lxml import objectify

from stocks.models import Stock
from utils.date import string_to_datetime


API_URL = "http://www.nasdaq.com/aspx/ELS/ELSHandler.ashx?%s"


@celery.task
def get_price_for_all_stocks():
    """
    Celery task for fetching stock prices for all exisiting Stocks.
    """
    for stock in Stock.objects.all():
        get_price_for_stock.delay(stock.pk)


@celery.task
def get_price_for_stock(stock_id):
    """
    Get the price for the Stock with the specified ID.

    Since Celery tasks in theory can wait in the task queue for a very
    long time before being run, we never pass in objects directly to them,
    but rather an ID so the task can get a fresh version of the object.
    """
    stock = Stock.objects.get(pk=stock_id)

    # Send a GET-request to the API
    params = {'msg': 'Last', 'Symbol': stock.short_name}
    xml = objectify.parse(urllib2.urlopen(API_URL % urllib.urlencode(params)))

    # Get the first stock price element of the response (there should
    # always only be exactly such element in our case).
    result = xml.getroot().getchildren()[0]

    # Save the price to DB
    stock.stockprice_set.create(
        price=Decimal(unicode(result.Price)),
        datetime=string_to_datetime(unicode(result.tradetimestamp)))
