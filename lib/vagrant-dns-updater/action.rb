require_relative 'action/set_dns_record'
require_relative 'action/remove_dns_record'

module VagrantPlugins
  module DnsUpdater
    module Action
      include Vagrant::Action::Builtin

      def self.set_dns_record
        Vagrant::Action::Builder.new.tap do |builder|
          builder.use ConfigValidate
          builder.use SetDnsRecord
        end
      end

      def self.remove_dns_record
        Vagrant::Action::Builder.new.tap do |builder|
          builder.use ConfigValidate
          builder.use RemoveDnsRecord
        end
      end
    end
  end
end