Install
=========

To use this project follow these steps:

#. Create your working environment
#. Install Django and additional dependencies
#. Use the Django admin to create the project

Working Environment
===================

You have several options in setting up your working environment.  We recommend
using virtualenv to seperate the dependencies of your project from your system's
python environment.


Clone the repository
---------------------
::

    $ git clone git@github.com:nip3o/tddd27.git


Virtualenv with virtualenvwrapper
----------------------------------

In Linux and Mac OSX, you can install virtualenvwrapper (http://virtualenvwrapper.readthedocs.org/en/latest/),
which will take care of managing your virtual environments and adding the
project path to the `site-directory` for you
::

    $ mkvirtualenv eco
    $ cd economeep && add2virtualenv .


Installation of Dependencies
=============================

Depending on where you are installing dependencies:

In development
::

    $ pip install -r requirements/development.txt

For production
::

    $ pip install -r requirements.txt


Regardless of environment type, you will also need some additional utilities
that typically is easiest to install globally with ``npm`` (the Node.js
package manager). Run the following from the project root directory.
::

    # npm install -g


Environment configuration
==========================
To avoid some teadiuos writing, do the following:

* Alias ``django-admin.py`` to ``dj`` (for example).
* Add ``DJANGO_SETTINGS_MODULE=conf.settings.development`` to your ``$VIRTUAL_ENV/bin/postactivate`` file
::

    $ echo "alias dj='django-admin.py'" >> ~/.bashrc
    $ echo "export DJANGO_SETTINGS_MODULE=conf.settings.development" >> $VIRTUAL_ENV/bin/postactivate


Database configuration
=======================

This assumes that you have a working PostgreSQL database set-up
(http://www.postgresql.org/). By default, the database is called ``economeep``,
but this can be configured using the ``DB_NAME`` environment variable. Assuming that you have
a working postgres-installation, you can log into its superuser account and create a new database
for economeep as below
::

    $ sudo su postgres
    # psql
    > create database economeep;
    > \q
    # exit
    

The database connection settings is configured using environment variables.
Add your credentials to your ``$VIRTUAL_ENV/bin/postactivate`` file in the same way as above.
::

    export DB_USER=my_username
    export DB_PASSWORD=my_secr3t_p4ssw0rd
    
    
Facebook authentication
=======================

This app uses Facebook for authentication. Threrfore, APP_ID and SECRET settings for Facebook must be defined.
::

    export FACEBOOK_APP_ID=my_app_id
    export FACEBOOK_API_SECRET=my_secret

Getting started
================

After reloading your virtualenv (i.e. ``workon eco``), the development server
can be started with ``dj runserver``. You will also need to run database
initialization and migrations.
::

    $ dj syncdb
    $ dj migrate
