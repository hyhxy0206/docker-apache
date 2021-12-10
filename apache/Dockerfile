FROM centos
LABEL MAINTAINER "hy 1@2.com"

ENV version 2.4.51
ENV PATH /usr/local/apache/bin:$PATH

ADD files/apr-1.7.0.tar.gz /usr/src/
ADD files/apr-util-1.6.1.tar.gz /usr/src/
ADD files/httpd-${version}.tar.gz /usr/src/
ADD files/install.sh /tmp/

RUN  ["/bin/bash","-c","/tmp/install.sh"]

WORKDIR /usr/local/apache
EXPOSE 80 443
CMD ["-D","FOREGROUND"]
ENTRYPOINT ["httpd"]
