module VagrantPlugins
  module SubdomainsUpdater
    module Registrar
      class Registrar

        @@registrars = {}

        def self.load(config)
          registrar = @@registrars[config.registrar]
          if registrar
            registrar.new config
          else
            raise Vagrant::Errors::VagrantError.new,
                    "SubdomainsUpdater: The registrar \"#{config.registrar}\" is not supported."
          end
        end

        def self.register_registrar(name)
          @@registrars[name] = self
        end

      end
    end
  end
end