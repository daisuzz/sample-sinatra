require 'faraday'
require 'sinatra'
require 'json'
require 'sinatra/json'
require 'sinatra/reloader'
require 'securerandom'

module SampleSinatra

  class App < Sinatra::Base
    configure :production, :development do
      enable :logging
    end

    todos_repo = []
    todo1 = {
      id: SecureRandom.uuid,
      title: '食べる',
      due_date: '2021-01-01'
    }

    todo2 = {
      id: SecureRandom.uuid,
      title: '走る',
      due_date: '2021-01-01'
    }

    todo3 = {
      id: SecureRandom.uuid,
      title: '寝る',
      due_date: '2021-01-01'
    }

    todos_repo << todo1
    todos_repo << todo2
    todos_repo << todo3

    get '/' do
      @todos = todos_repo
      puts @todos
      erb :index
    end

    post '/todo/create' do
      @title = params[:title]
      @due_date = params[:due_date]
      new_todo = {
        id: SecureRandom.uuid,
        title: @title,
        due_date: @due_date
      }
      todos_repo << new_todo
      @todos = todos_repo
      erb :index
    end
  end
end

