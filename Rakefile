#!/usr/bin/env ruby

require 'bundler'
require 'html-proofer'

task :default => :test

task :test do
  options = { :assume_extension => true, :check_html => true, :enforce_https => true }
  HTMLProofer.check_directory("./_site", options).run
end
