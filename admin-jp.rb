require 'rubygems'
require 'zabbix/client'
require 'yaml'

config = YAML.load_file("config.yml")

host = config["host"]
username = config["username"]
password = config["password"]

zabbix = Zabbix::Client.new("http://#{host}/zabbix/api_jsonrpc.php")
#client = Zabbix::Client.new('http://localhost/zabbix/api_jsonrpc.php')

zabbix.user.login(user: username, password: password)

zabbix.user.update(:userid => "1", :lang => "ja_JP")
