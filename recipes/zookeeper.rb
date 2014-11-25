#
# Cookbook Name:: hadoop
# Recipe:: zookeeper
#
# Copyright (C) 2014 Vincenzo D'Amore v.damore@gmail.com
#
# All rights reserved - Do Not Redistribute
#

execute "zookeeper-server-initialize" do
  user "root"
  command "zookeeper-server-initialize"
  returns 0
end

execute "zookeeper-server-start" do
  user "root"
  command "zookeeper-server start"
  returns 0
end
 
