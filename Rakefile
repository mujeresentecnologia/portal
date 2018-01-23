#!/usr/bin/env ruby

require 'bundler'
require 'html-proofer'
require 'rspec/core/rake_task'

task :default => :test

desc 'limpia el sitio que fue generado'
task :clean do
  rm_rf '_site'
end

# Staging environment tasks
desc 'hace la compilacion y genera el sitio estatico con jekyll build con configuraciones de staging'
task :build_staging do
  jekyll 'build -q --config _config.yml,_config-staging.yml --drafts'
end

desc 'ejecuta el sitio localmente con jekyll serve con las configuraciones de staging'
task :preview_staging => [:clean] do
  jekyll 'serve --config _config.yml,_config-staging.yml --watch --drafts'
end

# Production environment tasks
desc 'hace la compilacion y genera el sitio estatico con jekyll build'
task :build do
  jekyll 'build -q'
end

desc 'ejecuta el sitio localmente con jekyll serve'
task :preview => [:clean] do
  jekyll 'serve --watch'
end

# Pruebas
desc 'ejecuta pruebas con html-proofer'
task :test_html do
  options = { :assume_extension => true, :check_html => true, :enforce_https => false }
  HTMLProofer.check_directory("./_site", options).run
end

desc 'ejecuta pruebas unitarias'
RSpec::Core::RakeTask.new(:spec) do |t|
  puts 'Ejecutando pruebas unitarias'
  t.pattern = '_' + t.pattern
  t.verbose = false
end

desc 'ejecuta pruebas de html y las pruebas unitarias'
task :test do
  if ENV['ENTORNO'] == "staging-env"; then
	Rake::Task["build_staging"].invoke
  else
	Rake::Task["build"].invoke
  end
  Rake::Task["test_html"].invoke
  Rake::Task["spec"].invoke
end

desc 'ejecuta todas las pruebas para ambiente staging y para ambiente prod'
task :test_all do
  run_all_tests
end

# Helper

def run_all_tests
  sh "ENTORNO=staging-env rake test && ENTORNO=prod rake test"
end

def jekyll(directives = '')
  sh "bundle exec jekyll #{directives}"
end
