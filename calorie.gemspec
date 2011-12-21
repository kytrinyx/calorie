# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "calorie/version"

Gem::Specification.new do |s|
  s.name        = "calorie"
  s.version     = Calorie::VERSION
  s.authors     = ["Katrina Owen"]
  s.email       = ["katrina.owen@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{A calendar is a calendar is a calendar.}
  s.description = %q{A simple, ruby calendar decorator.}

  s.rubyforge_project = "calorie"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
  s.add_development_dependency "timecop"
  s.add_runtime_dependency "i18n"
end
