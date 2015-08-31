require 'ovh/rest'

module VagrantPlugins
  module DnsUpdater
    module Action

      class SetDynHost
        def initialize(app, env)
          @app = app
          @machine = env[:machine]
        end


        def call(env)
          @env = env

          appkey = @machine.config.dnsupdater.appkey
          appsecret = @machine.config.dnsupdater.appsecret
          consumerkey = @machine.config.dnsupdater.consumerkey
          zone = @machine.config.dnsupdater.zone
          subdomain = @machine.config.dnsupdater.subdomain
          interface = @machine.config.dnsupdater.interface


          @machine.communicate.execute("ip addr show #{interface} | awk '/inet/ && /#{interface}/{sub(/\\/.*$/,\"\",$2); print $2}'") do |type, output|
            ip = output
            @env[:ui].info "Pointing #{subdomain}.#{zone} to #{ip} (#{interface})."

            begin
              ovh = OVH::REST.new(appkey, appsecret, consumerkey)
            rescue
              @env[:ui].error "This credential does not exist."
              exit 1
            end

            records = ovh.get("/domain/zone/#{zone}/record")
            is_present = false

            records.each do |record_id|
              record = ovh.get("/domain/zone/#{zone}/record/#{record_id}")

              if record['subDomain'] == subdomain then
                is_present = true
                ovh.put("/domain/zone/#{zone}/record/#{record_id}", {'target' => ip, 'subDomain' => subdomain, 'ttl' => 60})
              end
            end

            ovh.post("/domain/zone/#{zone}/record", {'fieldType' => 'A', 'target' => ip, 'subDomain' => subdomain, 'ttl' => 60}) if !is_present

            ovh.post("/domain/zone/#{zone}/refresh")

          end

          @app.call(env)
        end
      end
    end
  end
end