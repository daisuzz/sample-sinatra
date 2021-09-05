require 'faraday'
require 'sinatra'
require 'json'
require 'sinatra/json'
require 'sinatra/reloader'

module SampleSinatra

  class App < Sinatra::Base
    # change a base folder for static file
    set public_folder: "#{__dir__}/static"

    configure :production, :development do
      enable :logging
    end

    field_list = %w[userId id title body]

    get '/' do
      redirect '/index.html'
    end

    get '/posts' do
      request.env['rack.logger'].info 'access GET /posts'

      field = params.fetch(:field)

      unless field_list.include?(field)
        status 400
        body 'field not found!'
        return
      end

      posts = JSON.parse(Faraday.get('https://jsonplaceholder.typicode.com/posts').body)

      res = posts.map { |post| { "#{field}": post[field].to_s } }

      json res
    end

    get '/posts/:id' do
      request.env['rack.logger'].info 'access GET /posts/:id'

      res = JSON.parse(Faraday.get("https://jsonplaceholder.typicode.com/posts/#{params[:id]}").body)

      json res
    end
  end
end

