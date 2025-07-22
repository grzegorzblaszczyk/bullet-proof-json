
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "bullet_proof_json/version"

Gem::Specification.new do |spec|
  spec.name          = "bullet_proof_json"
  spec.version       = BulletProofJson::VERSION
  spec.authors       = ["Grzegorz Błaszczyk"]
  spec.email         = ["grzegorz.blaszczyk@gmail.com"]

  spec.metadata["source_code_uri"]  = "https://github.com/grzegorzblaszczyk/bullet-proof-json"
  spec.metadata["changelog_uri"]    = "https://github.com/grzegorzblaszczyk/bullet-proof-json/blob/main/CHANGELOG.md"

  spec.summary       = "Bullet Proof JSON for Ruby with seamless request handling, smart throttling and robust retry mchanism"
  spec.description   = "Bullet Proof JSON for Ruby takes the hassle out of API response handling by offering: Seamless Request Handling - automatically manage timeouts and errors so your app stays resilient, Smart Throttling - respect API rate limits without overcomplicating your code, Robust Retry Mechanism - never miss a response due to transient errors."
  spec.homepage      = "https://github.com/grzegorzblaszczyk/bullet-proof-json"
  spec.license       = "MIT"

  spec.required_ruby_version = ">= 2.0.0"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.6.3"
  spec.add_development_dependency "guard", "~> 2.19.1"
  spec.add_development_dependency "guard-rspec", "~> 4.7.3"
  spec.add_development_dependency "pry", "~> 0.15.2"
  spec.add_development_dependency "rake", "~> 12.3"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "simplecov", "~> 0.22.0"
end
