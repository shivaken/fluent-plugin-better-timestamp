# encoding: utf-8
$:.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = "fluent-plugin-better-timestamp"
  gem.description = "Output filter plugin which put timestamp"
  gem.homepage    = "https://github.com/shivaken/fluent-plugin-better-timestamp"
  gem.summary     = gem.description
  gem.version     = File.read("VERSION").strip
  gem.authors     = ["Kenichi Otsuka"]
  gem.email       = "shivaken@gmail.com"
  gem.has_rdoc    = false
  #gem.platform    = Gem::Platform::RUBY
  gem.license     = 'MIT'
  gem.files       = `git ls-files`.split("\n")
  gem.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ['lib']

  gem.add_dependency "fluentd", "~> 0.10.17"
  gem.add_dependency "fluent-mixin-config-placeholders", ">= 0.3.0"
  gem.add_development_dependency "rake", ">= 0.9.2"
end
