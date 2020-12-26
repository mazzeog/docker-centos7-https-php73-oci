
# docker-centos7-https-php73-oci
# !Important docker installato sull'host <br>

 This repo aims to build a docker image that includes a stack including os Linux centos7, php73, oracle client libraries.
It will be possible to run a container with an active https connection (default self-signed) on httpd service and php 7.3 technologies configured with the most common libraries, such as: php php-cli php-fpm php-mysqlnd php-devel php-gd php -mcrypt php-mbstring php-curl php-xml php-pear php-bcmath php-json php-ldap php-xmlrpc php-soap php-oci.

The key and ca are generated just execute image  that I've created from here:
https://loglevel-blog.com/how-to-create-self-signed-certificate-with-openssl-and-docker/

Container da shell o powershell:    

**docker container run -d --name tp3  -h localhost   -p 80:443 -v $(pwd):/var/www/html  centos-php72-oci8**

Test:  Actions: docker build

![php1](https://user-images.githubusercontent.com/11073332/103095577-592d8880-4601-11eb-8e63-7d26ebf9a3ba.PNG)
![php2](https://user-images.githubusercontent.com/11073332/103095809-351e7700-4602-11eb-81e6-ec65679847ad.PNG)


 
