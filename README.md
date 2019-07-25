# docker-apcupsd-cgi
> [apcupsd-cgi](https://packages.debian.org/jessie/apcupsd-cgi) and [lighttpd](https://www.lighttpd.net/) debian-based image.

## How to use this image

#### Dockerfile

```
FROM honzahommer/apcupsd-cgi
...
```

#### Docker run

```
docker run --detach --restart always --mount type=bind,source=$PWD/hosts.conf,target=/etc/apcupsd/hosts.conf,readonly --publish 8888:80 --name apcupds-cgi honzahommer/apcupsd-cgi
```

#### Clone repository and build custom image

```
git clone https://github.com/honzahommer/docker-apcupsd-cgi
cd docker-apcupsd-cgi
...
docker build --tag apcupsd-cgi .
docker run --detach --restart always --mount type=bind,source=$PWD/hosts.conf,target=/etc/apcupsd/hosts.conf,readonly --publish 8888:80 apcupsd-cgi
```
