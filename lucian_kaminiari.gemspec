$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "lucian_kaminari/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "lucian_kaminari"
  spec.version     = LucianKaminari::VERSION
  spec.authors     = ["lucian"]
  spec.email       = ["17607003651@163.com"]
  spec.homepage    = "https://www.baidu.com"
  spec.summary     = "Summary of LucianKaminari."
  spec.description = "Description of LucianKaminari."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  spec.files = Dir["{app,config,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 5.0.0"
end
