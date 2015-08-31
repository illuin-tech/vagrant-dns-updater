require 'vagrant'

module VagrantPlugins
  module DnsUpdater
    class Config < Vagrant.plugin(2, :config)
      attr_accessor :provider
      attr_accessor :appkey
      attr_accessor :appsecret
      attr_accessor :consumerkey
      attr_accessor :zone
      attr_accessor :subdomain
      attr_accessor :interface
      attr_accessor :ttl


      def initialize
        @provider = UNSET_VALUE
        @appkey = UNSET_VALUE
        @appsecret = UNSET_VALUE
        @consumerkey = UNSET_VALUE
        @zone = UNSET_VALUE
        @subdomain = UNSET_VALUE
        @interface = UNSET_VALUE
        @ttl = UNSET_VALUE
      end

      def finalize!
        @provider = nil if @provider == UNSET_VALUE
        @appkey = nil if @appkey == UNSET_VALUE
        @appsecret = nil if @appsecret == UNSET_VALUE
        @consumerkey = nil if @consumerkey == UNSET_VALUE
        @zone = nil if @zone == UNSET_VALUE
        @subdomain = nil if @subdomain == UNSET_VALUE
        @interface = 'eth0' if @interface == UNSET_VALUE
        @ttl = 600 if @ttl == UNSET_VALUE
      end

      def validate(machine)
        finalize!
      end
    end

  end
end