#!/bin/bash
yum update
yum install docker
systemctl enable docker.service
systemctl start docker.service
docker run -P -d -p 8080:80 nginxdemos/hello