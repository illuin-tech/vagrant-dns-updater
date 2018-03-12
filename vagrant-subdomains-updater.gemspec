# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vagrant-subdomains-updater/version'

Gem::Specification.new do |spec|
  spec.name          = "vagrant-subdomains-updater"
  spec.version       = VagrantPlugins::SubdomainsUpdater::VERSION
  spec.authors       = ["Nassim Kacha"]
  spec.email         = ["nassim.kacha@blueicefield.com"]

  spec.description   = 'A Vagrant plugin that allows you to automatically configure subdomains' \
                       ' with the ip of your vagrant instance using your registrar API.' \
                       ' Only the registrar OVH is supported at the moment.'
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/blueicefield/vagrant-subdomains-updater"
  spec.license       = "MIT"
  
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'ovh-rest', '~> 0.0.5'

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
end
