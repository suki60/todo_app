require 'sinatra'
require 'sinatra/reloader'
require 'sequel'
require 'slim'
require 'digest'
require 'pry'
require 'pry-byebug'

class Todo < Sinatra::Application
  set :environment, ENV['RACK_ENV'] #:development

  configure do
    env = ENV['RACK_ENV']
    register Sinatra::Reloader
    also_reload 'models/*.rb'

    after_reload do
      puts 'reloaded'
    end

    # DB = Sequel.connect("mysql2://root:1234@localhost/todo")
    DB = Sequel.connect(YAML.safe_load(File.open('database.yml'))[env])

    # require all models
    Dir['models/*.rb'].each { |model| require_relative model }

    # plugin validation_helpers
    Sequel::Model.plugin :validation_helpers

    # load all routes
    Dir[File.join(File.dirname(__FILE__), 'routes/*/*.rb')].each { |route| load route }

    enable :sessions
    enable :reloader
  end
end

before do
  redirect '/login' if (!%w[login signup].include? request.path_info.split('/')[1]) && session[:user_id].nil?
end
