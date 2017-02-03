#!/bin/bash
/usr/sbin/nginx -c /etc/nginx/nginx.conf

waitress-serve \
    --port 8001 \
    --ident transmogrify \
    wsgi:app \
    "$@"
