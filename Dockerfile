FROM alpine:3.5

ENV BASE_PACKAGES="dumb-init \
  musl \
  linux-headers \
  build-base \
  bash \
  git"

COPY system-requirements.txt $HOMEDIR/system-requirements.txt
RUN echo \
  # replacing default repositories with edge ones
  && echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" > /etc/apk/repositories \
  && echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
  && echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \

  # Add the packages, with a CDN-breakage fallback if needed
  && apk add --no-cache $BASE_PACKAGES `cat $HOMEDIR/system-requirements.txt` || \
    (sed -i -e 's/dl-cdn/dl-4/g' /etc/apk/repositories && apk add --no-cache $PACKAGES) \

  # make some useful symlinks that are expected to exist
  && if [[ ! -e /usr/bin/python ]];        then ln -sf /usr/bin/python2.7 /usr/bin/python; fi \
  && if [[ ! -e /usr/bin/python-config ]]; then ln -sf /usr/bin/python2.7-config /usr/bin/python-config; fi \
  && if [[ ! -e /usr/bin/easy_install ]];  then ln -sf /usr/bin/easy_install-2.7 /usr/bin/easy_install; fi \

  # Install and upgrade Pip
  && easy_install pip \
  && pip install --upgrade pip \
  && if [[ ! -e /usr/bin/pip ]]; then ln -sf /usr/bin/pip2.7 /usr/bin/pip; fi \

  && echo

# Compile the S3 Filesystem
RUN echo \
  && git clone https://github.com/s3fs-fuse/s3fs-fuse.git \
  && cd s3fs-fuse \
  && ./autogen.sh \
  && ./configure --prefix=/usr \
  && make \
  && make install \
  && cd .. \
  && rm -rf s3fs-fuse

# Chaining the ENV allows for only one layer, instead of one per ENV statement
ENV HOMEDIR=/etc/transmogrify \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    PYTHONUNBUFFERED=1

WORKDIR $HOMEDIR

# Copying this file over so we can install requirements.txt in one cache-able layer
COPY requirements.txt $HOMEDIR/
RUN pip install --upgrade pip \
  && pip install -r $HOMEDIR/requirements.txt

COPY nginx-conf/nginx.conf /etc/nginx/nginx.conf

# Copy the code
COPY . $HOMEDIR
ENV TRANSMOGRIFY_SETTINGS=transmogrify_settings \
    TRANSMOGRIFY_ORIG_BASE_PATH=$HOMEDIR/originals \
    TRANSMOGRIFY_BASE_PATH=$HOMEDIR/modified
RUN mkdir $HOMEDIR/originals $HOMEDIR/modified
EXPOSE 8000
CMD ["sh", "-c", "$HOMEDIR/docker-entrypoint.sh"]
