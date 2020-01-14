Note that this repository is primarily useful for our local setup. If you need your own instance, you should be able to modify this easily enough.

This repository contains the Dockerfile for a container hosting a SequenceServer/blast web server.

Databases are passed in via the `db` mount point, which must contain symlinks to directories with blast databases.

Usage
-----

Actual usage is something of the form:

    docker run -d -p 8080:8080 --privileged --cap-add=ALL -v /root/blast_config:/db docker-blast
