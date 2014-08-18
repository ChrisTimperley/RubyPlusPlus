# encoding: utf-8

# Load all dependencies.
require 'rubygems'
require 'bundler'
require 'rake'
require 'rake/testtask'
require 'rdoc/task'
require 'jeweler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

# Gem Specification.
Jeweler::Tasks.new do |gem|
  gem.name = "ruby_plus_plus"
  gem.homepage = "http://github.com/ChrisTimperley/RubyPlusPlus"
  gem.license = "MIT"
  gem.summary = "Source code transformation tool for automatically translating Ruby programs into C++."
  gem.description = <<-EOF
    A Ruby-based source code transformation tool, used for automatically translating Ruby programs into
    C++ equivalents.
  EOF
  gem.email = "christimperley@gmail.com"
  gem.author = "Chris Timperley"
end

# Gem Management.
Jeweler::RubygemsDotOrgTasks.new

# Unit Testing.
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

# Documentation.
task :default => :test
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "revac #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end