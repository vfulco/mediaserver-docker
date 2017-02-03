# National Geographic Media Server

An nGinx front-end with transmogrify adding dynamic thumbnailing.

Modified to handle storage from S3

The ECS task definition must contain `AWSACCESSKEYID` and `AWSSECRETACCESSKEY`.

## Building instructions

```
$ docker build -t ngs-mediaserver:latest .
```

When you are ready to deploy, tag it with a version number:

```
$ docker tag ngs-mediaserver:latest ngs-mediaserver:1.2.3
```

## Running or testing the image

In order to test the image with S3, you must create a `.env` file with
`AWSACCESSKEYID` and `AWSSECRETACCESSKEY` set.

```
./docker-run.sh
```

If you want to  get to a shell (or run another command), add the command after:

```
./docker-run.sh bash
```

## system packages

System packages go in `system-requirements.txt`

## Python requirements

Python packages are managed through requirements.txt