The economeep API
******************

economeep has a darn fine RESTful API that can be used to access some
even more awesome data. The API is fully browsable in your favourite
browser, so feel free to learn by just clicking around.


URL endpoints
=============

URLs for each resource is listed below. Just add it to the end of your
running server URL in your browser to begin exploring the API.

* /payments
* /stocks
* /users
* /categories
* /budgets
* /budget-entries

For example, to explore the Payments API if you have a server running on
``localhost:8000``, visit http://localhost:8000/payments/.


Authentication
==============

Authentication is done through the built-in ``django.contrib.auth`` module.
The API provides functionality to get information about the current
logged-in user at GET ``/users/current``.

.. autofunction:: users.views.current_user()


The user can be logged out by sending a POST ``/users/logout``.

.. autofunction:: users.views.logout()

Formats
=======
The results is returned in JSON format by default. To get the results in
YAML or XML format, just add ``/.yml`` or ``/.xml`` to the end of the URL.


List of API views
=================

List vies is mapped to the URL endpoint for each resource, i.e. */resource*
Detail views is mapped to */resource/<pk>*.

Categories and Payments
-----------------------
.. automodule:: payments.views
    :members:


Stocks
------
.. automodule:: stocks.views
    :members:


Users, Budgets and Budget entries
---------------------------------
.. automodule:: users.views
    :members:
