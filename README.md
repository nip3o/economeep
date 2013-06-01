===========
economeeep
===========

A project in the course **TDDD27** - Advanced Web Programming, VT-2013

**Niclas Olofsson**, nicol271@student.liu.se


Gitlab vs. Github
------------------
Gitlab lacks support for REST documents, so reading the source at Github
is recommended. However, except from this README file, the content is the same.

https://github.com/nip3o/economeep


Screencast
-----------
www.youtube.com/watch?v=7PzGtbyu6NI


Folder structure
-----------------
Some folders have their own README-files that specifies the contents of
that specific folder.

* ``./docs`` - documentation
* ``./economeep`` - project source code, see ``./economeep/README.rst``
* ``./requirements`` - files for specifying project dependencies

An overview of files can be found in ``docs/files.rst``


Installation
-------------
For installation instructions, see ``docs/install.rst``


Functional specification
-------------------------

Economeep is a economy and budget tool for keeping track of a student's
economy. Users can log in and add purchases and other expenses to
different categories. These categories are summed for different time
periods, and a budget with goals for each category can be set up.  Users
may also track their stocks and follow the economical development of the
stocks.


Technical specification
------------------------

Django 1.5 will be used as the server-side framework. The open source
toolkit ``django-rest-framework`` will be used to create a RESTful API,
since it seems like a good way to make creation of BAAS-applications
easier. The server and client will communicate via AJAX, by sending JSON
(which is far more conveinient than XML since it is natively well-
supported in the Python standard library as well as in Javascript).

The standard Django ORM will be used, with a traditional PostgreSQL
database as storage backend. Authentication will be handled via some
OAuth-based service/services such as Facebook, using ``django-social-auth``.

On the client side, AngularJS and jQuery will be used. I have previously
used jQuery quite a lot, but I am especially keen on getting to know how
things can be done in a different and more elegant way by using
AngularJS.

Testing will be prioritized over more features. Unit-testing on the
client-side with tools such as Karma will be prioritized over slow
integration-testing with Selenium or similar tools. ``py.test`` and ``py
.test-django`` could be used for unit-testing on the server-side.

It seems currently hard to find open API:s for stock data, but internal
API:s that could be used and probably would work fine for a small school
project does exist. Data should preferrably be fetched in the background
and cached in the database or a cache, instead of on a per-request
basis, by using someting like ``django-celery``.
