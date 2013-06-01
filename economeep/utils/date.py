import datetime


def string_to_date(date_string):
    """ Converts a ISO 8601 date string into a datetime object. """
    return datetime.datetime.strptime(date_string, '%Y-%m-%d')


def string_to_datetime(datetime_string):
    """ Converts a ISO 8601 datetime string into a datetime object. """
    return datetime.datetime.strptime(datetime_string, '%Y-%m-%d %H:%M:%S')
