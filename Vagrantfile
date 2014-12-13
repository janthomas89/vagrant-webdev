# -*- mode: ruby -*-
# vi: set ft=ruby :

# The VHOSTs / projects settings
vhost_name        = "www.project.de"
vhost_user        = "root"
vhost_password    = "root"
mysql_db_name     = "projectde"
mysql_db_skeleton = ""
apt_packages      = %w{ screen curl subversion phpmyadmin }
php_packages      = %w{ php5-memcached php5-xdebug }


# Vagrantfile API/syntax version
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Define VM box
  config.vm.box = "chef/debian-7.4-i386"
  config.vm.box_url = "https://vagrantcloud.com/chef/boxes/debian-7.4-i386/versions/1.0.0/providers/virtualbox.box"


  # Configure Network
  config.vm.network :forwarded_port, guest: 80, host: 8080
  config.vm.network :forwarded_port, guest: 443, host: 4443
  config.vm.network :forwarded_port, guest: 3306, host: 8006
  # config.vm.network :private_network, ip: "192.168.178.10"
  # config.vm.network :public_network


  # Configure synced folders
  config.vm.synced_folder "./www/web" , "/var/www/sites/" + vhost_name + "/web/", owner: "vagrant", group: "www-data", mount_options: ["dmode=770,fmode=660"]
  config.vm.synced_folder "./www/var" , "/var/www/sites/" + vhost_name + "/var/", owner: "vagrant", group: "www-data", mount_options: ["dmode=770,fmode=660"]
  config.vm.synced_folder "./www/lib" , "/var/www/sites/" + vhost_name + "/lib/", owner: "vagrant", group: "www-data", mount_options: ["dmode=740,fmode=640"]
  config.vm.synced_folder "./www/tmp" , "/var/www/sites/" + vhost_name + "/tmp/", owner: "vagrant", group: "www-data", mount_options: ["dmode=770,fmode=660"]


  # Configure Provisioning
  config.vm.provision :shell, path: "bootstrap.sh"
  config.vm.provision :chef_solo do |chef|
    chef.roles_path     = "./chef/roles"
    chef.cookbooks_path = ["./chef/site-cookbooks", "./chef/cookbooks"]
    chef.add_role       "vagrant-webdev-box"

    # Configuration params
    chef.json = {
      :webdev => {
        :vhost_name         => vhost_name,
        :vhost_root         => "/var/www/sites/" + vhost_name,
        :mysql_db_name      => mysql_db_name,
        :mysql_db_skeleton  => mysql_db_skeleton,
        :apt_packages       => apt_packages,
        :php_packages       => php_packages
      },

      :mysql => {
        :server_root_password   => vhost_password,
        :server_repl_password   => vhost_password,
        :server_debian_password => vhost_password,
        :allow_remote_root      => true
      },

      :phpmyadmin => {
        :home => "/usr/share/phpmyadmin",
        :user => "pma",
        :group => "pma",
        :fpm => false
      }
    }
  end

end
