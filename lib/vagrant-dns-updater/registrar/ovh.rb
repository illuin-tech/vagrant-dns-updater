require 'ovh/rest'

module VagrantPlugins
  module DnsUpdater
    module Registrar
      class Ovh

        def initialize(config)
          @appkey = config.appkey
          @appsecret = config.appsecret
          @consumerkey = config.consumerkey
          @zone = config.zone
          @subdomain = config.subdomain
          @ttl = config.ttl
          @api = OVH::REST.new(appkey, appsecret, consumerkey)
        end

        def set_dns_record(ip)
        record_id = self.get_record_id
          if record_id.nil?
            @api.post("/domain/zone/#{@zone}/record", {
                      'fieldType' => 'A',
                      'target' => ip,
                      'subDomain' => @subdomain,
                      'ttl' => @ttl})
          else
            @api.put("/domain/zone/#{@zone}/record/#{r}", {
                     'target' => ip,
                     'subDomain' => @subdomain,
                     'ttl' => @ttl})
          end

          @api.post("/domain/zone/#{@zone}/refresh")
        end

        def remove_dns_record
          record_id = self.get_record_id
          @api.delete("/domain/zone/#{@zone}/record/#{record_id}") if !record_id.nil?
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