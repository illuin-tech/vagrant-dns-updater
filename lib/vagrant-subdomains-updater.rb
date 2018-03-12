require 'pathname'
require 'vagrant-subdomains-updater/plugin'

module VagrantPlugins
  module SubdomainsUpdater
    lib_root = File.dirname(File.absolute_path(__FILE__))
    Dir.glob(lib_root + '/vagrant-subdomains-updater/registrar/*') {|file| require file}

    def self.source_root
      @source_root ||= Pathname.new(File.expand_path('../../', __FILE__))
    end
  end
end