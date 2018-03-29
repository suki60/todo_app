require 'sinatra'
require 'sinatra/reloader'
require 'sequel'
require 'haml'
require 'digest'
require 'pry'
require 'pry-byebug'


class Todo < Sinatra::Application
  set :environment, ENV['RACK_ENV'] #:development

  configure do
    env = ENV['RACK_ENV']
    register Sinatra::Reloader

    after_reload do
      puts 'reloaded'
    end

    #DB = Sequel.connect("mysql2://root:1234@localhost/todo")
    DB = Sequel.connect(YAML.load(File.open('database.yml'))[env])

    #require all models
    Dir['models/*.rb'].each { |model| require_relative model }

    #load all routes
    Dir[File.join(File.dirname(__FILE__), 'routes/*.rb')].each { |route| load route }

    enable :sessions
    enable :reloader
  end
end


before do

  if (!['login', 'signup'].include? request.path_info.split('/')[1]) && session[:user_id].nil?
    redirect '/login'
  end
end
