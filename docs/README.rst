Compiling the documentation
============================

The documentation is written in reStructuredText, and should be fairly
readable in any text editor or at Github. However, to get full use of
it you need to compile the doucmentation with Sphinx.

Follow the incstructions in docs/install.rst to install dependencies,
and compile the docs with make (while working in this directory)
::

    $ make html
    $ open _build/html/index.html

