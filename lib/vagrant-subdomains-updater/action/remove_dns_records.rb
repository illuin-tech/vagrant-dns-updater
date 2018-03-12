module VagrantPlugins
  module SubdomainsUpdater
    module Action
      class RemoveDnsRecords

        def initialize(app, env)
          @app = app
          @machine = env[:machine]
        end

        def call(env)
          config = @machine.config.subdomainsupdater
          unless config.registrar.nil?
            registrar = Registrar::Registrar.load config
            registrar.remove_dns_records
          end
        end

      end
    end
  end
end