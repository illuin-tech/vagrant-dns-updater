require 'vagrant'
require_relative 'action'
require_relative 'registrar'

module VagrantPlugins
  module SubdomainsUpdater
    class Plugin < Vagrant.plugin('2')
      Vagrant.require_version('>= 1.5.1')

      name 'dns-updater'

      description <<-DESC
        This plugin allows you to automatically configure subdomains
        with the ip of your vagrant instance using your registrar API.
      DESC


      command "ovh-consumer-key" do
        require_relative "command"
        Command
      end


      config "subdomainsupdater" do
        require_relative "config"
        Config
      end

      %w{up provision}.each do |action|
        action_hook :subdomainsupdater, "machine_action_#{action}".to_sym do |hook|
          hook.append Action.set_dns_records
        end
      end

      action_hook :subdomainsupdater, "machine_action_destroy".to_sym do |hook|
        hook.append Action.remove_dns_records
      end

    end
  end
end