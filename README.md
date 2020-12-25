
# docker-centos7-https-php73-oci
# !Important docker installato sull'host <br>
 
Questa repo ha come obiettivo la costruzione di un immagine docker che include uno stack che comprende os Linux centos7, php73, librerie oracle client. <br>
Sarà possibile far girare un container con attivo una connessione https (default self-signed) su servizio httpd e tecnologie php 7.3 configurato con le librerie più comuni, quali:
 php php-cli php-fpm php-mysqlnd  php-devel php-gd php-mcrypt php-mbstring php-curl php-xml php-pear php-bcmath php-json php-ldap php-xmlrpc php-soap php-oci.<br>
 
<p>Il repo include librerie zip Oracle per l'installazione e configurazione del client Oracle sull'imagine costruita per connessioni php73/oci8 verso db Oracle.</p>

crea container da shell o powershell:    

**docker container run -d --name tp3  -h localhost   -p 80:443 -v $(pwd):/var/www/html  centos-php72-oci8**

Test:  Actions: docker build

![php1](https://user-images.githubusercontent.com/11073332/103095577-592d8880-4601-11eb-8e63-7d26ebf9a3ba.PNG)
![php2](https://user-images.githubusercontent.com/11073332/103095809-351e7700-4602-11eb-81e6-ec65679847ad.PNG)


 
