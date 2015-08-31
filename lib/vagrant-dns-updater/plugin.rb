require 'vagrant'

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
        action_hook(:set_dns_record, "machine_action_#{action}".to_sym) do |hook|
          require_relative 'action/set_dynhost'
          hook.append VagrantPlugins::DnsUpdater::Action::SetDynHost
        end
      end

      action_hook(:remove_dns_record, "machine_action_destroy".to_sym) do |hook|
        require_relative 'action/unset_dynhost'
        hook.append VagrantPlugins::DnsUpdater::Action::UnsetDynHost
      end

    end
  end
end