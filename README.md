This repository contains the Dockerfile for a container hosting a blast web server.

There are currently two directories that you can pass into the server `/data` and `/var/www/html/db`. `/data` must hold the actual blast databases somewhere. Files under `/var/www/html/db` fall into three categories:

 1. Symbolic links to the actual blast databases in `/data`.
 2. `group`, which replaces `/etc/group` so you can add the `www-data` user to the appropriate groups for read-access to your blast databases (if needed)
 3. HTML files, such as blast.html, which replace those in `/var/www/html`.

In particular, the html files should have your various blast databases selectable.
