require 'sinatra'
require 'sequel'
require 'haml'


class Todo < Sinatra::Application

  set :environment, ENV['RACK_ENV'] #:development

  configure do

    DB = Sequel.connect("mysql2://root:1234@localhost/todo")

    #require all models
    Dir['model/*.rb'].each { |model| require_relative model }

    #load all routes
    Dir[File.join(File.dirname(__FILE__), 'routes/*.rb')].each { |route| load route }
  end
end
