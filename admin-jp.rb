require 'rubygems'
require 'zbxapi'
require 'yaml'

config = YAML.load_file("config.yml")

zabbix = ZabbixAPI.new("http://#{config["host"]}/zabbix", :verify_ssl => false, :http_timeout => 300 )
zabbix.login(config["username"],config["password"])

zabbix.user.update(:userid => "1", :lang => "ja_JP")
