# docker alpine php

PHP-FPM v7.0.15

[inspired by https://hub.docker.com/r/matriphe/alpine-php/~/dockerfile/](https://hub.docker.com/r/matriphe/alpine-php/~/dockerfile/)

## environment variables

- TIMEZONE: default "Europe/Berlin"
- USERNAME: default "php"
- USERID: default "1000": change to UID of your user running this container
- MAX_UPLOAD: default 2000M
- PHP_MEMORY_LIMIT: default 128M
- PHP_MAX_FILE_UPLOAD: default 200
- PHP_MAX_POST: default 2100M
