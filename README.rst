IRC Bouncer Docker
==================

My IRC bouncer setup consists of a single Docker image: znc-image.

This image looks in the ``ZNC_DATA_DIR`` specified in the ``Makefile`` for the data directory (the directory that contains the ``configs``, ``modules``, ``moddata``, and ``modules`` directories).

Installation
============

1. Create the following directories under the ``ZNC_DATA_DIR`` (which is ``/var/znc`` by default):
  
  - configs
  - moddata
  - modules
  - users

2. Copy your ``znc.conf`` into ``$ZNC_DATA_DIR/configs``.
3. Copy your ``znc.pem`` to the location you specified in your ``znc.conf``.
4. Run ``make build`` to build the Docker images.
5. Run ``make start`` to start the images.

Backups
=======

Run ``make backup-config`` to backup the ``znc.conf`` file into a ``backups`` directory.

Run ``make backup-data`` to backup the ``.znc/users`` directory into an archive.
