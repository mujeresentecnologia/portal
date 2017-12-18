#!/usr/bin/env ruby

require 'bundler'
require 'html-proofer'

task :default => :test

desc 'limpia el sitio que fue generado'
task :clean do
  rm_rf '_site'
end

desc 'hace la compilacion y genera el sitio estatico con jekyll build'
task :build => [:clean] do
  jekyll 'build -q'
end

desc 'ejecuta pruebas con html-proofer'
task :test => [:build] do
  options = { :assume_extension => true, :check_html => true, :enforce_https => true }
  HTMLProofer.check_directory("./_site", options).run
end

def jekyll(directives = '')
  sh "bundle exec jekyll #{directives}"
end