require "./lib/omniauth-bitbucket/version"

Gem::Specification.new do |spec|
  spec.name          = "omniauth-atlassian-bitbucket"
  spec.version       = Omniauth::Bitbucket::VERSION
  spec.authors       = ["Nando Vieira"]
  spec.email         = ["fnando.vieira@gmail.com"]
  spec.summary       = "OmniAuth strategy for Bitbucket (https://bitbucket.org)."
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/fnando/omniauth-atlassian-bitbucket"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) {|f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "omniauth-oauth2"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest-utils"
  spec.add_development_dependency "pry-meta"
  spec.add_development_dependency "mocha"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "webmock"
end
