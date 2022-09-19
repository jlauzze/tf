runcmd:
  - yum update -y
  - yum install docker -y
  - systemctl enable docker.service
  - systemctl start docker.service
  - docker run -P -d -p 8080:80 nginxdemos/hello