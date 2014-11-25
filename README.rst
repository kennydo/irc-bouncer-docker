irc-bouncer-docker
==================

My IRC bouncer setup consists of two Docker images: kennydo/znc and kennydo/znc-data.

The znc-data image is a `data volume container <https://docs.docker.com/userguide/dockervolumes/#creating-and-mounting-a-data-volume-container>`_ that holds the ``.znc`` directory.

Installation
============

#. Copy your ``znc.pem`` and your ``znc.conf`` files into the `znc-data-image` directory.
#. Run ``make build`` to build the Docker images.
#. Run ``make start`` to start the images.

Backups
=======

Run ``make backup-config`` to backup the ``znc.conf`` file into a ``backups`` directory.

Run ``make backup-data`` to backup the ``.znc/users`` directory into an archive.
