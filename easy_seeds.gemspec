# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require_relative "lib/easy_seeds/version"

Gem::Specification.new do |spec|
  spec.name          = "easy_seeds"
  spec.version       = "1.0.4"
  spec.authors       = ["Maxwell Fong", "Marcos Henrich"]
  spec.email         = ["mfong415@gmail.com", "jmarcoshenrich@gmail.com"]
  spec.description   = "A library for easily generating seed data in Ruby on Rails from .CSV files"
  spec.summary       = "Seed files from .CSVs for your Ruby on Rails project"
  spec.homepage      = "https://github.com/mfong4151/easy-seeds"
  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})

  spec.require_paths = ["lib"]

  spec.add_dependency "csv"
  spec.required_ruby_version = ">= 2.7.0"
  spec.metadata = {
  "source_code_uri" => "https://github.com/mfong4151/easy-seeds",
  "bug_tracker_uri" => "https://github.com/mfong4151/easy-seeds/issues",
  "documentation_uri" => "https://github.com/mfong4151/easy-seeds/blob/main/README.md"
}
end
