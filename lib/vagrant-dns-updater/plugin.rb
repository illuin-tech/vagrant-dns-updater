require 'vagrant'
require_relative 'action'

module VagrantPlugins
  module DnsUpdater
    class Plugin < Vagrant.plugin('2')
      Vagrant.require_version('>= 1.5.1')

      name 'dns-updater'

      description <<-DESC
        Bla bla bla.
      DESC


      command "ovh-consumer-key" do
        require_relative "command"
        Command
      end


      config "dnsupdater" do
        require_relative "config"
        Config
      end

      %w{up provision}.each do |action|
        action_hook(:dnsupdater, "machine_action_#{action}".to_sym) do |hook|
          hook.append(Action.set_dns_record)
        end
      end

      action_hook(:dnsupdater, "machine_action_destroy".to_sym) do |hook|
        hook.prepend(Action.remove_dns_record)
      end

    end
  end
end