require 'sinatra'
require 'bundler/setup'

# require app.rb
require_relative 'app'

# check gems installed
Bundler.require

ENV['RACK_ENV'] = 'development'

# run rackup
run Todo
