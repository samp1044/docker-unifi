# docker-unifi
Dockerfile for the latest unifi server software

### Build Docker image

Use the script in `scripts/buildcontainer.sh`.

Parameters are:
- Dockerfile location (usually in `docker/Dockerfile`)
- Context location (also `./docker`)

```
./scripts/buildcontainer.sh ./docker/Dockerfile ./docker
```

### Run the image

Either use the script in `scripts/restartcontainer.sh` with the Parameters:
- Location of config and db folders

or the following command:

```
docker run -d \
	-p 3478:3478/udp \
	-p 8080:8080 \
	-p 8443:8443 \
	-p 8843:8843 \
	-p 8880:8880 \
	-p 10001:10001/udp \
	-v $USERH/config:/var/lib/unifi -v $USERH/logs:/var/log/unifi --name=unifi --cap-add DAC_READ_SEARCH unifi ./start.sh
```

with `USERH` being the location of config, logs and db on your local machine/server.

### Automate

I usually use the following cron entry to always have the latest unifi controller running on my server:

```
0 6 * * 3 /path/to/home/updatecontainers.sh && /path/to/home/restartcontainers.sh
```

with `updatecontainers.sh` containing the following commands:

```
#!/bin/sh

cd /path/to/repo
./scripts/buildcontainer.sh ./docker/Dockerfile ./docker > /path/to/some/logfolder/update.log
```

and `restartcontainers.sh`:

```
cd /path/to/repo
./scripts/restartcontainer.sh /path/to/unifi/config > /path/to/some/logfolder/restart.log 2>&1
```
