# frozen_string_literal: true

require File.expand_path("../lib/fuli/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "fuli"
  s.version     = Fuli::VERSION
  s.platform    = Gem::Platform::RUBY
  s.licenses    = %w(MIT)
  s.authors     = ["Anton Magids"]
  s.email       = ["evnomadx@gmail.com"]
  s.homepage    = "https://github.com/restaurant-cheetah/fuli"
  s.summary     = "Respond to application errors with configurable notifiers."
  s.description = "Respond to application errors with configurable notifiers."  

  all_files = %x(git ls-files).split("\n")
  test_files = %x(git ls-files -- {test,spec,features}/*).split("\n")

  s.files         = all_files - test_files
  s.test_files    = test_files
  s.require_paths = %w(lib)
end
