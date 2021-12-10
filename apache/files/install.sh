#!/bin/bash

	rm -rf /etc/yum.repos.d/* && \
	curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-$(awk -F '"' 'NR==5{print $2}' /etc/os-release).repo && \
	sed -i -e '/mirrors.cloud.aliyuncs.com/d' -e '/mirrors.aliyuncs.com/d' /etc/yum.repos.d/CentOS-Base.repo && \
	yum clean all && yum makecache && \
	yum -y install openssl-devel pcre-devel expat-devel libtool gcc gcc-c++ make && \
	useradd -r -M -s /sbin/noglogin apache && \
	sed -i '/$RM "$cfgfile"/d' /usr/src/apr-1.7.0/configure && \
	cd /usr/src/apr-1.7.0 && \
	./configure --prefix=/usr/local/apr  && \
	make -j $(nproc) && make install && \
	cd ../apr-util-1.6.1 && \
	./configure --prefix=/usr/local/apr-util --with-apr=/usr/local/apr && \
	make -j $(nproc) && make install && \
	cd ../httpd-${version} && \
	./configure --prefix=/usr/local/apache \
	  --enable-so \
	  --enable-ssl \
	  --enable-cgi \
	  --enable-rewrite \
	  --with-zlib \
	  --with-pcre \
	  --with-apr=/usr/local/apr \
	  --with-apr-util=/usr/local/apr-util/ \
	  --enable-modules=most \
	  --enable-mpms-shared=all \
	  --with-mpm=prefork && \
	make -j $(nproc) && make install && \
	yum -y remove gcc gcc-g++ make
	rm -rf /var/cache/* /usr/src/{apr-1.7.0,httpd-${version},apr-util-1.6.1} /tmp/* 
