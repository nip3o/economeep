Install
=========

To use this project follow these steps:

#. Create your working environment
#. Install Django and additional dependencies
#. Use the Django admin to create the project

*note: these instructions show creation of a project called "icecream".  You
should replace this name with the actual name of your project.*


Working Environment
===================

You have several options in setting up your working environment.  We recommend
using virtualenv to seperate the dependencies of your project from your system's
python environment.


Clone the repository
---------------------
::
    $ git clone ...


Virtualenv with virtualenvwrapper
--------------------------

In Linux and Mac OSX, you can install virtualenvwrapper (http://virtualenvwrapper.readthedocs.org/en/latest/),
which will take care of managing your virtual environments and adding the
project path to the `site-directory` for you::

    $ mkvirtualenv eco
    $ cd economeep && add2virtualenv .


Installation of Dependencies
=============================

Depending on where you are installing dependencies:

In development::

    $ pip install -r requirements/local.txt

For production::

    $ pip install -r requirements.txt


Database configuration
=======================

This assumes that you have a working PostgreSQL database set-up
(http://www.postgresql.org/). By default, the database is called ``economeep``,
but this can be configured using the ``DB_NAME`` environment variable.

The database connection settings is configured using environment variables.
Add your credentials to your ``~/.virtualenvs/eco/bin/postactivate`` file::

    export DB_USER=my_username
    export DB_PASSWORD=my_secr3t_p4ssw0rd
