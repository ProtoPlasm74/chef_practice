=begin #
# Cookbook Name:: kata
# Recipe:: default
#
#

hostname = "hostname"
IP = "IP of instance"
Log = "chef log"

execute "update-upgrade" do
  command "sudo apt-get update && sudo apt-get upgrade -y"
  action :run
end

package 'apache2' do
    action :install
end

service 'apache2' do
    action :[:enable, :start]
end

file '/path/fuse.html' do
  content 'content'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end









apache2_install 'custom' do
    status_url 'status.site.org'
  end

  apache2_install 'default' do
    listen [ 80 ]
    mpm 'worker'
    mpm_conf(
             startservers: 10,
             serverlimit: 64,
             #maxclients    4096
             minsparethreads: 64,
             maxsparethreads: 256,
             threadsperchild: 64,
             #maxrequestsperchild 1024
             maxrequestworkers: 4096,
             maxconnectionsperchild: 1024
            )
    mod_conf(
      status: {
        status_allow_list: %w(127.0.0.1 ::1 1.2.3.0/24),
        extended_status: 'On',
        proxy_status: 'Off'
      }
    )
    modules lazy { default_modules.delete_if { |x| x=='autoindex' } }
  end =end