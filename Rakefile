require 'rubygems'
require 'rake/gempackagetask'
require 'fileutils'
require 'ftools'
require 'rake/testtask'
require 'lib/jretlang/version'
include FileUtils

SPEC = eval IO.read( 'jretlang.gem_spec' ) 
 
task :default => :test

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
