require 'vagrant'

module VagrantPlugins
  module SubdomainsUpdater
    class Config < Vagrant.plugin(2, :config)
      attr_accessor :registrar
      attr_accessor :appkey
      attr_accessor :appsecret
      attr_accessor :consumerkey
      attr_accessor :zone
      attr_accessor :subdomains
      attr_accessor :interface
      attr_accessor :ttl


      def initialize
        @registrar = UNSET_VALUE
        @appkey = UNSET_VALUE
        @appsecret = UNSET_VALUE
        @consumerkey = UNSET_VALUE
        @zone = UNSET_VALUE
        @subdomains = UNSET_VALUE
        @interface = UNSET_VALUE
        @ttl = UNSET_VALUE
      end

      def finalize!
        @registrar = nil if @registrar == UNSET_VALUE
        @appkey = nil if @appkey == UNSET_VALUE
        @appsecret = nil if @appsecret == UNSET_VALUE
        @consumerkey = nil if @consumerkey == UNSET_VALUE
        @zone = nil if @zone == UNSET_VALUE
        @subdomains = nil if @subdomains == UNSET_VALUE
        @interface = nil if @interface == UNSET_VALUE
        @ttl = 60 if @ttl == UNSET_VALUE
      end

      def validate(machine)
        finalize!
        errors = []
        errors << 'appkey parameter is required' if @appkey.nil? && @registrar == 'ovh'
        errors << 'appsecret parameter is required' if @appsecret.nil? && @registrar == 'ovh'
        errors << 'consumerkey parameter is required' if @consumerkey.nil? && @registrar == 'ovh'
        errors << 'zone parameter is required' if @zone.nil? && !@registrar.nil?
        errors << 'subdomains parameter is required' if @subdomains.nil? && !@registrar.nil?

        { "SubdomainsUpdater" => errors }
      end
    end

  end
end