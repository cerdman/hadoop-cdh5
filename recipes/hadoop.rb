#
# Cookbook Name:: hadoop
# Recipe:: default
#
# Copyright (C) 2014 Vincenzo D'Amore v.damore@gmail.com
#
# All rights reserved - Do Not Redistribute
#

require 'uri'

hadoop_user = node['hadoop']['user']
hadoop_group = node['hadoop']['group']
hadoop_user_home = "/home/#{hadoop_user}"
hadoop_url = node['hadoop']['cloudera_repo_pkg_url']
hadoop_uri = URI.parse(hadoop_url)
hadoop_filename = File.basename(hadoop_uri.path)
hadoop_basename = File.basename(hadoop_uri.path, '.deb')
basedir = '/usr/local'

group hadoop_group

user hadoop_user do
  group hadoop_group
  shell '/bin/bash'
  home hadoop_user_home
  supports :manage_home => true
  password '$1$RF0eUP9s$r.H4rcWvQ9zc5REJydT2c/'
  action :create
end

ssh_known_hosts_entry 'localhost'

remote_file "/tmp/#{hadoop_filename}" do
  source hadoop_url
end

execute "tar-xzf-hadoop" do
  user "root"
  command "dpkg -i /tmp/#{hadoop_filename}"
  action :run
  cwd basedir
  returns 0
end

execute "apt-get-update" do
  user "root"
  command "apt-get -y update"
  returns 0
end

execute "apt-get-install-hue" do
  user "root"
  command "apt-get -y install hue"
  returns 0
end


