$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ecm/audited/backend/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ecm_audited_backend"
  s.version     = Ecm::Audited::Backend::VERSION
  s.authors     = ["Roberto Vasquez Angel"]
  s.email       = ["roberto@vasquez-angel.de"]
  s.homepage    = "https://github.com/robotex82/ecm_audited_backend"
  s.summary     = "Summary of Ecm::Audited::Backend."
  s.description = "Description of Ecm::Audited::Backend."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", ">= 5.0"
end
