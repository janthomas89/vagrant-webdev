vagrant-webdev
==============

Basic vagrant LAMP stack for my web development.


1.) Requirements
------------
* Vagrant <http://www.vagrantup.com>
* VirtualBox <http://www.virtualbox.com>


2.) Usage
------------
Clone this repository:

	$ git clone --recursive git@github.com:janthomas89/vagrant-webdev.git .

Move your application in the www directory and start vagrant:

	$ cd vagrant-webdev
	$ vagrant up

There are two ways to access your project:
*http://localhost:8080
*https://localhost:4443


3.) Instlalled Software
------------
The VMs provisioning is done by the chef role "vagrant-webdev-box". The following software is installed:
* Apache2 (mod_php5, mod_ssl)
* Memcached
* Mysql
* Openssl
* PHP 5.4 (mysql, sqlite3, memcached, GD, FPDF, Curl, Xdebug, composer)
* PHPMyAdmin


4.) Configuration (Vagrantfile)
------------
* vhost_name: Name of the apache2 VHOST (e.g. www.project.de)
* vhost_user: The VHOSTs username (used for mysql database)
* vhost_password: The VHOSTs password (used for mysql database)
* mysql_db_name: The Name of the MySQL Database
* mysql_db_skeleton: Optional path pointing at a skeleton.sql file
* apt_packages: List of additional debian packages
* php_packages: List of additional php packages
