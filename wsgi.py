from transmogrify import wsgi

def app(environ, start_response):
    return wsgi.app(environ, start_response)

