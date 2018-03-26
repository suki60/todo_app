require 'sinatra'
require 'bundler/setup'
require 'pry'
require 'pry-byebug'

#require app.rb
require_relative 'app'

Bundler.require

ENV["RACK_ENV"] = "development"

run Todo.new
