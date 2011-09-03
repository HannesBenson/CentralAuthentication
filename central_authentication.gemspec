# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "central_authentication/version"

Gem::Specification.new do |s|
  s.name        = "central_authentication"
  s.version     = CentralAuthentication::VERSION
  s.authors     = ["Hannes Benson"]
  s.email       = ["hannes@mpowered.co.za"]
  s.homepage    = ""
  s.summary     = %q{Central Authentication using Authlogic}
  s.description = %q{This gem allows you to share a central database and using authlogic stores and retrieves passwords}

  s.rubyforge_project = "central_authentication"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
