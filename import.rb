require 'rubygems'
require 'zabbix/client'
require 'yaml'

config = YAML.load_file("config.yml")

host = config["host"]
username = config["username"]
password = config["password"]

zabbix = Zabbix::Client.new("http://#{host}/zabbix/api_jsonrpc.php")
zabbix.user.login(user: username, password: password)


def import_xml(zbx_instance, template)
  zabbix = zbx_instance
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
    :source => template, 
    :format => 'xml'
  )
end

f = File.read("./zabbix-template/KW_Template_Virt_VMware_Hypervisor.xml")
import_xml(zabbix, f)

f = File.read("./zabbix-template/KW_Template_Virt_VMware_Guest.xml")
import_xml(zabbix, f)

Dir::foreach('./zabbix-template') do |file|
  if file =~ /\.xml$/
     f = File.read("./zabbix-template/#{file}")
    import_xml(zabbix, f)
  end
end

 
