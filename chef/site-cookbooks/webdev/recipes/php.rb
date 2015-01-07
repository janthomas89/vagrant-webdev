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

# Install apc pecl
package "libpcre3-dev"
package "php-apc"
