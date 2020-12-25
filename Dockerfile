FROM centos:7

# Install Apache
RUN yum -y update
RUN yum -y install httpd httpd-tools

# Install EPEL Repo
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
  rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm && \
  yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm  && \
  yum -y install epel-release yum-utils && \
  yum-config-manager --disable remi-php54  && \
  yum-config-manager --enable remi-php73 && \
  yum -y install mod_ssl openssl && \
  yum -y install libaio-devel && \
  yum -y install php-pear

  RUN yum -y install php php-cli php-fpm php-mysqlnd  php-devel php-gd php-mcrypt php-mbstring php-curl php-xml php-pear php-bcmath php-json php-ldap php-xmlrpc php-soap 
  RUN yum -y install php-oci8 && \
  echo "extension=oci8.so" >> /etc/php.d/oci8.ini


# Generate Self Signed
COPY ca.crt /etc/pki/tls/certs
COPY ca.key /etc/pki/tls/private/ca.key
COPY ca.csr /etc/pki/tls/private/ca.csr

RUN sed -E -i -e 's|#DocumentRoot "/var/www/html"|DocumentRoot "/var/www/html"|' /etc/httpd/conf.d/ssl.conf && \
    sed -E -i -e  's|SSLCertificateFile /etc/pki/tls/certs/localhost.crt|SSLCertificateFile /etc/pki/tls/certs/ca.crt|g' /etc/httpd/conf.d/ssl.conf  && \
    sed -E -i -e  's|SSLCertificateKeyFile /etc/pki/tls/private/localhost.key|SSLCertificateKeyFile /etc/pki/tls/private/ca.key|g' /etc/httpd/conf.d/ssl.conf 


# Copy and Install Oracle Library
WORKDIR /app/src/tmp
COPY oracle-instantclient19.9-basic-19.9.0.0.0-1.x86_64.rpm /app/src/tmp  
COPY oracle-instantclient19.9-devel-19.9.0.0.0-1.x86_64.rpm /app/src/tmp
COPY oracle-instantclient19.9-sqlplus-19.9.0.0.0-1.x86_64.rpm /app/src/tmp

RUN rpm -ivh /app/src/tmp/oracle-instantclient19.9-*.rpm  && \
 echo "export ORACLE_HOME=/usr/lib/oracle/19.9/client64" >> /etc/profile  && \
 echo "export ORACLE_BASE=/usr/lib/oracle/19.9" >> /etc/profile  && \
 echo "export LD_LIBRARY_PATH=$ORACLE_HOME/lib:$LD_LIBRARY_PATH" >> /etc/profile && \
 echo "export PATH=$ORACLE_HOME/bin:$PATH" >> /etc/profile 


# Update Apache Configuration
RUN sed -E -i -e '/<Directory "\/var\/www\/html">/,/<\/Directory>/s/AllowOverride None/AllowOverride All/' /etc/httpd/conf/httpd.conf  && \
  sed -E -i -e 's/DirectoryIndex (.*)$/DirectoryIndex index.php \1/g' /etc/httpd/conf/httpd.conf


EXPOSE 80 443

# Start Apache
CMD ["/usr/sbin/httpd","-D","FOREGROUND"]