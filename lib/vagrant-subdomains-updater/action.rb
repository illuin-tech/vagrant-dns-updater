require_relative 'action/set_dns_records'
require_relative 'action/remove_dns_records'

module VagrantPlugins
  module SubdomainsUpdater
    module Action
      include Vagrant::Action::Builtin

      def self.set_dns_records
        Vagrant::Action::Builder.new.tap do |builder|
          builder.use ConfigValidate
          builder.use SetDnsRecords
        end
      end

      def self.remove_dns_records
        Vagrant::Action::Builder.new.tap do |builder|
          builder.use ConfigValidate
          builder.use RemoveDnsRecords
        end
      end
    end
  end
end