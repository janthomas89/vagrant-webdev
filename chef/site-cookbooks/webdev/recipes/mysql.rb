#
# Cookbook Name:: webdev
# Recipe:: mysql
#

# Create vhosts database
ruby_block "create_#{node['webdev']['vhost_name']}_db" do
    block do
        %x[mysql -uroot -p#{node['mysql']['server_root_password']} -e "CREATE DATABASE #{node['webdev']['mysql_db_name']};"]
    end 
    not_if "mysql -uroot -p#{node['mysql']['server_root_password']} -e \"SHOW DATABASES LIKE '#{node['webdev']['mysql_db_name']}'\" | grep #{node['webdev']['mysql_db_name']}";
    action :create
end

# Load database skeleton if skeleton file exists and database is empty
if File.exist?("#{node['webdev']['mysql_db_skeleton']}")
   ruby_block "seed #{node['webdev']['vhost_name']} database" do
       block do
           %x[mysql -u root -p#{node['mysql']['server_root_password']} #{node['webdev']['mysql_db_name']} < #{node['webdev']['mysql_db_skeleton']}]
       end
       not_if "mysql -u root -p#{node['mysql']['server_root_password']} -e \"SHOW TABLES FROM #{node['webdev']['mysql_db_name']}\" | \
           grep 1"
       action :create
   end
end