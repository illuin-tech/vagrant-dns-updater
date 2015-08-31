require 'pathname'

require 'vagrant-dns-updater/plugin'

module VagrantPlugins
  module DnsUpdater
    def self.source_root
      @source_root ||= Pathname.new(File.expand_path('../../', __FILE__))
    end
  end
end