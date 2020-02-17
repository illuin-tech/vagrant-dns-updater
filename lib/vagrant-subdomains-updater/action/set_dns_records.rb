module VagrantPlugins
  module SubdomainsUpdater
    module Action
      class SetDnsRecords

        def initialize(app, env)
          @app = app
          @machine = env[:machine]
        end

        def call(env)
          config = @machine.config.subdomainsupdater
          unless config.registrar.nil?
            interface = config.interface
            registrar = Registrar::Registrar.load config
            if interface.nil?
              @machine.communicate.execute("ip addr show | grep BROADCAST |head -n 1|cut -d':' -f2") do |type, output|
                raise Vagrant::Errors::VagrantError.new, output if type.to_s == 'stderr'
                interface = output.strip
                @machine.ui.warn("No interface given. Using first interface found, #{interface}")
              end
            end
            @machine.communicate.execute("ip addr show #{interface} | awk '/inet/ && /#{interface}/{sub(/\\/.*$/,\"\",$2); print $2}'") do |type, output|
              raise Vagrant::Errors::VagrantError.new, output if type.to_s == 'stderr'
              ip = output
              @machine.ui.info("Pointing #{config.subdomains.join(', ')} subdomains for zone #{config.zone} to #{ip}")
              registrar.set_dns_records ip
            end
          end
        end

      end
    end
  end
end