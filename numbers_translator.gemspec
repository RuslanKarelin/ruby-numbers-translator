
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "numbers_translator/version"

Gem::Specification.new do |spec|
  spec.name          = "numbers_translator"
  spec.version       = NumbersTranslator::VERSION
  spec.authors       = ["Ruslan Karelin"]
  spec.email         = ["ruslankarelin68@yandex.ru"]

  spec.summary       = %q{numbers translator}
  spec.description   = %q{Translating numbers into English}
  spec.homepage      = "https://github.com/RuslanKarelin/ruby-numbers-translator"
  spec.license       = "MIT"

  if spec.respond_to?(:metadata)
    spec.metadata["homepage_uri"] = spec.homepage
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
