require_relative '../registrar/ovh'

module VagrantPlugins
  module DnsUpdater
    module Action
      class RemoveDnsRecord

        def initialize(app, env)
          @app = app
          @machine = env[:machine]
        end

        def call(env)
          config = @machine.config.dnsupdater
          registrar = Registrar::Ovh.new(config)
          registrar.remove_dns_record
          end
        end

      end
    end
  end
end