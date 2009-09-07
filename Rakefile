require 'rubygems'
require 'rake/gempackagetask'
require 'fileutils'
require 'ftools'
require 'rake/testtask'
require 'lib/jretlang/version'
include FileUtils

task :default => :test

Rake::TestTask.new do |t|
  t.libs << "test/unit"
  t.test_files = FileList['test/unit/**/test*.rb']
end

