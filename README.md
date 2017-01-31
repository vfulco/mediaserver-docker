# National Geographic Media Server

An nGinx front-end with transmogrify adding dynamic thumbnailing.

Modified to handle storage from S3

## Building instructions

```
$ docker build -t ngs-mediaserver:latest .
```

When you are ready to deploy, tag it with a version number:

```
$ docker tag ngs-mediaserver:latest ngs-mediaserver:1.2.3
```

## Running or testing the image

```
docker run -ti \
    -p 8000:8000 \
    --add-host dockerhost:$DOCKERHOST \
    --name ngs-container \
    ngs:latest \
    bash
```

## system packages

System packages go in `system-requirements.txt`

## Python requirements

Python packages are managed through requirements.txt