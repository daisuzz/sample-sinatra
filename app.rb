require 'faraday'
require 'sinatra'
require 'json'
require 'sinatra/json'
require 'sinatra/reloader'
require 'securerandom'
require 'mysql2-cs-bind'

module SampleSinatra

  class App < Sinatra::Base
    configure :production, :development do
      enable :logging
    end

    class MySQLConnectionEnv
      def connect_db
        Mysql2::Client.new(
          host: '127.0.0.1',
          port: 3306,
          username: 'user',
          password: 'password',
          database: 'sample')
      end
    end

    helpers do
      def db
        Thread.current[:db] ||= MySQLConnectionEnv.new.connect_db
      end
    end

    get '/' do
      @todos = fetch_todos
      erb :index
    end

    post '/todo/create' do
      @title = params[:title]
      @due_date = params[:due_date]
      db.xquery('INSERT INTO todo (id, title, dueDate) VALUES (?, ?, ?)',
                SecureRandom.uuid,
                @title,
                DateTime.parse(@due_date).to_s)
      redirect '/'
    end

    def fetch_todos
      todos = []
      rows = db.query('SELECT * FROM todo')
      rows.each do |row|
        todos << {
          id: row['id'],
          title: row['title'],
          due_date: Date.parse(row['dueDate'].to_s),
          is_done: row['isDone']
        }
      end
      todos
    end
  end
end

