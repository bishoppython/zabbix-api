require 'zbxapi'
require 'yaml'

config = YAML.load_file("config.yml")

zabbix = ZabbixAPI.new("http://#{config["host"]}/zabbix", :verify_ssl => false, :http_timeout => 300 )
zabbix.login(config["username"],config["password"])


Dir::foreach('./zabbix-template') do |file|
  if file =~ /\.xml$/
    f = File.read("./zabbix-template/#{file}")

    zabbix.configuration.import(
      :rules => {
        :applications => {
          :createMissing => true,
          :updateExisting => true
        },
        :discoveryRules => {
          :createMissing => true,
          :updateExisting => true
        },
        :graphs  => {
          :createMissing => true,
          :updateExisting => true
        },
        :groups => {
          :createMissing => true,
        },
        :hosts => {
          :createMissing => true,
          :updateExisting => true
        },
        :images => {
          :createMissing => true,
          :updateExisting => true
        },
        :items => {
          :createMissing => true,
          :updateExisting => true
        },
        :maps => {
          :createMissing => true,
          :updateExisting => true
        },
        :screens => {
          :createMissing => true,
          :updateExisting => true
        },
        :templateLinkage => {
          :createMissing => true,
        },
        :templates => {
          :createMissing => true,
          :updateExisting => true
        },
        :templateScreens => {
          :createMissing => true,
          :updateExisting => true
        },
        :triggers => {
          :createMissing => true,
          :updateExisting => true
        }
      }, 
      :source => f, 
      :format => 'xml'
    )

  end
end
