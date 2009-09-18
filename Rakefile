require 'rubygems'
require 'rake/gempackagetask'
require 'fileutils'
require 'ftools'
require 'rake/testtask'
require 'jeweler'
include FileUtils

task :default => :test

Jeweler::Tasks.new do |gemspec|
  gemspec.name = "jretlang"
  gemspec.summary = "A JRuby package of jretlang"
  gemspec.description = gemspec.summary
  gemspec.email = "reevesg@pobox.com"
  gemspec.homepage = "http://github.com/reevesg/jretlang"
  gemspec.authors = ["Gareth Reeves"]
end


Rake::TestTask.new do |t|
  t.libs << "test/unit"
  t.test_files = FileList['test/unit/**/test*.rb']
end

desc "Update the change log."
task :change_log do 
  %x[git log --pretty=short --grep=release > changelog]
  %x[git commit changelog --amend --reuse-message HEAD]
end
