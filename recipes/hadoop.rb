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

execute "dpkg-install-#{hadoop_filename}" do
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

# package "cloudera-manager-agent"
# package "cloudera-manager-daemons"

package "avro-tools"
package "crunch"
package "flume-ng"
package "hadoop-hdfs-fuse"
package "hadoop-hdfs-nfs3"
package "hadoop-httpfs"
package "hbase-solr"
package "hive-hbase"
package "hive-webhcat"
package "hue-beeswax"
package "hue-hbase"
package "hue-impala"
package "hue-pig"
package "hue-plugins"
package "hue-rdbms"
package "hue-search"
package "hue-spark"
package "hue-sqoop"
package "hue-zookeeper"
package "impala"
package "impala-shell"
package "kite"
package "llama"
package "mahout"
package "oozie"
package "pig"
package "pig-udf-datafu"
package "search"
package "sentry"
package "solr-mapreduce"
package "spark-python"
package "sqoop"
package "sqoop2"
package "whirr"

package "hue"

package "bigtop-utils"
package "bigtop-jsvc"
package "bigtop-tomcat"
package "hadoop"
package "hadoop-hdfs"
package "hadoop-httpfs"
package "hadoop-mapreduce"
package "hadoop-yarn"
package "hadoop-client"
package "hadoop-0.20-mapreduce"
package "hue-plugins"
package "hbase"
package "hive"
package "oozie"
package "oozie-client"
package "pig"
package "zookeeper"

package "impala"
package "impala-shell"

package "solr-server"

