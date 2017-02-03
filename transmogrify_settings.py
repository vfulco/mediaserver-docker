# -*- coding: utf-8 -*-
from __future__ import unicode_literals
import os

NO_IMAGE_URL = ''
ORIG_BASE_PATH = os.path.join(os.environ.get('HOMEDIR', '/etc/transmogrify'), 'originals')
BASE_PATH = os.path.join(os.environ.get('HOMEDIR', '/etc/transmogrify'), 'modified')
DEBUG = True
SECRET_KEY = 'n*d%%vr4a3^a0d=gl+vyq$0xfp#=ial9n#-)+*csvctly&fvek'
PATH_ALIASES = {'^assets/': '/'}
# ALLOWED_PROCESSORS = ['r', 'a', 't', 'c', 's', 'r', 'l', 'b', 'f', ]
ALLOWED_PROCESSORS = ['__all__', ]
