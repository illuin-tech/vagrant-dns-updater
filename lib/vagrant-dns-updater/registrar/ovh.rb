require 'ovh/rest'

module VagrantPlugins
  module DnsUpdater
    module Registrar
      class Ovh < Registrar

        register_registrar 'ovh'

        def initialize(config)
          @zone = config.zone
          @subdomain = config.subdomain
          @ttl = config.ttl
          @api = OVH::REST.new config.appkey, config.appsecret, config.consumerkey
        end

        def set_dns_record(ip)
          begin
            record_id = get_record_id
            if record_id.nil?
              @api.post("/domain/zone/#{@zone}/record", {
                        'fieldType' => 'A',
                        'target' => ip,
                        'subDomain' => @subdomain,
                        'ttl' => @ttl})
            else
              @api.put("/domain/zone/#{@zone}/record/#{record_id}", {
                       'target' => ip,
                       'subDomain' => @subdomain,
                       'ttl' => @ttl})
            end

            @api.post("/domain/zone/#{@zone}/refresh")
          rescue OVH::RESTError => error
            raise Vagrant::Errors::VagrantError.new, "DnsUpdater: #{error}"
          end
        end

        def remove_dns_record
          begin
            record_id = get_record_id
            @api.delete("/domain/zone/#{@zone}/record/#{record_id}") unless record_id.nil?
          rescue OVH::RESTError => error
            raise Vagrant::Errors::VagrantError.new, "DnsUpdater: #{error}"
          end
        end


        private

        def get_record_id
          records = @api.get("/domain/zone/#{@zone}/record")
          records.each do |r|
            record = @api.get("/domain/zone/#{@zone}/record/#{r}")
            return r if record['subDomain'] == @subdomain
          end
          nil
        end

      end
    end
  end
end