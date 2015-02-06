#
# Cookbook Name:: webdev
# Recipe:: php
#

include_recipe "apt"

# Install custom PHP packages
node['webdev']['php_packages'].each do |a_package|
  package a_package
end

# Install Composer
bash "composer" do
  code <<-EOH
    curl -s https://getcomposer.org/installer | php
    sudo mv composer.phar /usr/local/bin/composer
  EOH
end

# Install Symfony
bash "symfony" do
  code <<-EOH
    curl -LsS http://symfony.com/installer > symfony.phar
	sudo mv symfony.phar /usr/local/bin/symfony
	chmod a+x /usr/local/bin/symfony
  EOH
end

# Install apc pecl
package "libpcre3-dev"
package "php-apc"
