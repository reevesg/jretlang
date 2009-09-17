require 'rubygems'
require 'rake/gempackagetask'
require 'fileutils'
require 'ftools'
require 'rake/testtask'
require 'lib/jretlang/version'
include FileUtils
 
task :default => :test

NAME = "jretlang"
VERS = JRL::VERSION
PKG = "#{NAME}-#{VERS}"
JARS = Dir.glob("vendor/*.jar")
PKG_FILES = JARS + Dir.glob("lib/**/*.rb")

SPEC = Gem::Specification.new do |s|
  s.name = NAME
  s.version = VERS
  s.platform = Gem::Platform::CURRENT
  s.summary = "JRuby wrapper for jetlang (jetlang.org)"
  s.description = s.summary
  s.author = "greeves"
  s.has_rdoc = true
  s.email = "reevesg@pobox.com"
  s.files = PKG_FILES
end

task :default => :test

Rake::TestTask.new do |t|
  t.libs << "test/unit"
  t.test_files = FileList['test/unit/**/test*.rb']
end

Rake::GemPackageTask.new(SPEC) do |pkg|
  pkg.need_zip = false
  pkg.need_tar = false
end

desc "Package and install the gem."
task :p => [:gem] do 
  puts "Installing jretlang gem..."
  %x[jgem install -V pkg/*.gem]
end

desc "Clean project files."
task :clean do
  rm_rf 'pkg'
end

desc "Update the change log."
task :change_log do 
  %x[git log --pretty=short --grep=release > changelog]
  %x[git commit changelog --amend --reuse-message HEAD]
end
