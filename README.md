Note that this repository is primarily useful for our local setup. If you need your own instance, you should be able to modify this easily enough.

This repository contains the Dockerfile for a container hosting a blast web server.

There are currently two directories that you can pass into the server `/data` and `/var/www/html/blast/db`. `/data` must hold the actual blast databases somewhere. Files under `/var/www/html/blast/db` fall into three categories:

 1. Symbolic links to the actual blast databases in `/data`.
 2. `group`, which replaces `/etc/group` so you can add the `www-data` user to the appropriate groups for read-access to your blast databases (if needed)
 3. HTML and .rc files, such as blast.html, which replace those in `/var/www/html/blast`. Make sure to make a new `index.html` too.

In particular, the html files should have your various blast databases selectable.

Usage
-----

Firstly, make sure to copy `/etc/group` to `/var/www/html/blast/db/group` and modify it as needed. Likewise, copy the appropriate html and .rc files from `/var/www/html/blast` to `/var/www/html/blast/db` and edit them as needed.

Actual usage is something of the form:

    docker run -d -p 8080:80 -v /root/blast_config:/var/www/html/blast/db -v /data/some_group/repository:/data docker-blast
