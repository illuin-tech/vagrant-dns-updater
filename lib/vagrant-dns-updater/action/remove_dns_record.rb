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
          registrar = Registrar::Registrar.load config
          registrar.remove_dns_record
        end

      end
    end
  end
end