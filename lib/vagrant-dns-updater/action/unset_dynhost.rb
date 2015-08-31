require 'ovh/rest'

module VagrantPlugins
  module DnsUpdater
    module Action

      class UnsetDynHost
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

          @env[:ui].info "Deleting #{subdomain}.#{zone}."

          ovh = OVH::REST.new(appkey, appsecret, consumerkey)

          records = ovh.get("/domain/zone/#{zone}/dynHost/record")

          records.each do |record_id|
            record = ovh.get("/domain/zone/#{zone}/dynHost/record/#{record_id}")

            if record['subDomain'] == subdomain then
              ovh.delete("/domain/zone/#{zone}/dynHost/record/#{record_id}")
            end
          end

          @app.call(env)
        end
      end
    end
  end
end