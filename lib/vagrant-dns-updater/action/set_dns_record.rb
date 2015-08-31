require_relative '../registrar/ovh'

module VagrantPlugins
  module DnsUpdater
    module Action
      class SetDnsRecord

        def initialize(app, env)
          @app = app
          @machine = env[:machine]
        end

        def call(env)
          config = @machine.config.dnsupdater
          interface = config.interface
          registrar = Registrar::Ovh.new(config)
          @machine.communicate.execute("ip addr show #{interface} | awk '/inet/ && /#{interface}/{sub(/\\/.*$/,\"\",$2); print $2}'") do |type, output|
            ip = output
            registrar.set_dns_record(ip)
          end
        end

      end
    end
  end
end