#!/bin/bash
/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf

waitress_serve \
    wsgi:application \
    --port 8001 \
    --ident transmogrify \
    "$@"
