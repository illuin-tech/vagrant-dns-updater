require 'pathname'
require 'vagrant-dns-updater/plugin'

module VagrantPlugins
  module DnsUpdater
    lib_root = File.dirname(File.absolute_path(__FILE__))
    Dir.glob(lib_root + '/vagrant-dns-updater/registrar/*') {|file| require file}

    def self.source_root
      @source_root ||= Pathname.new(File.expand_path('../../', __FILE__))
    end
  end
end